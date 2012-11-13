//
//  MainViewController.m
//  UWAPIWrapperDemo
//
//  Created by Yuanfeng on 2012-11-12.
//  Copyright (c) 2012 UW Mobile Club. All rights reserved.
//

#import "MainViewController.h"
#import "UWAPIWrapper.h"
#import "JSONKit.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Flipside View

- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)showInfo:(id)sender
{    
    FlipsideViewController *controller = [[FlipsideViewController alloc] initWithNibName:@"FlipsideViewController" bundle:nil];
    controller.delegate = self;
    controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)viewDidUnload {
    _output = nil;
    [super viewDidUnload];
}

- (IBAction)onRequestClicked:(id)sender {
    
    [[UWAPIWrapper sharedInstance] requestParsedJSONResponseWithMethodName:_method_name_txt_field.text QueryIfNeeded:nil APIKey:_api_key_txt_field.text completionBlock:^(id parsedJSONObject) {
        if (DEBUG) NSLog(@"%@", parsedJSONObject); //For debug
        NSDictionary *dict = parsedJSONObject;
        
        //Make keyboard disappear
        [_method_name_txt_field resignFirstResponder];
        [_api_key_txt_field resignFirstResponder];
        
        _output.text = [dict JSONString]; //One possible crash, what if the JSON root level is an array instead?
        
    } failedBlock:^(NSError *error) {
        //TODO any message?
    } usingCachedDataBlock:^(id parsedJSONObject) {
        
    }
    
    
}
@end
