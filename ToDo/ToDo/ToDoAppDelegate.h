//
//  ToDoAppDelegate.h
//  ToDo
//
//  Created by Mit on 11/7/12.
//  Copyright (c) 2012 Innovaworks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ToDoAppDelegate : UIResponder <UIApplicationDelegate>



@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
