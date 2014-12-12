//
//  reportTables.m
//  UserLogger
//
//  Created by carlos andres grijalva on 12/11/14.
//  Copyright (c) 2014 aheer001. All rights reserved.
//

#import "reportTables.h"

@implementation reportTables
@synthesize searchPicked, monthPicked, managedObjectContext, fetchedResultsController, contextObjects;

-(void)viewDidLoad{
    
    contextObjects = [[NSArray alloc]init];
    
    if	(contextObjects	==	nil	)	{
        NSLog(@"No data found");
    }
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if(searchPicked == 1){
        
        NSFetchRequest*	request	=	[[NSFetchRequest	alloc]	init];
        NSEntityDescription *entity =
        [NSEntityDescription entityForName:@"LabLog"
                    inManagedObjectContext:self.managedObjectContext];
        [request setEntity:entity];
        
        
        NSPredicate *predicate =
        [NSPredicate predicateWithFormat:@"department == %@", monthPicked];
        [request setPredicate:predicate];
        
        NSError	*error;
        contextObjects	=	[[self.managedObjectContext executeFetchRequest:	request	error:	&error]mutableCopy];
        if	(contextObjects	==	nil	)	{
            NSLog(@"No data found");
        }
    }
    
    else if (searchPicked == 2){
        
        NSFetchRequest*	request	=	[[NSFetchRequest	alloc]	init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"LabLog" inManagedObjectContext:self.managedObjectContext];
        [request setEntity:entity];
        NSDate *currentDate = [NSDate date];
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDateComponents *dateComponents = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:currentDate];
        [dateComponents setHour:0];
        [dateComponents setMinute:0];
        [dateComponents setSecond:0];
        
        
        NSPredicate *predicate =
        [NSPredicate predicateWithFormat:@"time == %@", [calendar dateFromComponents:dateComponents]];
        [request setPredicate:predicate];
        
        NSError	*error;
        NSArray *tempObjects = [self.managedObjectContext executeFetchRequest:	request	error:	&error];
        if	(tempObjects	==	nil	)	{
            NSLog(@"No data found");
        }
        else
        {
            entity = [NSEntityDescription entityForName:@"Users" inManagedObjectContext:self.managedObjectContext];
            [request setEntity:entity];
            NSMutableArray *mutableContextObjects = [[NSMutableArray alloc]init];
            for (NSManagedObjectContext * thing in tempObjects)
            {
                NSLog(@"%@",[tempObjects valueForKey:@"time"]);
                predicate = [NSPredicate predicateWithFormat:@"id == %@", [thing valueForKey:@"id"]];
                [request setPredicate:predicate];
                NSError	*error;
                [mutableContextObjects addObjectsFromArray:[self.managedObjectContext executeFetchRequest:	request	error:	&error]];
            }
            contextObjects = mutableContextObjects;
            if	(contextObjects	==	nil)
            {
                NSLog(@"No data found");
            }
    }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *tableCellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableCellIdentifier];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableCellIdentifier];
    }
    NSString *lastName = [[contextObjects objectAtIndex:indexPath.row]valueForKey:@"lastName"];
    NSString *email = [[contextObjects objectAtIndex:indexPath.row]valueForKey:@"email"];
    NSString *firstName = [[contextObjects objectAtIndex:indexPath.row]valueForKey:@"firstName"];
    NSString *data = [NSString stringWithFormat:@"%@, %@, %@", firstName, lastName, email];
    cell.textLabel.text = data;
    return cell;
}

- (NSFetchedResultsController *)fetchedResultsController
{
    if (fetchedResultsController != nil) {
        return fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Users" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"id" ascending:NO];
    NSArray *sortDescriptors = @[sortDescriptor];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:@"Master"];
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    NSError *error = nil;
	if (![self.fetchedResultsController performFetch:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
	    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
	    abort();
	}
    
    return fetchedResultsController;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return contextObjects.count;
}



- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    UITableView *tableView = self.tableView;
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

@end
