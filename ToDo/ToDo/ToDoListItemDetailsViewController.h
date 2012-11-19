//
//  ToDoListItemDetailsViewController.h
//  ToDo
//
//  Created by Mit on 11/7/12.
//  Copyright (c) 2012 Innovaworks. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ToDoListItem;
@class ToDoBcgColor;

@interface ToDoListItemDetailsViewController : UITableViewController <UITextFieldDelegate>

@property (nonatomic,strong) ToDoListItem *listItem;
@property (nonatomic,strong)ToDoBcgColor *myTest;

@property (nonatomic,weak) UIColor *back;
@property (nonatomic) BOOL *globalNotifications;
@end
