//
//  SSAPI.m
//  soselfie
//
//  Created by Tom van Kruijsbergen on 18/02/14.
//  Copyright (c) 2014 TYG Digital. All rights reserved.
//

#import "SSAPI.h"
#import "TYGURL.h"
#import "Base64.h"
#import <FacebookSDK/FacebookSDK.h>

@implementation SSAPI





+(void)getImageWithImageURL:(NSString *)imageURL onComplete:(void (^)(UIImage *image, NSError *error))onComplete {
    
    NSDictionary *options = @{@"forcereload": @NO};
    
    [TYGURLLoader handleURL:[NSString stringWithFormat:@"%@", imageURL] method:TYGURLMethodGet options:options onComplete:^(NSDictionary *data) {
        
        
        UIImage *image = [UIImage imageWithData:data[@"data"]];
        onComplete(image, nil);
        
    } onFail:^(NSDictionary *data) {
        
        onComplete(nil, [NSError errorWithDomain:@"Image Load Error" code:[data[@"error"] code] userInfo:@{@"message": [NSString stringWithFormat:@"Could not load image url %@", imageURL]}]);
        
    }];
}



//used in many API functions to check if a user is in fact logged in.
+(BOOL)hasFBCredentials {
    if (FBID == nil) return NO;
    if (([FBSession activeSession].state & FB_SESSIONSTATEOPENBIT) == false) return NO;
    if ([FBSession activeSession].accessTokenData.accessToken == nil) return NO;
    
    return YES;
}






static NSString *FBID = nil;
static NSArray *BIRTHDAY = nil; //0 = day, 1 = month, 2 = year. This could potentially be an NSDate object?
static SSUserGender GENDER = SSUserGenderUnknown;

+(NSString*)fbid {
    return FBID;
}





#pragma mark - LOGIN




+(void)logInToFacebookOnComplete:(void(^)(NSString *fbid, NSString* accessToken, BOOL couldRetrieveGender, BOOL couldRetrieveBirthday, NSError *error))onComplete {
    
    //[[FBSession activeSession] closeAndClearTokenInformation];
    NSArray *permissions = @[@"basic_info", @"user_birthday"];
    
    [FBSession openActiveSessionWithReadPermissions:permissions allowLoginUI:YES completionHandler:^(FBSession *session, FBSessionState state, NSError *error) {
        
        //this block is called every time the session changes a state, including when it gets closed. Since this block should really only happen to a FBSession that is still alive (= not closed), we check for it here.
        if (state & FB_SESSIONSTATETERMINALBIT) return;
        
        if (error != nil) {
            onComplete(nil, nil, false, false, error);
            return;
        }
        
        [[FBRequest requestForMe] startWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError* error) {
            //NSLog(@"result %@", result);
            
            if (error != nil) {
                onComplete(nil, nil, false, false, error);
                return;
            }
            
            BOOL couldRetrieveBirthday = false;
            if (result[@"birthday"] != nil) {
                NSString *birthday = result[@"birthday"];
                NSArray *a = [birthday componentsSeparatedByString:@"/"];
                if (a.count == 3) {
                    BIRTHDAY = [NSArray arrayWithObjects:a[2], a[0], a[1], nil];
                    couldRetrieveBirthday = true;
                }
                
            }
            
            BOOL couldRetrieveGender = false;
            if (result[@"gender"] != nil) {
                NSString *gender = result[@"gender"];
                if ([gender isEqualToString:@"male"]) GENDER = SSUserGenderMale;
                if ([gender isEqualToString:@"female"]) GENDER = SSUserGenderFemale;
                if (GENDER != 0) couldRetrieveGender = true;
            }
            
            
            NSString *fbid = result[@"id"];
            FBID = fbid;
            
            onComplete(FBID, FBSession.activeSession.accessTokenData.accessToken, couldRetrieveGender, couldRetrieveBirthday, nil);
            
        }];
        
    }];
    
}


+(void)setUserBirthday:(NSString *)day month:(NSString *)month year:(NSString *)year {
    NSArray *a = [NSArray arrayWithObjects:year, month, day, nil];
    BIRTHDAY = a;
}
+(void)setUserGender:(SSUserGender)gender {
    GENDER = gender;
}

+(NSArray*)isProfileInfoReadyToBeSentToServer {
    NSMutableArray *a = [@[] mutableCopy];
    
    if (FBID == nil) [a addObject:@"fbid"];
    if (FBSession.activeSession.accessTokenData.accessToken == nil) [a addObject:@"accesstoken"];
    if (BIRTHDAY == nil) [a addObject:@"birthday"];
    if (GENDER == SSUserGenderUnknown) [a addObject:@"gender"];
    
    return a;
}


