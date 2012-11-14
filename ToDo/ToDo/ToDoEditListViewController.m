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


@interface ToDoEditListViewController ()

@property (nonatomic,weak) IBOutlet UITextField *listTitleField;

@property (nonatomic,readonly) NSManagedObjectContext *managedObjectContext;

-(IBAction)save:(id)sender;

@end

@implementation ToDoEditListViewController
@synthesize list=_list;
@synthesize listTitleField=_listTitleField;

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.listTitleField.text=@"text";
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
    
}

@end
