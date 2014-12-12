//
//  userSearchView.h
//  UserLogger
//
//  Created by carlos andres grijalva on 12/7/14.
//  Copyright (c) 2014 aheer001. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface userSearchView : UIViewController <UIPickerViewDelegate>

- (IBAction)departmentSearch:(id)sender;

- (IBAction)dateSearch:(id)sender;

- (IBAction)nameSearch:(id)sender;

- (IBAction)pidSearch:(id)sender;

- (IBAction)goButton:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *pidTextField;

@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;
    
@property (weak, nonatomic) IBOutlet UIPickerView *departmentPicker;

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@property (strong, nonatomic) NSArray *departments;

@property(strong,nonatomic) NSFetchedResultsController *fetchedResultsController;

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property NSInteger search;
@property NSDate *date;
@property NSString *pidString;
@property NSString *lastNameString;
@property NSString *departmentName;

@end
