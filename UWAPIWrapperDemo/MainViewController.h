//
//  MainViewController.h
//  UWAPIWrapperDemo
//
//  Created by Yuanfeng on 2012-11-12.
//  Copyright (c) 2012 UW Mobile Club. All rights reserved.
//

#import "FlipsideViewController.h"

@interface MainViewController : UIViewController <FlipsideViewControllerDelegate>
{
    IBOutlet UITextField *_method_name_txt_field;
    IBOutlet UITextField *_api_key_txt_field;
    __unsafe_unretained IBOutlet UITextView *_output;
}
- (IBAction)showInfo:(id)sender;
- (IBAction)onRequestClicked:(id)sender;

@end
