//
//  FontSampleViewController.m
//  Categories
//
//  Created by luomeng on 16/3/24.
//  Copyright © 2016年 luomeng. All rights reserved.
//

#import "FontSampleViewController.h"

@interface FontSampleViewController ()
@property (nonatomic, strong) NSMutableArray *fontNames;
@end

@implementation FontSampleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.fontNames = [[NSMutableArray alloc] init];
    for (NSString *family in [UIFont familyNames]) {
        for (NSString *fontName in [UIFont fontNamesForFamilyName:family]) {
            [self.fontNames addObject:fontName];
            
        }
    }
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.fontNames.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    // Configure the cell...
    NSString *fontName = self.fontNames[indexPath.row];
    cell.textLabel.text = fontName;
    cell.textLabel.font = [UIFont fontWithName:fontName size:16];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *fontName = self.fontNames[indexPath.row];
    NSLog(@"fontName = \n%@", fontName);
}

@end
