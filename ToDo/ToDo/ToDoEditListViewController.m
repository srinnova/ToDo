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

    
    
    self.listTitleField.text=self.list.title;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    
}
-(NSManagedObjectContext *)managedObjectContext{
    
    return [(ToDoAppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
}

#pragma mark- IBActions

-(void)save:(id)sender{
   
    if([self.listTitleField.text isEqualToString:@""])
    {
        NSLog(@"no title input");
        [[[UIAlertView alloc]
           initWithTitle:@"Allert" message:@"Insert title" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil]show];
        
    }
    else
    {
        
    NSLog(@"new title input");
        
    self.list.title=self.listTitleField.text;
    
    [self.managedObjectContext save:nil];
    
    [self.navigationController popViewControllerAnimated:YES];
    }
    
    
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{

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
