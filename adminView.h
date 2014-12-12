//
//  adminView.h
//  UserLogger
//
//  Created by carlos andres grijalva on 12/7/14.
//  Copyright (c) 2014 aheer001. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface adminView : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *userSearchButton;
@property (weak, nonatomic) IBOutlet UIButton *reportButton;

-(IBAction)userSearchPage:(id)sender;
-(IBAction)reportPage:(id)sender;

@end
