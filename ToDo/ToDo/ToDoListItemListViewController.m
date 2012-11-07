//
//  ToDoListItemListViewController.m
//  ToDo
//
//  Created by Mit on 11/7/12.
//  Copyright (c) 2012 Innovaworks. All rights reserved.
//

#import "ToDoListItemListViewController.h"
#import "ToDoAppDelegate.h"
#import "ToDoList+Customization.h"
#import "ToDoListItem.h"
#import "ToDoListItemDetailsViewController.h"

@interface ToDoListItemListViewController ()

-(IBAction)addListItem:(id)sender;

@property (nonatomic,readonly) NSManagedObjectContext *managedObjectContext;

@end

@implementation ToDoListItemListViewController
@synthesize list=_list;




- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
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

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"ListItemListToListDetailsSegue"]){
        ToDoListItemDetailsViewController *listItemDetail=segue.destinationViewController;
        listItemDetail.listItem=[self.list.sortedListItems objectAtIndex:self.tableView.indexPathForSelectedRow.row];
        
    }
    
}

-(NSManagedObjectContext *)managedObjectContext{
    return [(ToDoAppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];}

#pragma mark - IBActions
-(void)addListItem:(id)sender{
    
    
    ToDoListItem *newListItem=[NSEntityDescription insertNewObjectForEntityForName:@"ToDoListItem" inManagedObjectContext:self.managedObjectContext];
    newListItem.title=[NSString stringWithFormat:@"List Item %d",self.list.listitems.count];
    newListItem.created=[NSDate date];
    newListItem.notification=NO;
    newListItem.list=self.list;
    
    [self.managedObjectContext save:nil];
    
    NSIndexPath *newIndexPath=[NSIndexPath indexPathForRow:self.list.listitems.count -1 inSection:0];
    [self.tableView insertRowsAtIndexPaths:[NSArray  arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.list.listitems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ListItemCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
      ToDoListItem *currentListItem=[self.list.sortedListItems objectAtIndex:indexPath.row];
    
       cell.textLabel.text=currentListItem.title;
    
    
    
    return cell;}


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
        
        [self.managedObjectContext deleteObject:[self.list.sortedListItems objectAtIndex:indexPath.row]];
        [self.managedObjectContext save:nil];
        

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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
