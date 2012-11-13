//
//  UWAPIWrapper.m
//
//  Created by Yuanfeng on 12-07-13.
//  Copyright (c) 2012 UW Mobile Club. All rights reserved.
//

#import "UWAPIWrapper.h"
#import "ASIHTTPRequest.h"
#import "JSONKit.h"

#define UW_API_BASE_URL @"http://api.uwaterloo.ca/public/v1/?"

static UWAPIWrapper *sharedInstance;

@implementation UWAPIWrapper

+ (UWAPIWrapper*)sharedInstance
{
    if (!sharedInstance) {
        @synchronized(self)
        {
            if (!sharedInstance) {
                sharedInstance = [[self alloc] init];
            }
        }
    }
    return sharedInstance;
}

- (id)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)requestParsedJSONResponseWithMethodName:(NSString*)mathodName QueryIfNeeded:(NSString*)query APIKey:(NSString*)APIkey completionBlock:(void (^)(id parsedJSONObject))completion failedBlock:(void (^)(NSError *error))failed usingCachedDataBlock:(void (^)(id parsedJSONObject))usingCachedData
{
    NSString *url = [NSString stringWithFormat:@"%@%@%@%@%@%@%@",UW_API_BASE_URL, @"key=", APIkey, @"&service=", mathodName, @"&output=", @"json"];
    if (query) {
        url = [url stringByAppendingString:@"&q="];
        url = [url stringByAppendingString:query];
    }
    
    ASIHTTPRequest *searchRequest = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:url]];
    __unsafe_unretained ASIHTTPRequest *ptr = searchRequest;
    [searchRequest setCompletionBlock:^{
        NSData *raw = [ptr responseData];
        id parsedJSON = [raw objectFromJSONData];
        
        completion(parsedJSON);
    }];
    [searchRequest setFailedBlock:^{
        /*TODO 
         usingCachedData block is never implemented, it's up to you to implementing this method by passing back cached data to view controller, like this:
            if (hasCachedData) {
                completion(Cached_data);
            } else{
                failed([ptr error]);
            }
        */
        failed([ptr error]);
    }];
    [searchRequest startAsynchronous];
}
@end
