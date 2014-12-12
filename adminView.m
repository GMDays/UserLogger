//
//  adminView.m
//  UserLogger
//
//  Created by carlos andres grijalva on 12/7/14.
//  Copyright (c) 2014 aheer001. All rights reserved.
//

#import "adminView.h"

@implementation adminView
    

-(IBAction)userSearchPage:(id)sender{
    [self performSegueWithIdentifier:@"userSearchView" sender:self];
}

-(IBAction)reportPage:(id)sender{
    [self performSegueWithIdentifier:@"reportPageView" sender:self];
}


@end
