//
//  PasswordViewController.h
//  UserLogger
//
//  Created by Andy Heermance on 12/11/14.
//  Copyright (c) 2014 aheer001. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PasswordViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
@property (weak, nonatomic) IBOutlet UITextField *txtCurrentPassword;
@property (weak, nonatomic) IBOutlet UITextField *txtNewPassword;
@property (weak, nonatomic) IBOutlet UITextField *txtRepeatedPassword;
- (IBAction)signIn:(UIButton *)sender;
- (IBAction)changePassword:(UIButton *)sender;


@end