+(void)sendProfileInfoToServerWithonComplete:(void(^)(BOOL success, NSError *possibleError))onComplete {
    
    if ([self isProfileInfoReadyToBeSentToServer].count != 0) {
        onComplete(false, [NSError errorWithDomain:@"SSAPI" code:0 userInfo:@{@"message": @"One or more variables are null. See userinfo[@\"missing\"] for more info.", @"missing": [self isProfileInfoReadyToBeSentToServer]}]);
    }
    
    NSString *s = [BIRTHDAY componentsJoinedByString:@"-"];
    
    NSString *url = [NSString stringWithFormat:@"%@/user_insert.php?fbid=%@&accesstoken=%@&birthday=%@&gender=%i", SSAPI_BASEURL, FBID, FBSession.activeSession.accessTokenData.accessToken, s, GENDER];
    NSDictionary *options = @{@"forcereload": @YES};
    
    NSLog(@"sending url %@", url);
    
    [TYGURLLoader handleURL:url method:TYGURLMethodGet options:options onComplete:^(NSDictionary *data) {
        
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data[@"data"] options:0 error:nil];
        
        NSLog(@"load result %@", result);
        
        if (result == nil) {
            onComplete(false, [NSError errorWithDomain:@"DataBaseError" code:0 userInfo:@{@"message": @"There was an unknown error."}]);
            return;
        }
        
        if (result[@"error"] != nil) {
            onComplete(false, [NSError errorWithDomain:result[@"error"][@"type"] code:0 userInfo:@{@"message": result[@"error"][@"message"]}]);
            return;
        }
        
        //you could analyse the contents of result[@"data"] here if needed.
        onComplete(true, nil);
        
        
    } onFail:nil];
}





#pragma mark - UPLOAD SELFIE






+(void)uploadSelfieWith768x768Image:(UIImage *)image onComplete:(void (^)(NSString *, NSString *, NSString *, NSError *))onComplete {
    
    if ([self hasFBCredentials] == false) {
        NSError *error = [NSError errorWithDomain:@"FB Login error" code:0 userInfo:@{@"message": @"You are not currently logged in."}];
        onComplete(nil, nil, nil, error);
        return;
    }
    
    NSString *url = [NSString stringWithFormat:@"%@/image_upload.php?fbid=%@&accesstoken=%@", SSAPI_BASEURL, FBID, [FBSession activeSession].accessTokenData.accessToken];
    
    NSLog(@"sending to url %@", url);
    
    [Base64 initialize];
    
    NSMutableString *imageDataString = [@"" mutableCopy];
    NSData *imageData = UIImageJPEGRepresentation(image, 1);
    [imageDataString appendString:[Base64 encode:imageData]];
    
    [imageDataString appendString:@"****"];
    
    UIImage *thumb = [self create320x320thumbOfImage:image];
    imageData = UIImageJPEGRepresentation(thumb, 1);
    [imageDataString appendString:[Base64 encode:imageData]];
    
    //NSLog(@"post data %@", imageDataString);
    
    
    imageData = [imageDataString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *options = @{@"postdata": imageData};
    
    [TYGURLLoader handleURL:url method:TYGURLMethodPost options:options onComplete:^(NSDictionary *data) {
        
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data[@"data"] options:0 error:nil];
        if (result == nil) {
            NSLog(@"result %@", [[NSString alloc] initWithData:data[@"data"] encoding:NSUTF8StringEncoding]);
        } else {
            
            
            
            if (result[@"error"] != nil) {
                
                NSError *e = [NSError errorWithDomain:result[@"error"][@"type"] code:0 userInfo:@{@"message": result[@"error"][@"message"]}];
                
                onComplete(nil, nil, nil, e);
                
                return;
            }
            
            
            onComplete(result[@"data"][@"id"], result[@"data"][@"url"], result[@"data"][@"url_small"], nil);
            
        }
        
        
    } onFail:nil];
    
}

