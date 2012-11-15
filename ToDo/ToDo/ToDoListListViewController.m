//
//  ToDoListListViewController.m
//  ToDo
//
//  Created by Mit on 11/7/12.
//  Copyright (c) 2012 Innovaworks. All rights reserved.
//

#import "ToDoListListViewController.h"
#import "ToDoAppDelegate.h"
#import "ToDoList.h"
#import "ToDoListItemListViewController.h"
#import "ToDoEditListViewController.h"
#import "ToDoHelpViewController.h"
#import "ToDoSettingsViewController.h"



@interface ToDoListListViewController ()

@property (nonatomic,strong) NSArray *lists;

@property (nonatomic,readonly) NSManagedObjectContext *managedObjectContext;

@property (nonatomic,weak) ToDoList *listForEdit;



-(IBAction)addList:(id)sender;
-(IBAction)help:(id)sender;
-(IBAction)settings:(id)sender;

@end

@implementation ToDoListListViewController
@synthesize lists=_lists;

@synthesize color=_color;
@synthesize notifications=_notifications;





- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // TODO: load lists
    
    NSFetchRequest *fetchRequest=[NSFetchRequest fetchRequestWithEntityName:@"ToDoList"];
    
    fetchRequest.sortDescriptors=[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"created"  ascending:YES]];
    
    if(self.notifications==nil)
    {
        self.notifications=YES;
        
        NSLog(@"set notif glob to YES");
    }
    self.lists=[self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
    [self.tableView reloadData];

}


-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- IBActions
-(void)addList:(id)sender{
    
    
    ToDoList *newList=[NSEntityDescription insertNewObjectForEntityForName:@"ToDoList" inManagedObjectContext:self.managedObjectContext];
    
    newList.created=[NSDate date];
    newList.title=[NSString stringWithFormat:@"Task List %d",self.lists.count];
    
    [self.managedObjectContext save:nil];
    
    self.lists=[self.lists arrayByAddingObject:newList];
    
    //[self.tableView reloadData];
    
    NSIndexPath *newIndexPath=[NSIndexPath indexPathForRow:self.lists.count - 1  inSection:0];
    [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
}

-(void)help:(id)sender{
    
    NSLog(@"ListToHelpSegue set");
    
    [self performSegueWithIdentifier:@"ListToHelpSegue" sender:self];    
}
-(void)settings:(id)sender{
    NSLog(@"ListToSettingsSegue");
    
    [self performSegueWithIdentifier:@"ListToSettingsSegue" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if([segue.identifier isEqualToString:@"ListListToListItemListSegue"]){
        
        ToDoListItemListViewController *listItemList=segue.destinationViewController;
        listItemList.list=[self.lists objectAtIndex:self.tableView.indexPathForSelectedRow.row];
        listItemList.bcgColor=self.color;
        listItemList.globalNotif=self.notifications;
        BOOL *ss=self.notifications;
        NSLog(@" valuee i %i",ss);
    }
    
    if([segue.identifier isEqualToString:@"ListToEditListSegue"]){
        
        ToDoEditListViewController *edit=segue.destinationViewController;
       //edit.list.title=@"titleeee";
        edit.listTitle=@"hythj";
        edit.list=self.listForEdit;
        edit.back=self.color;
    }
    if([segue.identifier isEqualToString:@"ListToHelpSegue"]){
        
        NSLog(@"ListToHelpSegue");
        
        ToDoHelpViewController *helview=segue.destinationViewController;
        helview.back=self.color;

    }
    if([segue.identifier isEqualToString:@"ListToSettingsSegue"]){
        
        NSLog(@"ListToSettingsSegue");
        
        ToDoSettingsViewController *settings=segue.destinationViewController;
        settings.list=self;
        
    }
}

-(NSManagedObjectContext *)managedObjectContext{
    return [(ToDoAppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return self.lists.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ListCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    ToDoList *currentList=[self.lists objectAtIndex:indexPath.row];
    
    
    
    cell.textLabel.text=currentList.title;
    
    
    
    
    ////long press
    
    UILongPressGestureRecognizer *lpgr=[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    lpgr.minimumPressDuration=3.0;
    [cell addGestureRecognizer:lpgr];

    NSLog(@"add long press");
    
    
    
    return cell;
}

-(void) handleLongPress:(UILongPressGestureRecognizer *) gestureRecognizer{
    
    NSLog(@"detecting long press");
    
    UITableView* tableView=(UITableView *)self.view;
    
    CGPoint p=[gestureRecognizer locationInView:self.view];
    
    
    
    NSIndexPath *indexPath=[tableView indexPathForRowAtPoint:p];
    
    self.listForEdit=[self.lists objectAtIndex:indexPath.row];
    
    if(indexPath==nil){
        NSLog(@"ne e selentiran objekt");
    }
    else{
    [self performSegueWithIdentifier:@"ListToEditListSegue" sender:self];
        
        self.listForEdit=[self.lists objectAtIndex:indexPath.row];
    }

}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        
        [self.managedObjectContext deleteObject:[self.lists objectAtIndex:indexPath.row]];
        [self.managedObjectContext save:nil];
        
        NSFetchRequest *fetchRequest=[NSFetchRequest fetchRequestWithEntityName:@"ToDoList"];
        fetchRequest.sortDescriptors=[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"created"  ascending:YES]];
        
        
        self.lists=[self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
        
        
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    

        //cell.backgroundColor=self.bcg.color;
        //cell.textLabel.backgroundColor=self.bcg.color;
    if(self.color==nil)
    {
    cell.backgroundColor=[UIColor colorWithRed:1 green:1 blue:1 alpha:1];
        cell.textLabel.backgroundColor=[UIColor colorWithRed:1 green:1 blue:1 alpha:1];
    }
    else{
        cell.backgroundColor=self.color;
        cell.textLabel.backgroundColor=self.color;
    }
    

}

@end
