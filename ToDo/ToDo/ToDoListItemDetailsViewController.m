//
//  ToDoListItemDetailsViewController.m
//  ToDo
//
//  Created by Mit on 11/7/12.
//  Copyright (c) 2012 Innovaworks. All rights reserved.
//

#import "ToDoListItemDetailsViewController.h"
#import "ToDoAppDelegate.h"
#import "ToDoListItem.h"

@interface ToDoListItemDetailsViewController ()

@property (nonatomic,weak) IBOutlet UITextField *titleField;
@property (nonatomic,weak) IBOutlet UIDatePicker *datePicker;
@property (nonatomic,weak) IBOutlet UISwitch *switchNotification;

@property (nonatomic,readonly) NSManagedObjectContext *managedObjectContext;

-(IBAction)save:(id)sender;



@end

@implementation ToDoListItemDetailsViewController

@synthesize titleField=_titleField;
@synthesize listItem=_listItem;
@synthesize datePicker=_datePicker;
@synthesize switchNotification=_switchNotification;

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.titleField.text=self.listItem.title;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSManagedObjectContext *)managedObjectContext{
    
    return [(ToDoAppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
}

#pragma mark - IBActions
-(void)save:(id)sender{
    
    self.listItem.title=self.titleField.text;
    
    ///////////
    
    NSDate *pickerDate=[self.datePicker date];
    

    self.listItem.dueDateTime=pickerDate;
    
    NSDateFormatter *df=[[NSDateFormatter alloc] init];
    [df setDateStyle:NSDateFormatterMediumStyle];
    [df setTimeStyle:NSDateFormatterMediumStyle];
    NSString *str=[df stringFromDate:pickerDate];
    
    NSLog(@"%@",str);
    
    int i=0;
    
    if(self.switchNotification.on)
    {
        i=1;
    }
    
    
    NSString *sss=[NSString stringWithFormat:@"%d",i];
    NSLog(@"%@",sss);
    self.titleField.text=str;
    
    
    ///////////////////
    
    [self.managedObjectContext save:nil];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


@end