+(UIImage*)create320x320thumbOfImage:(UIImage*)originalImage {
    CGSize destinationSize = CGSizeMake(320, 320);
    UIGraphicsBeginImageContext(destinationSize);
    [originalImage drawInRect:CGRectMake(0,0,destinationSize.width,destinationSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}






#pragma mark - OWN SELFIES




+(void)getOwnSelfiesStartingFromIndex:(int)index onComplete:(void (^)(int totalSelfies, NSArray *images, NSError *error))onComplete {
    
    if ([self hasFBCredentials] == false) {
        NSError *error = [NSError errorWithDomain:@"FB Login error" code:0 userInfo:@{@"message": @"You are not currently logged in."}];
        onComplete(0, nil, error);
        return;
    }
    
    
    NSString *url = [NSString stringWithFormat:@"%@/user_images.php?fbid=%@&accesstoken=%@&startindex=%i", SSAPI_BASEURL, FBID, [FBSession activeSession].accessTokenData.accessToken, index];
    
    NSDictionary *options = @{@"forcereload": @YES};
    
    NSLog(@"sending url %@", url);
    
    [TYGURLLoader handleURL:url method:TYGURLMethodGet options:options onComplete:^(NSDictionary *data) {
        
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data[@"data"] options:0 error:nil];
        
        //NSLog(@"load result %@", result);
        
        if (result == nil) {
            onComplete(0, nil, [NSError errorWithDomain:@"DataBaseError" code:0 userInfo:@{@"message": @"There was an unknown error."}]);
            return;
        }
        
        if (result[@"error"] != nil) {
            onComplete(0, nil, [NSError errorWithDomain:result[@"error"][@"type"] code:0 userInfo:@{@"message": result[@"error"][@"message"]}]);
            return;
        }
        
        
        onComplete([result[@"data"][@"total"] intValue], result[@"data"][@"images"], nil);
        
        
    } onFail:nil];
    
    
    
}




+(void)eraseSelfieID:(NSString*)selfieID onComplete:(void(^)(BOOL success, NSError *possibleError))onComplete {
    if ([self hasFBCredentials] == false) {
        NSError *error = [NSError errorWithDomain:@"FB Login error" code:0 userInfo:@{@"message": @"You are not currently logged in."}];
        onComplete(0, error);
        return;
    }
    
    
    NSString *url = [NSString stringWithFormat:@"%@/image_erase.php?fbid=%@&accesstoken=%@&image=%@", SSAPI_BASEURL, FBID, [FBSession activeSession].accessTokenData.accessToken, selfieID];
    
    NSDictionary *options = @{@"forcereload": @YES};
    
    NSLog(@"sending url %@", url);
    
    [TYGURLLoader handleURL:url method:TYGURLMethodGet options:options onComplete:^(NSDictionary *data) {
        
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data[@"data"] options:0 error:nil];
        
        
        if (result == nil) {
            onComplete(0, [NSError errorWithDomain:@"DataBaseError" code:0 userInfo:@{@"message": @"There was an unknown error."}]);
            return;
        }
        
        if (result[@"error"] != nil) {
            onComplete(0, [NSError errorWithDomain:result[@"error"][@"type"] code:0 userInfo:@{@"message": result[@"error"][@"message"]}]);
            return;
        }
        
        
        onComplete(1, nil);
        
        
    } onFail:nil];
    
}





#pragma mark - VOTE SELFIE

+(void)getRandomSelfieForMinimumAge:(int)minimumAge andMaximumAge:(int)maximumAge andGenders:(SSUserGender)genders onComplete:(void(^)(NSString *selfieID, NSString *ownerfbid, NSString *imageURL, NSString *imageURLsmall, NSString *imageAccessToken, NSDictionary *votes, NSError *error))onComplete {
    
    if ([self hasFBCredentials] == false) {
        NSError *error = [NSError errorWithDomain:@"FB Login error" code:0 userInfo:@{@"message": @"You are not currently logged in."}];
        onComplete(nil, nil, nil, nil, nil, nil, error);
        return;
    }
    
    
    NSString *url = [NSString stringWithFormat:@"%@/image_random.php?fbid=%@&accesstoken=%@&gender=%i&agemin=%i&agemax=%i", SSAPI_BASEURL, FBID, [FBSession activeSession].accessTokenData.accessToken, genders, minimumAge, maximumAge];
    
    NSDictionary *options = @{@"forcereload": @YES};
    
    NSLog(@"sending url %@", url);
    
    [TYGURLLoader handleURL:url method:TYGURLMethodGet options:options onComplete:^(NSDictionary *data) {
        
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data[@"data"] options:0 error:nil];
        
        
        if (result == nil) {
            onComplete(nil, nil, nil, nil, nil, nil, [NSError errorWithDomain:@"DataBaseError" code:0 userInfo:@{@"message": @"There was an unknown error."}]);
            return;
        }
        if (result[@"error"] != nil) {
            onComplete(nil, nil, nil, nil, nil, nil, [NSError errorWithDomain:result[@"error"][@"type"] code:0 userInfo:@{@"message": result[@"error"][@"message"]}]);
            return;
        }
        
        //NSLog(@"result %@", result);
        
        if ([result[@"data"][@"total"] intValue] == 0) {
            onComplete(nil, nil, nil, nil, nil, nil, [NSError errorWithDomain:@"No more images" code:0 userInfo:@{@"message": @"No more images to show."}]);
            return;
        }
        
        NSDictionary *d = result[@"data"][@"image"];
        NSDictionary *votes = @{@"funny" : d[@"votes_funny"],
                                @"hot" : d[@"votes_hot"],
                                @"lame" : d[@"votes_lame"],
                                @"weird" : d[@"votes_weird"],};
        
        onComplete(d[@"id"], d[@"user"][@"fbid"], d[@"url"], d[@"url_small"], d[@"accesstoken"], votes, nil);
        
        
    } onFail:nil];
    
}








