//
//  ToDoList.h
//  ToDo
//
//  Created by Mit on 11/7/12.
//  Copyright (c) 2012 Innovaworks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ToDoListItem;

@interface ToDoList : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSDate * created;
@property (nonatomic, retain) NSSet *listitems;
@end

@interface ToDoList (CoreDataGeneratedAccessors)

- (void)addListitemsObject:(ToDoListItem *)value;
- (void)removeListitemsObject:(ToDoListItem *)value;
- (void)addListitems:(NSSet *)values;
- (void)removeListitems:(NSSet *)values;

@end
