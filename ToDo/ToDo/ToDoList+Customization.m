//
//  ToDoList+Customization.m
//  ToDo
//
//  Created by Mit on 11/7/12.
//  Copyright (c) 2012 Innovaworks. All rights reserved.
//

#import "ToDoList+Customization.h"
#import "ToDoListItem.h"

@implementation ToDoList (Customization)

-(NSArray *)sortedListItems
{
    return [self.listitems.allObjects sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [[(ToDoListItem *) obj1 created] compare:[(ToDoListItem *) obj2 created]];
    }];
}

@end
