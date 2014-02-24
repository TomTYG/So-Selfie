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

@implementation SSAPI

+(void)uploadSelfieForFBid:(NSString*)fbid
            andAccessToken:(NSString*)accessToken
                  andImage:(UIImage*)image
                onComplete:(void(^)(NSString *newSelfieID, NSString* newSelfieURL, NSError *error))onComplete {
    
    
    NSString *url = [NSString stringWithFormat:@"%@/upload_image.php?fbid=%@&accesstoken=%@", SSAPI_BASEURL, fbid, accessToken];
    
    NSLog(@"sending to url %@", url);
    
    
    NSData *imageData = UIImageJPEGRepresentation(image, 1);
    [Base64 initialize];
    imageData = [[Base64 encode:imageData] dataUsingEncoding:NSUTF8StringEncoding];
    
    NSDictionary *options = @{@"postdata": imageData};
    
    [TYGURLLoader handleURL:url method:TYGURLMethodPost options:options onComplete:^(NSDictionary *data) {
        
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data[@"data"] options:0 error:nil];
        if (result == nil) {
            NSLog(@"result %@", [[NSString alloc] initWithData:data[@"data"] encoding:NSUTF8StringEncoding]);
        } else {
            NSLog(@"result dict %@", result);
        }
        
        
    } onFail:^(NSDictionary *data) {
        
        NSLog(@"error %@", [[NSString alloc] initWithData:data[@"data"] encoding:NSUTF8StringEncoding]);
        
    }];
    
}

@end
