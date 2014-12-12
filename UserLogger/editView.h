//
//  editView.h
//  UserLogger
//
//  Created by carlos andres grijalva on 12/11/14.
//  Copyright (c) 2014 aheer001. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface editView : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *firstNameText;
@property (weak, nonatomic) IBOutlet UITextField *lastNameText;
@property (weak, nonatomic) IBOutlet UITextField *emailText;
@property (weak, nonatomic) IBOutlet UIPickerView *departmentPicked;

@property NSManagedObject *objectFromTable;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
-(IBAction)editButton:(id)sender;
-(IBAction)saveButton:(id)sender;
@end
