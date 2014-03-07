//
//  SSAPI.h
//  soselfie
//
//  Created by Tom van Kruijsbergen on 18/02/14.
//  Copyright (c) 2014 TYG Digital. All rights reserved.
//

#import <Foundation/Foundation.h>

#define SSAPI_BASEURL @"https://so-selfie.com/api"

//SSUserGender is a bitmask. This means a single SSUserGender can include both male and female.
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





//MULTIPURPOSE
+(void)getImageWithImageURL:(NSString*)imageURL
                 onComplete:(void(^)(UIImage *image, NSError *error))onComplete;


+(int)agemin;
+(int)agemax;
+(SSUserGender)genders;

+(void)setAgemin:(int)agemin;
+(void)setAgemax:(int)agemax;
+(void)setGenders:(SSUserGender)genders;




//LOGIN VIEW FUNCTIONS

+(NSString*)fbid;
+(BOOL)canLoginToFacebookWithoutPromptingUser;
//you can call this function even when logged in. It will just return immediately in that case.
+(void)doesUserAlreadyExistInDatabase:(NSString*)fbid onComplete:(void(^)(BOOL userExists, NSError *possibleError))onComplete;

+(void)logInToFacebookOnComplete:(void(^)(NSString *fbid, NSString* accessToken, BOOL couldRetrieveGender, BOOL couldRetrieveBirthday, NSError *error))onComplete;

+(void)setUserBirthday:(NSString*)day month:(NSString*)month year:(NSString*)year;
+(void)setUserGender:(SSUserGender)gender;

//this returns an array with string elements for each variable missing.
+(NSArray*)isProfileInfoReadyToBeSentToServer;

//if everything worked, success is true and possibleError is nil. If success is false, possibleError contains information about the nature of the error.
+(void)sendProfileInfoToServerWithonComplete:(void(^)(BOOL success,  NSError *possibleError))onComplete;


+(void)getProfilePictureOfUser:(NSString*)fbid withSize:(CGSize)size onComplete:(void(^)(UIImage *image, NSError *error))onComplete;
+(void)getUserFullName:(NSString*)fbid onComplete:(void(^)(NSString *fullName, NSError *error))onComplete;



+(void)eraseCurrentUserOnComplete:(void(^)(BOOL success, NSError *possibleError))onComplete;
+(void)logOutCurrentUser;


//VOTE VIEW

//the NSDictionary returned has keys of SSAPIVotesKeys. Each element is either an NSNumber, or possibly an object with ( NSNumber *votes, NSNumber *rank ).
+(void)getRandomSelfieForMinimumAge:(int)minimumAge
                      andMaximumAge:(int)maximumAge
                         andGenders:(SSUserGender)genders
                         excludeIDs:(NSArray*)excludes
                         onComplete:(void(^)(NSDictionary *imageData, NSError *error))onComplete;
/*
+(void)getRandomSelfieForMinimumAge:(int)minimumAge
                      andMaximumAge:(int)maximumAge
                         andGenders:(SSUserGender)genders
                         onComplete:(void(^)(NSString *selfieID, NSString *ownerfbid, NSString *imageURL, NSString *imageURLsmall, NSString *imageAccessToken, NSDictionary *votes, NSError *error))onComplete;
 */

+(void)voteForSelfieID:(NSString*)selfieID
   andImageAccessToken:(NSString*)imageAccessToken
               andVote:(SSVoteType)vote
            onComplete:(void(^)(BOOL success, NSError *possibleError))onComplete;






//OWN SELFIES VIEW


//the NSArray returns, sorted by date, newest first, a NSDictionary with ( NSString* selfieID, NSString* selfieURL, NSDictionary *votes)

+(void)getOwnSelfiesStartingFromIndex:(int)index
                           onComplete:(void(^)(int totalSelfies, NSArray *images, NSError *error))onComplete;

//if the function was a success, the NSError returned is nil.
+(void)eraseSelfieID:(NSString*)selfieID
          onComplete:(void(^)(BOOL success, NSError *possibleError))onComplete;






//TOP SELFIES VIEW

//the NSArray returns, sorted by date, newest first, a NSDictionary with ( NSString* selfieID, NSString* selfieURL, NSDictionary *votes)
+(void)getTopSelfiesForMinimumAge:(int)minimumAge
                    andMaximumAge:(int)maximumAge
                       andGenders:(SSUserGender)genders
                  andVoteCategory:(SSVoteType)category
                startingFromIndex:(int)index
                       onComplete:(void(^)(int totalSelfies, NSArray *images, NSError *error))onComplete;

//if the returned accessToken is null, then that means this user cannot vote on it. You should only call this function if you intend to vote on an image.
/*+(void)getImageAccessTokenForFBid:(NSString*)fbid
                   andAccessToken:(NSString*)accessToken
                      andSelfieID:(NSString*)selfieID
                       onComplete:(void(^)(NSString *accessToken, NSError *error))onComplete;*/





//SHOOT SELFIE VIEW
+(void)uploadSelfieWith768x768Image:(UIImage*)image
                onComplete:(void(^)(NSString *newSelfieID, NSString* newSelfieURL, NSString *newSelfieThumbURL, NSError *error))onComplete;








@end
