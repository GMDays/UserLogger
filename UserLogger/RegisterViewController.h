//
//  RegisterViewController.h
//  UserLogger
//
//  Created by Andy Heermance on 12/10/14.
//  Copyright (c) 2014 aheer001. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <MessageUI/MessageUI.h>
@interface RegisterViewController : UIViewController<UINavigationControllerDelegate,UIPickerViewDelegate,MFMailComposeViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *txtFirstName;
@property (weak, nonatomic) IBOutlet UITextField *txtLastName;
@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
@property (weak, nonatomic) IBOutlet UIPickerView *departmentPicker;
@property (nonatomic, copy) NSString * pid;
@property (nonatomic, copy) NSString * reason;
@property (strong) NSMutableArray *theUsers;
- (IBAction)registerUser:(UIButton *)sender;
@property(strong,nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error;
@end
