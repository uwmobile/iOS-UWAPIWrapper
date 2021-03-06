//
//  MainViewController.h
//  UWAPIWrapperDemo
//
//  Created by Yuanfeng on 2012-11-12.
//  Copyright (c) 2012 UW Mobile Club. All rights reserved.
//

#import "FlipsideViewController.h"

@interface MainViewController : UIViewController <FlipsideViewControllerDelegate, UITableViewDataSource, UITableViewDelegate>
{
    __unsafe_unretained IBOutlet UITextField *_query_text_field;
    IBOutlet UITableView *_tableView;
    IBOutlet UITextField *_method_name_txt_field;
    IBOutlet UITextField *_api_key_txt_field;
    __unsafe_unretained IBOutlet UITextView *_output;
    
    NSMutableArray *_result_array;
}
- (IBAction)showInfo:(id)sender;
- (IBAction)onRequestClicked:(id)sender;

@end
