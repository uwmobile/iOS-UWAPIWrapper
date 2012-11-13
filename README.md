## UWAPIWrapper ##

Created by Elton Gao, UW Mobile Club.

This wrapper is for students who want to develop app using University of Waterloo Open Data Initiative.
Website: api.uwaterloo.ca

NO WARRANTY. This simple wrapper is for demo only. Feel free to do whatever you want with it.

## Setup Instruction ##
This wrapper require the following framewoek (Also attribution to them, thank you!)

1. JSONKit: Mos famous JSON parser for Obj-C, very fast and never crash for me: http://github.com/johnezang/JSONKit

2. ASIHttpRequest: Although nobody work on this any longer, this is still the very best among all: http://allseeing-i.com/ASIHTTPRequest/

3. Reachability.h Required by ASIHttpRequest, but very useful in telling you when the network comes back/disconnected.

To use the wrapper properly, follow these steps properly:
1. Drag the UWAPIWrapper folder into your project as a whole, remember to copy them into your project folder (not just reference) and add them to your target

2. Make sure the following frameworks are included:
        - SystemConfiguration.framework
        - CFNetwork.framework
        - libz.dylib
        - MobileCoreServices.framework
        - CoreGraphics.framework  

3. Just like what I did in demo, in MainViewController I do the following:

        [[UWAPIWrapper sharedInstance] requestParsedJSONResponseWithMethodName:@"CourseSearch" QueryIfNeeded:@"CS 343" APIKey:@"you_api_key_here" completionBlock:^(id parsedJSONObject) {
                //Code to execute when data comes back
            } failedBlock:^(NSError *error) {
                //Code to execute when fail to retrieve data
            } usingCachedDataBlock:^(id parsedJSONObject) {
                //You have to figure out how to store cache data by adding features to UWAPIWrapper itself :D
        }];


Done! That simple.