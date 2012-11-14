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

@interface ToDoListListViewController ()

@property (nonatomic,strong) NSArray *lists;

@property (nonatomic,readonly) NSManagedObjectContext *managedObjectContext;

-(IBAction)addList:(id)sender;

@end

@implementation ToDoListListViewController
@synthesize lists=_lists;




- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // TODO: load lists
    
    NSFetchRequest *fetchRequest=[NSFetchRequest fetchRequestWithEntityName:@"ToDoList"];
    
    fetchRequest.sortDescriptors=[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"created"  ascending:YES]];
    
    
    self.lists=[self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
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

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if([segue.identifier isEqualToString:@"ListListToListItemListSegue"]){
        
        ToDoListItemListViewController *listItemList=segue.destinationViewController;
        listItemList.list=[self.lists objectAtIndex:self.tableView.indexPathForSelectedRow.row];
    }
    
    if([segue.identifier isEqualToString:@"ListToEditListSegue"]){
        
        ToDoEditListViewController *edit=segue.destinationViewController;
        edit.list.title=@"title";
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

-(void) handleLongPress:(UILongPressGestureRecognizer *) segue{
    
    NSLog(@"detecting long press");
    
    
    [self performSegueWithIdentifier:@"ListToEditListSegue" sender:self];

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

#pragma mark - Table view delegate
/*
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
//}

@end
