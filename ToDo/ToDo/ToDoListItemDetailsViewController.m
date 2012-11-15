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
@synthesize back=_back;
@synthesize globalNotifications=_globalNotifications;


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(textField==self.titleField)
    {
        [textField resignFirstResponder];
        [self becomeFirstResponder];
    }
    return YES;
}

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
    
    if([self.titleField.text isEqualToString:@""])
    {
        NSLog(@"no title input");
        [[[UIAlertView alloc]
          initWithTitle:@"Allert" message:@"Insert title" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil]show];
        
    }
    else
    {
    self.listItem.title=self.titleField.text;
    
    /////////// retrieeve date an notificationd
    
    NSDate *pickerDate=[self.datePicker date];
    

    self.listItem.dueDateTime=pickerDate;
    
    NSDateFormatter *df=[[NSDateFormatter alloc] init];
    [df setDateStyle:NSDateFormatterMediumStyle];
    [df setTimeStyle:NSDateFormatterMediumStyle];
    NSString *str=[df stringFromDate:pickerDate];
    
    NSLog(@"%@",str);
    
    int i=0;
    
    
    if([self.switchNotification isOn])
    {
        i=1;
    }
    
    
    NSString *sss=[NSString stringWithFormat:@"%d",i];
    NSLog(@"%@",sss);
    
    NSNumber *n=[NSNumber numberWithInt:i];
    
    self.listItem.notification=n;
    self.titleField.text=str;
    
    
    ///////////////////
    
    
    
    //////////Schedule local notifications
    if(self.globalNotifications==YES)
    {
        if([self.switchNotification isOn])
        {
            NSLog(@"schedule notifications");
        
            UILocalNotification *localNotif=[[UILocalNotification alloc]init];
            if(localNotif==nil)
                {
                    NSLog(@"no notif init");
                }
    
            localNotif.fireDate=pickerDate;
            localNotif.timeZone=[NSTimeZone defaultTimeZone];
            
            localNotif.alertBody=self.titleField.text;
            localNotif.alertAction=@"View";
    
            localNotif.soundName=UILocalNotificationDefaultSoundName;
            localNotif.applicationIconBadgeNumber=1;
    
    
            NSDictionary *infoDict=[NSDictionary dictionaryWithObject:@"someValue" forKey:@"someKey"];
            localNotif.userInfo=infoDict;
    
            [[UIApplication sharedApplication] scheduleLocalNotification:localNotif];
    
        }
        else
        {
            NSLog(@"not scheduled notification");
        }
        
    }
    else{
        NSLog(@"global notif off");    }
     
        
    /////////
    
    [self.managedObjectContext save:nil];
    
    [self.navigationController popViewControllerAnimated:YES];
        
    }
    

    
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
