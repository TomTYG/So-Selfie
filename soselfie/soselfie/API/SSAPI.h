//
//  SSAPI.h
//  soselfie
//
//  Created by Tom van Kruijsbergen on 18/02/14.
//  Copyright (c) 2014 TYG Digital. All rights reserved.
//

#import <Foundation/Foundation.h>

#define SSAPI_BASEURL @"https://so-selfie.com/api"

typedef NS_ENUM(int, SSUserGender) {
    SSUserGenderUnknown = 0,
    SSUserGenderMale = 1 << 1,
    SSUserGenderFemale = 1 << 2
};

typedef NS_ENUM(int, SSVoteType) {
    SSVoteTypeUnknown = 0,
    SSVoteTypeFunny,
    SSVoteTypeHot,
    SSVoteTypeLame,
    SSVoteTypeTryAgain,
    SSVoteTypeInappropriate
};


@interface SSAPI : NSObject


/*  
    TODO: 
    - each function now requires a NSString *fbid and NSString *fbAccessToken. This can be instead called from the function in question.
 
 */



//MULTIPURPOSE
+(void)getImageWithImageURL:(NSString*)imageURL
                 onComplete:(void(^)(UIImage *image, NSError *error))onComplete;


//LOGIN VIEW FUNCTIONS

//you can call this function even when logged in. It will just return immediately in that case.
+(void)logInToFacebookOnComplete:(void(^)(NSString *fbid, NSString* accessToken, BOOL couldRetrieveGender, BOOL couldRetrieveAge, NSError *error))onComplete;

+(void)setUserAge:(int)age;
+(void)setUserGender:(SSUserGender)gender;

//if everything worked, the resulting NSError is nil.
+(void)sendProfileInfoToServerWithFBid:(NSString*)fbid
                        andAccessToken:(NSString*)accessToken
                                andAge:(int)age
                             andGender:(SSUserGender)gender
                            onComplete:(void(^)(NSError *possibleError))onComplete;


//VOTE VIEW

//the NSDictionary returned has keys of SSAPIVotesKeys. Each element is either an NSNumber, or possibly an object with ( NSNumber *votes, NSNumber *rank ).
+(void)getRandomSelfieForFBid:(NSString*)fbid
               andAccessToken:(NSString*)accessToken
                andMinimumAge:(int)minimumAge
                andMaximumAge:(int)maximumAge
                   andGenders:(SSUserGender)genders
                   onComplete:(void(^)(NSString *selfieID, NSString *imageURL, NSString *imageAccessToken, NSDictionary *votes, NSError *error))onComplete;

+(void)voteForSelfieAsFBid:(NSString*)fbid
            andAccessToken:(NSString*)accessToken
               andSelfieID:(NSString*)selfieID
       andImageAccessToken:(NSString*)imageAccessToken
                   andVote:(SSVoteType)vote
                onComplete:(void(^)(BOOL success))onComplete;



//OWN SELFIES VIEW

//the NSArray returns, sorted by date, newest first, a NSDictionary with ( NSString* selfieID, NSString* selfieURL, NSDictionary *votes)
+(void)getOwnSelfiesForFBid:(NSString*)fbid
             andAccessToken:(NSString*)accessToken
          startingFromIndex:(int)index
                 onComplete:(void(^)(int totalSelfies, NSArray *images, NSError *error))onComplete;

//if the function was a success, the NSError returned is nil.
+(void)eraseSelfieForFBid:(NSString*)fbid
           andAccessToken:(NSString*)accessToken
              andSelfieID:(NSString*)selfieID
               onComplete:(void(^)(NSError *possibleError))onComplete;


//TOP SELFIES VIEW

//the NSArray returns, sorted by date, newest first, a NSDictionary with ( NSString* selfieID, NSString* selfieURL, NSDictionary *votes)
+(void)getTopSelfiesForFBid:(NSString*)fbid
             andAccessToken:(NSString*)accessToken
            andVoteCategory:(SSVoteType)category
          startingFromIndex:(int)index
                 onComplete:(void(^)(int totalSelfies, NSArray *images, NSError *error))onComplete;

//if the returned accessToken is null, then that means this user cannot vote on it. You should only call this function if you intend to vote on an image.
+(void)getImageAccessTokenForFBid:(NSString*)fbid
                   andAccessToken:(NSString*)accessToken
                      andSelfieID:(NSString*)selfieID
                       onComplete:(void(^)(NSString *accessToken, NSError *error))onComplete;




//SHOOT SELFIE VIEW

+(void)uploadSelfieForFBid:(NSString*)fbid
            andAccessToken:(NSString*)accessToken
                  andImage:(UIImage*)image
                onComplete:(void(^)(NSString *newSelfieID, NSString* newSelfieURL, NSError *error))onComplete;








@end
