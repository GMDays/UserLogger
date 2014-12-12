//
//  PasswordViewController.m
//  UserLogger
//
//  Created by Andy Heermance on 12/11/14.
//  Copyright (c) 2014 aheer001. All rights reserved.
//

#import "PasswordViewController.h"
#import "adminView.h"

@interface PasswordViewController ()
{
    NSArray * passwords;
}
@end

@implementation PasswordViewController
@synthesize txtCurrentPassword,txtNewPassword,txtPassword,txtRepeatedPassword;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSManagedObjectContext *)managedObjectContext
{
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}
- (void)insertNewObject
{
    //Get the context
    NSManagedObjectContext *context = [self managedObjectContext];
    
    // Create a new managed object for Entity Admin
    NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:@"Admin" inManagedObjectContext:context];
    
    
    //Send data to Core data
    
    [newManagedObject setValue:txtPassword.text  forKey:@"password"];
    
    // Save the context.
    NSError *error = nil;
    if (![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        
        abort();
    }
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)signIn:(UIButton *)sender
{
    //used to set inital password
    //[self insertNewObject];
    
    passwords = [[NSArray alloc]init];
    
    NSManagedObjectContext *managedObjectContext2 = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Admin"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"password == %@", txtPassword.text];
    [fetchRequest setPredicate:predicate];
    passwords = [[managedObjectContext2 executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    //clears the password
    txtPassword.text = @"";
    
    //if the password is correct, change to admin view
    if(passwords.count > 0)
    {
        adminView *childController = [[self storyboard]instantiateViewControllerWithIdentifier:@"adminView"];
        [self.navigationController pushViewController:childController
                                             animated:YES];
    }
    
}

- (IBAction)changePassword:(UIButton *)sender
{
    passwords = [[NSArray alloc]init];
    
    NSManagedObjectContext *managedObjectContext2 = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Admin"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"password == %@", txtCurrentPassword.text];
    [fetchRequest setPredicate:predicate];
    passwords = [[managedObjectContext2 executeFetchRequest:fetchRequest error:nil] mutableCopy];
    if(passwords.count > 0)
    {
        if ([txtNewPassword.text isEqual:txtRepeatedPassword.text])
        {
            NSError * error;
            NSManagedObject * managedObject = [passwords objectAtIndex:0];
            managedObjectContext2 = managedObject.managedObjectContext;
            [managedObject setValue:txtNewPassword.text forKey:@"password"];
            [managedObjectContext2 save:&error];
            txtCurrentPassword.text = @"";
            txtNewPassword.text = @"";
            txtRepeatedPassword.text = @"";
        }
    }
    
}
@end
