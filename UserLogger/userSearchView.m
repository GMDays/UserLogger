//
//  userSearchView.m
//  UserLogger
//
//  Created by carlos andres grijalva on 12/7/14.
//  Copyright (c) 2014 aheer001. All rights reserved.
//

#import "userSearchView.h"
#import "userTables.h"
#import "reportPageView.h"

@implementation userSearchView

@synthesize departmentPicker, datePicker, departments, fetchedResultsController, managedObjectContext;
@synthesize lastNameTextField, pidTextField, search, lastNameString, pidString, departmentName, date;

-(void)viewDidLoad{
    departments = @[@"Computer Science", @"IT", @"Biology", @"English", @"Economics", @"Law", @"Marketing", @"Art", @"Education", @"Engineering"];
    self.departmentPicker.dataSource = self;
    self.departmentPicker.delegate = self;
    departmentPicker.hidden = YES;
    datePicker.hidden = YES;
    lastNameTextField.hidden = YES;
    pidTextField.hidden = YES;
    
}

- (IBAction)departmentSearch:(id)sender {
    departmentPicker.hidden = NO;
    datePicker.hidden = YES;
    lastNameTextField.hidden = YES;
    pidTextField.hidden = YES;
    search = 1;
}

- (IBAction)dateSearch:(id)sender {
    datePicker.hidden = NO;
    departmentPicker.hidden = YES;
    lastNameTextField.hidden = YES;
    pidTextField.hidden = YES;
    search = 2;
}

- (IBAction)nameSearch:(id)sender {
    lastNameTextField.hidden = NO;
    departmentPicker.hidden = YES;
    datePicker.hidden = YES;
    pidTextField.hidden = YES;
    search = 3;
}

- (IBAction)pidSearch:(id)sender {
    pidTextField.hidden = NO;
    departmentPicker.hidden = YES;
    datePicker.hidden = YES;
    lastNameTextField.hidden = YES;
    search = 4;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return departments.count;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
   
    
    return [departments objectAtIndex:row];
}

- (void)insertNewObject:(id)sender
{
    NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
    NSEntityDescription *entity = [[self.fetchedResultsController fetchRequest] entity];
    NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:context];
    
    // If appropriate, configure the new managed object.
    // Normally you should use accessor methods, but using KVC here avoids the need to add a custom class to the template.
    [newManagedObject setValue:[NSDate date] forKey:@"department"];
    [newManagedObject setValue:[NSDate date] forKey:@"email"];
    [newManagedObject setValue:[NSDate date] forKey:@"department"];
    [newManagedObject setValue:[NSDate date] forKey:@"firstName"];
    [newManagedObject setValue:[NSDate date] forKey:@"lastName"];
    [newManagedObject setValue:[NSDate date] forKey:@"pid"];

    // Save the context.
    NSError *error = nil;
    if (![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
}



- (IBAction)goButton:(id)sender{
    if(search == 1){
        NSInteger row = [departmentPicker selectedRowInComponent:0];
        departmentName = [departments objectAtIndex:row];
    }
    
    else if (search == 2){
        date = datePicker.date;
        NSLog(@"%@",date);
    }
    else if(search == 3){
        lastNameString = lastNameTextField.text;
    }
    
    else if (search == 4){
        pidString = pidTextField.text;
    }
    
    [self performSegueWithIdentifier:@"tableView" sender:self];

}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"tableView"]) {
        userTables *table = segue.destinationViewController;
        table.departmentPicked = departmentName;
        table.searchPicked = search;
        table.pidPicked = pidString;
        table.datePicked = date;
        table.lastNamePicked = lastNameString;
    }
    else if([[segue identifier] isEqualToString:@"reportPageView"]){
        reportPageView *report = segue.destinationViewController;
        
    }
}


@end
