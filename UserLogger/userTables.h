//
//  userTables.h
//  UserLogger
//
//  Created by carlos andres grijalva on 12/10/14.
//  Copyright (c) 2014 aheer001. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface userTables : UITableViewController<NSFetchedResultsControllerDelegate, UITableViewDelegate>

@property(strong,nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property NSString *departmentPicked, *lastNamePicked, *pidPicked;
@property NSInteger searchPicked;
@property NSDate *datePicked;
@property NSMutableArray *contextObjects;

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
-(IBAction)deleteContact:(id)sender;

@end
