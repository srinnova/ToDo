//
//  ToDoSettingsViewController.h
//  ToDo
//
//  Created by Mit on 11/15/12.
//  Copyright (c) 2012 Innovaworks. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ToDoListListViewController;

@interface ToDoSettingsViewController : UITableViewController

@property(nonatomic,strong) ToDoListListViewController *list;

@property(nonatomic) BOOL *previousNotifSetting;

@end
