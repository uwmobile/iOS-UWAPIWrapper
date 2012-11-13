//
//  UWAPIWrapper.h 
//  Github: https://github.com/uwmobile/iOS-UWAPIWrapper/
//
//    Created by Elton Gao, UW Mobile Club.
//
//    This wrapper is for students who want to develop app using University of Waterloo Open Data Initiative.
//    Website: api.uwaterloo.ca
//
//    NO WARRANTY. This simple wrapper is for demo only. Feel free to do whatever you want with it.
//
//    ## Setup Instruction ##
//    This wrapper require the following framewoek (Also attribution to them, thank you!)
//    1. JSONKit: Mos famous JSON parser for Obj-C, very fast and never crash for me: http://github.com/johnezang/JSONKit
//
//    2. ASIHttpRequest: Although nobody work on this any longer, this is still the very best among all: http://allseeing-i.com/ASIHTTPRequest/
//
//    3. Reachability.h Required by ASIHttpRequest, but very useful in telling you when the network comes back/disconnected.
//
//    To use the wrapper properly, follow these steps properly:
//    1. Drag the UWAPIWrapper folder into your project as a whole, remember to copy them into your project folder (not just reference) and add them to your target
//
//    2. Make sure the following frameworks are included:
//    - SystemConfiguration.framework
//    - CFNetwork.framework
//    - libz.dylib
//    - MobileCoreServices.framework
//    - CoreGraphics.framework
//
//    3. Just like what I did in demo, in MainViewController I do the following:
//
//    [[UWAPIWrapper sharedInstance] requestParsedJSONResponseWithMethodName:@"CourseSearch" QueryIfNeeded:@"CS 343" APIKey:@"you_api_key_here" completionBlock:^(id parsedJSONObject) {
//        //Code to execute when data comes back
//    } failedBlock:^(NSError *error) {
//        //Code to execute when fail to retrieve data
//    } usingCachedDataBlock:^(id parsedJSONObject) {
//        //You have to figure out how to store cache data by adding features to UWAPIWrapper itself :D
//    }];

#import <Foundation/Foundation.h>

@interface UWAPIWrapper : NSObject
{
}

//I use Singleton as the structure of this wrapper just to make life easier when want to use this method
//Although, sync of internal data can be achieved if someone ever want to add more features to it
+ (UWAPIWrapper*)sharedInstance;

/**
 * A generic request method to get JSON data from any method specified in api.uwaterloo.ca
 * @param mathodName        method name specified by api.uwaterloo.ca
 * @param APIKey            your own api key
 * @param qeury             Optional, when the api call needs this query, you can pass it here. Otherwise just pass nil
 * @param completionBlock   a bunch of code you want execute when the response comes back and is parsed, 
 * NOTE!!! the passed back parsedJSONObject CAN BE nil because it cannot parse the JSON properly, so do a check after you get this!
 *
 * @param failedBlock       a bunch of code you want execute when the request fails for any reason, the error is specified in the "error" variable
 * @param usingCachedData   a future extension of this API call, just leave nil now. Basically once you know how to store JSON data, you can pass it back using this method
 */
- (void)requestParsedJSONResponseWithMethodName:(NSString*)mathodName QueryIfNeeded:(NSString*)query APIKey:(NSString*)APIkey completionBlock:(void (^)(id parsedJSONObject))completion failedBlock:(void (^)(NSError *error))failed usingCachedDataBlock:(void (^)(id parsedJSONObject))usingCachedData;

@end
