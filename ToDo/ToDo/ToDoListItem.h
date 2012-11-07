//
//  ToDoListItem.h
//  ToDo
//
//  Created by Mit on 11/7/12.
//  Copyright (c) 2012 Innovaworks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ToDoList;

@interface ToDoListItem : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSDate * dueDateTime;
@property (nonatomic, retain) NSDate * created;
@property (nonatomic, retain) NSNumber * notification;
@property (nonatomic, retain) ToDoList *list;

@end
