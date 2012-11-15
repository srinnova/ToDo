//
//  ToDoListItemListViewController.h
//  ToDo
//
//  Created by Mit on 11/7/12.
//  Copyright (c) 2012 Innovaworks. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ToDoList;

@interface ToDoListItemListViewController : UITableViewController

@property (nonatomic,strong)ToDoList *list;

@property (nonatomic,strong) UIColor *bcgColor;

@end
