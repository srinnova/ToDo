//
//  ToDoNotificationManagement.h
//  ToDo
//
//  Created by Mit on 11/19/12.
//  Copyright (c) 2012 Innovaworks. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ToDoNotificationManagement : NSObject

@property (nonatomic,strong)UILocalNotification *notification;

-(void)scheduleLocalNotification:(UILocalNotification *) notification;

-(void)cancelLocalNotificationWithTitle:(NSString *) notifTitle;

@end
