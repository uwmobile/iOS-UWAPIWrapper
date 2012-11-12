//
//  UWAPIWrapper.h
//
//  Created by Yuanfeng on 12-07-13.
//  Copyright (c) 2012 UW Mobile Club. All rights reserved.
//  Must have JSONKit for json parsing
//  Reachability.h as ASIHTTPRequest needs it
//  And ASIHTTPRequest for http request

#import <Foundation/Foundation.h>

@interface UWAPIWrapper : NSObject
{
}

+ (UWAPIWrapper*)sharedManager;
- (void)requestParsedJSONResponseWithMethodName:(NSString*)mathodName QueryIfNeeded:(NSString*)query APIKey:(NSString*)APIkey completionBlock:(void (^)(id parsedJSONObject))completion failedBlock:(void (^)(NSError *error))failed usingCachedDataBlock:(void (^)(id parsedJSONObject))usingCachedData;

@end
