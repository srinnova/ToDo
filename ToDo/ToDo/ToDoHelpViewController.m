//
//  ToDoHelpViewController.m
//  ToDo
//
//  Created by Mit on 11/14/12.
//  Copyright (c) 2012 Innovaworks. All rights reserved.
//

#import "ToDoHelpViewController.h"

@interface ToDoHelpViewController ()

@end

@implementation ToDoHelpViewController
@synthesize back=_back;
- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    //cell.backgroundColor=self.bcg.color;
    //cell.textLabel.backgroundColor=self.bcg.color;
    if(self.back==nil)
    {
        cell.backgroundColor=[UIColor colorWithRed:1 green:1 blue:1 alpha:1];
        cell.textLabel.backgroundColor=[UIColor colorWithRed:1 green:1 blue:1 alpha:1];
        
    }
    else{
        cell.backgroundColor=self.back;
        cell.textLabel.backgroundColor=self.back;
    }
    
    
}

@end
