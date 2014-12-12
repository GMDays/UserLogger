//
//  reportPageView.m
//  UserLogger
//
//  Created by carlos andres grijalva on 12/7/14.
//  Copyright (c) 2014 aheer001. All rights reserved.
//

#import "reportPageView.h"
#import "userSearchView.h"
#import "reportTables.h"

@implementation reportPageView

@synthesize months, monthPicker, managedObjectContext, search, month;



-(void)viewDidLoad{
    months = @[@"January", @"February", @"March", @"April", @"May", @"June", @"July", @"August", @"September", @"October", @"November", @"December"];
    self.monthPicker.dataSource = self;
    self.monthPicker.delegate = self;
    monthPicker.hidden = YES;
    
}

-(IBAction)detailReportButton:(id)sender{
    search = 1;
    monthPicker.hidden = NO;
}

-(IBAction)quickCountButton:(id)sender{
    
    search = 2;
}

-(IBAction)goButton:(id)sender{
    if(search == 1){
        NSInteger row = [monthPicker selectedRowInComponent:0];
        month = [months objectAtIndex:row];
    }
    
    [self performSegueWithIdentifier:@"reportTables" sender:self];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"reportTables"]) {
        reportTables *table = segue.destinationViewController;
        table.monthPicked = month;
        table.searchPicked = search;
    }
    
    else if([[segue identifier] isEqualToString:@"reportTables"]){
        reportTables *table = segue.destinationViewController;
        table.searchPicked = search;
    }
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return months.count;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    
    return [months objectAtIndex:row];
}
@end
