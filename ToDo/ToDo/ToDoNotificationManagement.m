//
//  ToDoNotificationManagement.m
//  ToDo
//
//  Created by Mit on 11/19/12.
//  Copyright (c) 2012 Innovaworks. All rights reserved.
//

#import "ToDoNotificationManagement.h"

@implementation ToDoNotificationManagement
@synthesize notification;

-(void) scheduleLocalNotification:(UILocalNotification *)notification
{
    
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    
    NSLog(@"sheduled via method within the notifmanagement class, notif %@",notification);
    
}
-(void)cancelLocalNotificationWithTitle:(NSString *)notifTitle{
    
    UILocalNotification *notifToCancel=nil;
    BOOL hasNotif=NO;
    
    for(UILocalNotification *someNotif in [[UIApplication sharedApplication] scheduledLocalNotifications])
    {
        if([[someNotif.userInfo objectForKey:@"key"] isEqualToString:notifTitle])
        {
            NSLog(@"found notif to cancel");
            notifToCancel=someNotif;
            hasNotif=YES;
            break;
        }
        else{
            NSLog(@"no notif to cancel");
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
