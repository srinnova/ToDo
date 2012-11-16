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

@property (nonatomic) BOOL *prevScheduled;


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
@synthesize prevScheduled=_prevScheduled;


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
    
    NSNumber *pom=self.listItem.notification;
    NSString *ssssss=[pom stringValue];
    NSLog(@"%@",ssssss);
    
    if (self.listItem.notification==NULL) {
        
        self.prevScheduled=NO;
        
        NSLog(@"selflistitem notif nil set prev sched NO");
    }
    else if(self.listItem.notification==[NSNumber numberWithInt:1])
    {
        self.prevScheduled=YES;
        
        NSLog(@"selflistitem set prev sched YES");
    }
    else if(self.listItem.notification==[NSNumber numberWithInt:0])
    {
        self.prevScheduled=NO;
        [self.switchNotification setOn:NO];
        
        NSLog(@"selflistitem not set prev sched NO");
    }
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
    
    /*if([self.switchNotification isOn])
    {
        if(self.globalNotifications==NO)
        {
            
            [[[UIAlertView alloc]
              initWithTitle:@"Allert" message:@"Global notifications are turned of" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil]show];
            
            [self.switchNotification setOn:NO];        }
    }*/
    
    
    ////if no text insered in textInput
    
    if([self.titleField.text isEqualToString:@""])
    {
        NSLog(@"no title input");
        [[[UIAlertView alloc]
          initWithTitle:@"Allert" message:@"Insert title" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil]show];
        
    }
    
    
    self.listItem.title=self.titleField.text;
    
    /////////// retrieeve date an notificationd
    
    NSDate *pickerDate=[self.datePicker date];
    self.listItem.dueDateTime=pickerDate;
    
    /*-------------Print picked date in NSLog---------*/ 
    NSDateFormatter *df=[[NSDateFormatter alloc] init];
    [df setDateStyle:NSDateFormatterMediumStyle];
    [df setTimeStyle:NSDateFormatterMediumStyle];
    NSString *str=[df stringFromDate:pickerDate];
    NSLog(@"%@",str);
    
     /*-------------Print picked date in NSLog ----------*/
    
    
     /*-------------sett notification on/off-----------*/
    
    int i=0;
        if([self.switchNotification isOn])
    {
        i=1;
    }
    NSString *sss=[NSString stringWithFormat:@"%d",i];
    NSLog(@"%@",sss);////check if notif in seton
    
    NSNumber *n=[NSNumber numberWithInt:i];
    
    self.listItem.notification=n;
    self.titleField.text=str;
    
    
    ///////////////////
    
    
    
    //////////Schedule local notifications
    if(self.globalNotifications==YES)
    {
        if([self.switchNotification isOn])
        {
            NSLog(@"swithNotif local is ON");
            
            if(self.prevScheduled==NO)///not ched prev
            {
                
                self.listItem.notification=[NSNumber numberWithInt:1];
                NSLog(@"not prev scheduled");
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
    
    
                NSDictionary *infoDict=[NSDictionary dictionaryWithObject:self.listItem.title forKey:@"key"];
                localNotif.userInfo=infoDict;
    
                [[UIApplication sharedApplication] scheduleLocalNotification:localNotif];
                
                self.prevScheduled=YES;
            }
            
            else
            {
                
                NSLog(@"sceduled before, remove prev, add new" );
                
                
                UILocalNotification *notifToCancel=nil;
                BOOL hasNotif=NO;
            
                for(UILocalNotification *someNotif in [[UIApplication sharedApplication] scheduledLocalNotifications])
                {
                    if([[someNotif.userInfo objectForKey:@"key"] isEqualToString:self.listItem.title])
                    {
                        notifToCancel=someNotif;
                        hasNotif=YES;
                        break;
                    }
                }
                
                if(hasNotif==YES)
                {
                    NSLog(@"canceling notif");
                    NSLog(@"%@",notifToCancel);
                    [[UIApplication sharedApplication] cancelLocalNotification:notifToCancel];
                    
                    
                ///////
                    NSLog(@"re-schedule notification");
                    
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
                    
                        
                    NSDictionary *infoDict=[NSDictionary dictionaryWithObject:self.listItem.title forKey:@"key"];
                    localNotif.userInfo=infoDict;
                    
                    [[UIApplication sharedApplication] scheduleLocalNotification:localNotif];
                    
                    NSLog(@"sheduled this notif %@",localNotif);
                    
                    /////////
                        
                }
                
                
            }
    
        }
        else
        {
            NSLog(@"not scheduled notification");
            
            ////if scheduled before, remove the sceduled notification
            NSLog(@"removing if prev scheduled, couse now switch i off");
            UILocalNotification *notifToCancel=nil;
            BOOL hasNotif=NO;
            
            for(UILocalNotification *someNotif in [[UIApplication sharedApplication] scheduledLocalNotifications])
            {
                if([[someNotif.userInfo objectForKey:@"key"] isEqualToString:self.listItem.title])
                {
                    notifToCancel=someNotif;
                    hasNotif=YES;
                    break;
                }
            }
            
            if(hasNotif==YES)
            {
                NSLog(@"canceling notif");
                NSLog(@"%@",notifToCancel);
                [[UIApplication sharedApplication] cancelLocalNotification:notifToCancel];
            
            
            }
            
            self.listItem.notification=[NSNumber numberWithInt:0];
            self.prevScheduled=NO;
            
            
        }
        
    }
    else
    {
        NSLog(@"global notif off");

    }
     
        
    /////////
    
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
