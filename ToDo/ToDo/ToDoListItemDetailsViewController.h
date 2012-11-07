//
//  ToDoListItemDetailsViewController.h
//  ToDo
//
//  Created by Mit on 11/7/12.
//  Copyright (c) 2012 Innovaworks. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ToDoListItem;

@interface ToDoListItemDetailsViewController : UITableViewController

@property (nonatomic,strong) ToDoListItem *listItem;

@end
