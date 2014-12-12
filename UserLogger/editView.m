//
//  editView.m
//  UserLogger
//
//  Created by carlos andres grijalva on 12/11/14.
//  Copyright (c) 2014 aheer001. All rights reserved.
//

#import "editView.h"
@interface editView()
{
    NSArray * departments;
}
@end

@implementation editView

@synthesize objectFromTable, firstNameText, lastNameText, departmentPicked, emailText;

-(void)viewDidLoad{
    firstNameText.enabled = NO;
    lastNameText.enabled = NO;
    emailText.enabled = NO;
    
    firstNameText.text = [objectFromTable valueForKey:@"firstName"];
    lastNameText.text = [objectFromTable valueForKey:@"lastName"];
    emailText.text = [objectFromTable valueForKey:@"email"];
    departments = @[@"Computer Science",@"IT",@"Biology",@"English",@"Economics",@"Law",@"Marketing",@"Art",@"Education",@"Engineering"];
    departmentPicked.dataSource = self;
    departmentPicked.delegate = self;
}
//Number of collumns in UiPickerView
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return departments.count;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [departments objectAtIndex:row];
}
-(void)viewWillAppear:(BOOL)animated{
    firstNameText.text = [objectFromTable valueForKey:@"firstName"];
    lastNameText.text = [objectFromTable valueForKey:@"lastName"];
    emailText.text = [objectFromTable valueForKey:@"email"];
}

-(IBAction)editButton:(id)sender{
    firstNameText.enabled = YES;
    lastNameText.enabled = YES;
    emailText.enabled = YES;
    


}

-(IBAction)saveButton:(id)sender{
    //NSManagedObjectContext *context = [self managedObjectContext]
    NSError *error;
    if(self.objectFromTable){
        self.managedObjectContext = objectFromTable.managedObjectContext;
        [objectFromTable setValue:firstNameText.text forKey:@"firstName"];
        [objectFromTable setValue:lastNameText.text forKey:@"lastName"];
        [objectFromTable setValue:emailText.text forKey:@"email"];
        [objectFromTable setValue:[departments objectAtIndex:[departmentPicked selectedRowInComponent:0]] forKey:@"department"];
        [self.managedObjectContext save:&error];
        //[objectFromTable save:&error];
    }
    
}

@end
