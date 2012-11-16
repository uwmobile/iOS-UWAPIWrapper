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
    _result_array = [[NSMutableArray alloc] init];
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
    _query_text_field = nil;
    [super viewDidUnload];
}

- (IBAction)onRequestClicked:(id)sender {
    NSString *query = _query_text_field.text;
    if ([query isEqualToString:@""]) {
        query = nil;
    }
    
    //TODO, if we have save the data from previous request, do we need to request again? not really, depends on acutal demand
    //Also, what if multiply view controllers are requesting the same data? should we let them all point to same set? That can also be a question
    [[UWAPIWrapper sharedInstance] requestParsedJSONResponseWithMethodName:_method_name_txt_field.text QueryIfNeeded:query APIKey:_api_key_txt_field.text completionBlock:^(id parsedJSONObject) {
        
        NSDictionary *dict = parsedJSONObject;
        NSDictionary *data = [dict objectForKey:@"response"];
        NSArray *array = [[data objectForKey:@"data"] objectForKey:@"result"];
        
        [_result_array removeAllObjects];
        
        for (NSDictionary *dict in array) {
//            NSArray *detail = [[dict objectForKey:@"Holidays"] resul];
            NSString *string = [dict objectForKey:@"Year"];
            NSLog(@"%@", string);
            [_result_array addObject:string];
        }
        
        [_tableView reloadData];
        
        
        if (DEBUG) NSLog(@"%@", parsedJSONObject); //For debug
        
        //Make keyboard disappear
        [_method_name_txt_field resignFirstResponder];
        [_api_key_txt_field resignFirstResponder];
        [_query_text_field resignFirstResponder];
        
        _output.text = [dict JSONString]; //One possible crash, what if the JSON root level is an array instead?
        
    } failedBlock:^(NSError *error) {
        //TODO any message?
    } usingCachedDataBlock:^(id parsedJSONObject) {
        
    }];
}

#pragma - UITableView DataSources
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_result_array count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"CellIdentifier";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    int row = indexPath.row;
    
    cell.textLabel.text = [_result_array objectAtIndex:row];

    return cell;
}
@end
