//
//  ToDoEditListViewController.h
//  ToDo
//
//  Created by Mit on 11/14/12.
//  Copyright (c) 2012 Innovaworks. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ToDoList;

@interface ToDoEditListViewController : UITableViewController

@property(nonatomic,strong)ToDoList *list;
@property (nonatomic,strong) NSString *listTitle;


@property (nonatomic,weak) UIColor *back;

@end
