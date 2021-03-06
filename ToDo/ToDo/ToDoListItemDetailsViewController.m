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

#import "ToDoBcgColor.h"
#import "ToDoNotificationManagement.h"

@interface ToDoListItemDetailsViewController ()

@property (nonatomic,weak) IBOutlet UITextField *titleField;
@property (nonatomic,weak) IBOutlet UIDatePicker *datePicker;
@property (nonatomic,weak) IBOutlet UISwitch *switchNotification;



@property (nonatomic) BOOL *prevScheduled;


@property (nonatomic,readonly) NSManagedObjectContext *managedObjectContext;

-(IBAction)save:(id)sender;

-(void)scheduleLocalNotification:(UILocalNotification *) notification;
-(void)cancelLocalNotification:(UILocalNotification *) notification;
-(void)cancelLocalNotificationWithTitle:(NSString *) notifTitle;


@end

@implementation ToDoListItemDetailsViewController

@synthesize titleField=_titleField;
@synthesize listItem=_listItem;
@synthesize datePicker=_datePicker;
@synthesize switchNotification=_switchNotification;
@synthesize back=_back;
@synthesize globalNotifications=_globalNotifications;
@synthesize prevScheduled=_prevScheduled;
@synthesize myTest=_myTest;


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
        
        [self.datePicker setDate:self.listItem.dueDateTime];
        
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
    self.myTest=[[ToDoBcgColor alloc] init];
    [self.myTest myMethod:@"fcefcker"];
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
                
                /* Schedule via method
                 
                UILocalNotification *localNotif=[[UILocalNotification alloc]init];
                NSLog(@"scedule local notif via method");
                [self scheduleLocalNotification:localNotif];
                 
                */
                
                ToDoNotificationManagement *notifManagement=[[ToDoNotificationManagement alloc]init];
                notifManagement.notification=[[UILocalNotification alloc]init];
                if(notifManagement.notification==nil)
                {
                    NSLog(@"no notif init");
                }
                notifManagement.notification.fireDate=pickerDate;
                notifManagement.notification.timeZone=[NSTimeZone defaultTimeZone];
                notifManagement.notification.alertBody=self.titleField.text;
                notifManagement.notification.alertAction=@"View";
                
                notifManagement.notification.soundName=UILocalNotificationDefaultSoundName;
                notifManagement.notification.applicationIconBadgeNumber=1;
                
                
                NSDictionary *infoDict=[NSDictionary dictionaryWithObject:self.listItem.title forKey:@"key"];
                notifManagement.notification.userInfo=infoDict;
                
                NSLog(@"use class method");
                [notifManagement scheduleLocalNotification:notifManagement.notification];
                
                /*
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
                */
                self.prevScheduled=YES;
                 
            }
            
            else
            {
                
                NSLog(@"sceduled before, remove prev, add new" );
                NSLog(@"remove notification via class via method");
                
                ToDoNotificationManagement *notifManagement=[[ToDoNotificationManagement alloc]init];
                [notifManagement cancelLocalNotificationWithTitle:self.listItem.title];
               
              ////////// method  [self cancelLocalNotificationWithTitle:self.listItem.title];
                
                /* tuksss
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
                    */
                    
                ///////
                    NSLog(@"re-schedule notification");
                
                    /* local notif via method
                    UILocalNotification *localNotif=[[UILocalNotification alloc]init];
                    NSLog(@"reescedule local notif via method");
                    [self scheduleLocalNotification:localNotif];
                    */
                
                    NSLog(@"schedule local notif via class");
                
                ToDoNotificationManagement *notifManagement1=[[ToDoNotificationManagement alloc]init];
                notifManagement1.notification=[[UILocalNotification alloc]init];
                if(notifManagement1.notification==nil)
                {
                    NSLog(@"no notif init");
                }
                notifManagement1.notification.fireDate=pickerDate;
                notifManagement1.notification.timeZone=[NSTimeZone defaultTimeZone];
                notifManagement1.notification.alertBody=self.titleField.text;
                notifManagement1.notification.alertAction=@"View";
                
                notifManagement1.notification.soundName=UILocalNotificationDefaultSoundName;
                notifManagement1.notification.applicationIconBadgeNumber=1;
                
                
                NSDictionary *infoDict=[NSDictionary dictionaryWithObject:self.listItem.title forKey:@"key"];
                notifManagement1.notification.userInfo=infoDict;
                
                NSLog(@"use class method");
                [notifManagement scheduleLocalNotification:notifManagement1.notification];
                
                
                self.prevScheduled=YES;
                    
                    /*
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
                     */
                    
                    /////////
                        
                /////////////////////////tuka}
                
                
            }
    
        }
        else
        {
            NSLog(@"not scheduled notification");
            
            ////if scheduled before, remove the sceduled notification
            NSLog(@"removing if prev scheduled, couse now switch i off");
            
            NSLog(@"removing if prev scheduled, via class");            
            ToDoNotificationManagement *notifManagement=[[ToDoNotificationManagement alloc]init];
            [notifManagement cancelLocalNotificationWithTitle:self.listItem.title];
            
            ///////NSLog(@"remove via methid");
            ///////[self cancelLocalNotificationWithTitle:self.listItem.title];
            
            /*
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
            
            
            }*/
            
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

-(void)scheduleLocalNotification:(UILocalNotification *)notification{
    
   
    if(notification==nil)
    {
        NSLog(@"no notif init");
    }
    
    NSDate *pickerDate=[self.datePicker date];
    
    notification.fireDate=pickerDate;
    notification.timeZone=[NSTimeZone defaultTimeZone];
    
    notification.alertBody=self.titleField.text;
    notification.alertAction=@"View";
    
    notification.soundName=UILocalNotificationDefaultSoundName;
    notification.applicationIconBadgeNumber=1;
    
    
    NSDictionary *infoDict=[NSDictionary dictionaryWithObject:self.listItem.title forKey:@"key"];
    notification.userInfo=infoDict;
    
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    
    NSLog(@"sheduled via method notif %@",notification);

    
}


//////sredi ja funkcijata
-(void)cancelLocalNotification:(UILocalNotification *)notification{
    
    
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
    
}
-(void)cancelLocalNotificationWithTitle:(NSString *)notifTitle{
    
    UILocalNotification *notifToCancel=nil;
    BOOL hasNotif=NO;
    
    for(UILocalNotification *someNotif in [[UIApplication sharedApplication] scheduledLocalNotifications])
    {
        if([[someNotif.userInfo objectForKey:@"key"] isEqualToString:notifTitle])
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
}

@end
