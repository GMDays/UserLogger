//
//  reportTables.h
//  UserLogger
//
//  Created by carlos andres grijalva on 12/11/14.
//  Copyright (c) 2014 aheer001. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface reportTables : UITableViewController<NSFetchedResultsControllerDelegate, UITableViewDelegate, UITableViewDataSource>

@property NSString *monthPicked;
@property NSInteger searchPicked;

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property(strong,nonatomic) NSFetchedResultsController *fetchedResultsController;
@property NSMutableArray *contextObjects;

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;

@end
