//
//  ToDoSettingsViewController.m
//  ToDo
//
//  Created by Mit on 11/15/12.
//  Copyright (c) 2012 Innovaworks. All rights reserved.
//

#import "ToDoSettingsViewController.h"
#import "ToDoAppDelegate.h"
#import "ToDoListListViewController.h"
#import "ToDoBcgColor.h"


@interface ToDoSettingsViewController ()



@property (nonatomic,weak) IBOutlet UITableViewCell * cell1;
@property (nonatomic,weak) IBOutlet UISwitch *notifications;
@property(nonatomic,readonly) NSManagedObjectContext *managedObjectContext;

@property(nonatomic) NSInteger *section;
@property(nonatomic) NSInteger *cellColl;

-(IBAction)save:(id)sender;

@end

@implementation ToDoSettingsViewController
@synthesize notifications=_notifications;
@synthesize list=_list;
@synthesize section=_section;
@synthesize cellColl=_cellColl;
@synthesize previousNotifSetting=_previousNotifSetting;

- (void)viewDidLoad
{
    [super viewDidLoad];
    if(self.previousNotifSetting == YES)
    {
    [self.notifications setOn:YES];
    }
    else{
        [self.notifications setOn:NO];
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section ==0) return 1;
    else return 4;
}

-(NSManagedObjectContext *)managedObjectContext{
    
    return [(ToDoAppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
}

#pragma mark - IBActions
-(void)save:(id)sender{
    
    if([self.notifications isOn])
    {
        self.list.notifications=YES;
        NSLog(@"setting list.notif. onn");
    }
    else self.list.notifications=NO;
    
    if(self.section == 0)
    {
        NSLog(@"section 0");
    }
    if(self.section==1){
        
        if(self.cellColl == 0)
        {
            self.list.color=[UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:255.0/255.0 alpha:1];                    NSLog(@"list color blue");
        }
        else if(self.cellColl == 1)
        {
            self.list.color=[UIColor colorWithRed:255.0/255.0 green:105.0/255.0 blue:180.0/255.0 alpha:1];
                     NSLog(@"list color pink");
            
        }
        else if(self.cellColl == 2)
        {
            self.list.color=[UIColor colorWithRed:76.0/255.0 green:0.0/255.0 blue:153.0/255.0 alpha:1];
                      NSLog(@"list color purple");
        }
        else if(self.cellColl == 3)
        {
             self.list.color=[UIColor colorWithRed:1 green:1 blue:1 alpha:1];
                     NSLog(@"list color white");
        }
        else
        {
            self.list.color=[UIColor colorWithRed:1 green:1 blue:1 alpha:1];
            NSLog(@"list color white");
        }
    }
    
    
    [self.managedObjectContext save:nil];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}


*/
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    self.section=indexPath.section;
    
    NSInteger *i=indexPath.section;
    
    NSString *str=[NSString stringWithFormat:@"%d", i];
    NSLog(@"%@",str);
    
    self.cellColl=indexPath.row;
    
    NSInteger *j=indexPath.row;
    NSString *str1=[NSString stringWithFormat:@"%d", j];
    NSLog(@"%@",str1);
    
}


@end
