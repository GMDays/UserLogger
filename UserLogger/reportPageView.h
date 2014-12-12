//
//  reportPageView.h
//  UserLogger
//
//  Created by carlos andres grijalva on 12/7/14.
//  Copyright (c) 2014 aheer001. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface reportPageView : UIViewController<UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *detailReportButton;

@property (weak, nonatomic) IBOutlet UIPickerView *monthPicker;

@property (strong, nonatomic) NSArray *months;

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property NSInteger search;

@property NSString *month;

-(IBAction)detailReportButton:(id)sender;

-(IBAction)quickCountButton:(id)sender;

-(IBAction)goButton:(id)sender;

@end