+(void)voteForSelfieID:(NSString*)selfieID andImageAccessToken:(NSString*)imageAccessToken andVote:(SSVoteType)vote onComplete:(void(^)(BOOL success, NSError *possibleError))onComplete {
    
    if ([self hasFBCredentials] == false) {
        NSError *error = [NSError errorWithDomain:@"FB Login error" code:0 userInfo:@{@"message": @"You are not currently logged in."}];
        onComplete(false, error);
        return;
    }
    
    NSString *url = [NSString stringWithFormat:@"%@/image_vote.php?fbid=%@&accesstoken=%@&image=%@&imageaccesstoken=%@&vote=%i", SSAPI_BASEURL, FBID, [FBSession activeSession].accessTokenData.accessToken, selfieID, imageAccessToken, vote];
    
    NSDictionary *options = @{@"forcereload": @YES};
    
    NSLog(@"sending url %@", url);
    
    
    [TYGURLLoader handleURL:url method:TYGURLMethodGet options:options onComplete:^(NSDictionary *data) {
        
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data[@"data"] options:0 error:nil];
        
        
        if (result == nil) {
            onComplete(false, [NSError errorWithDomain:@"DataBaseError" code:0 userInfo:@{@"message": @"There was an unknown error."}]);
            return;
        }
        if (result[@"error"] != nil) {
            onComplete(false, [NSError errorWithDomain:result[@"error"][@"type"] code:0 userInfo:@{@"message": result[@"error"][@"message"]}]);
            return;
        }
        
        onComplete(true, nil);
        
        
    } onFail:nil];
    
    
}




#pragma mark - TOP SELFIES

+(void)getTopSelfiesForMinimumAge:(int)minimumAge andMaximumAge:(int)maximumAge andGenders:(SSUserGender)genders andVoteCategory:(SSVoteType)category startingFromIndex:(int)index onComplete:(void(^)(int totalSelfies, NSArray *images, NSError *error))onComplete {
    
    if ([self hasFBCredentials] == false) {
        NSError *error = [NSError errorWithDomain:@"FB Login error" code:0 userInfo:@{@"message": @"You are not currently logged in."}];
        onComplete(0, nil, error);
        return;
    }
    
    NSString *url = [NSString stringWithFormat:@"%@/image_top.php?startindex=%i&votetype=%i&gender=%i&agemin=%i&agemax=%i&fbid=%@&accesstoken=%@", SSAPI_BASEURL, index, category,genders, minimumAge, maximumAge, FBID, [FBSession activeSession].accessTokenData.accessToken];
    
    NSDictionary *options = @{@"forcereload": @YES};
    
    NSLog(@"sending url %@", url);
    
    
    [TYGURLLoader handleURL:url method:TYGURLMethodGet options:options onComplete:^(NSDictionary *data) {
        
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data[@"data"] options:0 error:nil];
        
        
        if (result == nil) {
            onComplete(0, nil, [NSError errorWithDomain:@"DataBaseError" code:0 userInfo:@{@"message": @"There was an unknown error."}]);
            return;
        }
        if (result[@"error"] != nil) {
            onComplete(0, nil, [NSError errorWithDomain:result[@"error"][@"type"] code:0 userInfo:@{@"message": result[@"error"][@"message"]}]);
            return;
        }
        
        //NSLog(@"result %@", result);
        
        onComplete([result[@"data"][@"total"] intValue], result[@"data"][@"images"], nil);
        
        
    } onFail:nil];
    
}




@end