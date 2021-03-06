## UWAPIWrapper ##

Support iOS 4.3 and above

Created by Elton Gao, UW Mobile Club.

This wrapper is for students who want to develop app using University of Waterloo Open Data Initiative.
Website: api.uwaterloo.ca

NO WARRANTY. This simple wrapper is for demo only. Feel free to do whatever you want with it.

## Setup Instruction ##
This wrapper require the following framewoek (Also attribution to them, thank you!)

1. JSONKit: Most famous JSON parser for Obj-C, very fast and never crash for me: http://github.com/johnezang/JSONKit

2. ASIHttpRequest: Although nobody work on this any more, this is still the very to start with among all: http://allseeing-i.com/ASIHTTPRequest/

3. Reachability.h Required by ASIHttpRequest, but very useful in telling you when the network comes back/disconnected.

To use the wrapper properly, follow these steps properly:

1. Drag the UWAPIWrapper folder into your project as a whole, remember to copy them into your project folder (not just reference) and add them to your target

2. Make sure the following frameworks are included, as they are required by framworks above

        - SystemConfiguration.framework
        - CFNetwork.framework
        - libz.dylib
        - MobileCoreServices.framework
        - CoreGraphics.framework  

3. If your project is using Automatic Reference Count, this step is VERY IMPORTANT:
        Go to You Project settings, you will a "Build Phase" Tab, you need to set all source files of JSONKit.m, ASIHttpRequest related .m files and Reachability.m to have the following compile flag: "fno-objc-arc".
        This is to turn off ARC for these source code: http://stackoverflow.com/questions/8958761/how-to-remove-arc-from-xcode

4. Just like what I did in demo, A sample of request is made like this:

        [[UWAPIWrapper sharedInstance] requestParsedJSONResponseWithMethodName:@"CourseSearch" QueryIfNeeded:@"CS 343" APIKey:@"you_api_key_here" completionBlock:^(id parsedJSONObject) {
                //Code to execute when data comes back
            } failedBlock:^(NSError *error) {
                //Code to execute when fail to retrieve data
            } usingCachedDataBlock:^(id parsedJSONObject) {
                //You have to figure out how to store cache data by adding features to UWAPIWrapper itself :D
        }];


Done! That simple. By using the concept of block, we can put call back code in one place to increase readability of this code!