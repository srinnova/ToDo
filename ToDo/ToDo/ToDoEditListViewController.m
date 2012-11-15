//
//  ToDoEditListViewController.m
//  ToDo
//
//  Created by Mit on 11/14/12.
//  Copyright (c) 2012 Innovaworks. All rights reserved.
//

#import "ToDoEditListViewController.h"
#import "ToDoAppDelegate.h"
#import "ToDoList+Customization.h"
#import "ToDoList.h"


@interface ToDoEditListViewController ()

@property (nonatomic,weak) IBOutlet UITextField *listTitleField;

@property (nonatomic,readonly) NSManagedObjectContext *managedObjectContext;

-(IBAction)save:(id)sender;

@end

@implementation ToDoEditListViewController
@synthesize list=_list;
@synthesize listTitleField=_listTitleField;
@synthesize listTitle=_listTitle;
@synthesize back=_back;

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.listTitleField.text=self.list.title;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSManagedObjectContext *)managedObjectContext{
    
    return [(ToDoAppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
}

#pragma mark- IBActions

-(void)save:(id)sender{
   
    self.list.title=self.listTitleField.text;
    
    [self.managedObjectContext save:nil];
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
}

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
