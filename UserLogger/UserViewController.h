//
//  UserViewController.h
//  UserLogger
//
//  Created by Andy Heermance on 12/10/14.
//  Copyright (c) 2014 aheer001. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
@interface UserViewController : UIViewController<UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UIPickerView *reasonPicker;
@property (weak, nonatomic) IBOutlet UITextField *txtPID;
@property BOOL flag;
@property (strong) NSMutableArray *users;
- (IBAction)submitPID:(UIButton *)sender;

@end
