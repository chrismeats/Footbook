//
//  MasterViewController.m
//  Footbook
//
//  Created by ETC ComputerLand on 8/13/14.
//  Copyright (c) 2014 cmeats. All rights reserved.
//

#import "MasterViewController.h"

#import "DetailViewController.h"
#import "AddFavoriteTableViewController.h"
#import "Profile.h"

@interface MasterViewController ()
@end

@implementation MasterViewController

-(void) viewDidLoad
{
    [super viewDidLoad];

    /**********
     
     I have some sort of issue here with Caching
     When first running the app you can click on the plus to get the list of names from the api.
     Selecting names addes them to core data but does not automatically refresh with the fetched Results Controller.
     Also if you stop the app and restart they still not get fetched. If I change the sectionNameKeyPath to nil then they will load. but will bomb out when I try to add more unless I change the sectionNameKeyPath back to @"name"
     I pass my moc in prepare for segue.
     I have tried passing fetchResultsController instead and still no luck.
     
     Thank you for the help!

     **********/
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Profile"];
    request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];

    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:self.managedObjectContext sectionNameKeyPath:@"name" cacheName:@"profileCache"];

    self.fetchedResultsController.delegate = self;
    [self.fetchedResultsController performFetch:nil];
//    NSLog(@"%@", self.fetchedResultsController.sections);
}


-(IBAction)unwindFromAddFav:(UIStoryboardSegue *)sender
{
//    AddFavoriteTableViewController *svc = sender.sourceViewController;
//    self.managedObjectContext = svc.managedObjectContext;
    [self.tableView reloadData];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier  isEqual: @"addFav"]) {
        AddFavoriteTableViewController *dvc = segue.destinationViewController;
        dvc.managedObjectContext = self.managedObjectContext;
    } else if ([segue.identifier isEqualToString:@"showDetail"]) {
        DetailViewController *dvc = segue.destinationViewController;
        dvc.profile = [self.fetchedResultsController objectAtIndexPath:self.tableView.indexPathForSelectedRow];
    }
}

#pragma mark -- Table View delegates

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.fetchedResultsController.sections.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //NSLog(@"%lu", (unsigned long)[[self.fetchedResultsController.sections objectAtIndex:section] numberOfObjects]);
    return [[self.fetchedResultsController.sections objectAtIndex:section] numberOfObjects];
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Profile *profile = [self.fetchedResultsController objectAtIndexPath:indexPath];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.textLabel.text = profile.name;
    cell.detailTextLabel.text = [[NSNumber numberWithInt:profile.comments.count]description];
    if (profile.photo) {
        cell.imageView.image = [UIImage imageWithData:profile.photo];
    }
    return cell;
}

@end
