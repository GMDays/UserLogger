//
//  UserViewController.m
//  UserLogger
//
//  Created by Andy Heermance on 12/10/14.
//  Copyright (c) 2014 aheer001. All rights reserved.
//

#import "UserViewController.h"
#import "RegisterViewController.h"

@interface UserViewController ()
{
    NSArray * reasons;
    NSArray * visits;
}
@end

@implementation UserViewController
@synthesize reasonPicker,txtPID,users,flag;
-(void)viewWillAppear:(BOOL)animated
{
    if(flag ==YES)
    {
        txtPID.text = @"";
        UIAlertView *regSuccess = [[UIAlertView alloc]
                                    initWithTitle:@"Success" message:@"You have successfully registered." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [regSuccess show];
        CFRunLoopRunInMode(kCFRunLoopDefaultMode,5, false);
        [regSuccess dismissWithClickedButtonIndex:0 animated:TRUE];
        txtPID.text=@"";
    }
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}
//Number of collumns in UiPickerView
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return reasons.count;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    
    return [reasons objectAtIndex:row];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
   
    // Do any additional setup after loading the view.
    reasons = @[@"Use Equipment",@"Blackboard Help",@"Conference Room",@"Appointment"];
    reasonPicker.dataSource = self;
    reasonPicker.delegate = self;
    flag = NO;
    txtPID.text = @"";
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    // Create a new managed object
    NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:@"LabLog" inManagedObjectContext:context];
    
    
    // If appropriate, configure the new managed object.
    // Normally you should use accessor methods, but using KVC here avoids the need to add a custom class to the template.
    
    [newManagedObject setValue: [reasons objectAtIndex: [reasonPicker selectedRowInComponent:0]] forKey:@"purpose"];
    [newManagedObject setValue: txtPID.text forKey:@"id"];
    
    //Gets current date and strips the time out
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:[NSDate date]];
    [dateComponents setHour:0];
    [dateComponents setMinute:0];
    [dateComponents setSecond:0];
    
    [newManagedObject setValue: [calendar dateFromComponents:dateComponents] forKey:@"time"];
    
    // Save the context.
    NSError *error = nil;
    if (![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        
        abort();
    }
    
}

- (IBAction)submitPID:(UIButton *)sender
{
    NSString * pid = txtPID.text;
    
    //find the set of all non digits
    NSCharacterSet* notDigits = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    
    //check is length of panther id is 7 and that panther id is all digits
    if([pid length] == 7 && [pid rangeOfCharacterFromSet:notDigits].location == NSNotFound)
    {
        NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Users"];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"id == %@", pid];
        [fetchRequest setPredicate:predicate];
        users = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
        
        //if there exists no id in the database that is the same as pid entered, register user
        if(users.count == 0)
        {
            RegisterViewController *childController = [[self storyboard]instantiateViewControllerWithIdentifier:@"RegisterViewController"];
            childController.pid = pid;
            childController.reason = [reasons objectAtIndex: [reasonPicker selectedRowInComponent:0]];
            [self.navigationController pushViewController:childController
                                                 animated:YES];
        }
        //if pid entered is found, sign user in
        else
        {
            [self insertNewObject];
            UIAlertView *loggedIn = [[UIAlertView alloc]
                                        initWithTitle:@"Success" message:@"You are now logged in." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [loggedIn show];
            //keep the message open for a few seconds, then close it.
            CFRunLoopRunInMode(kCFRunLoopDefaultMode,5, false);
            [loggedIn dismissWithClickedButtonIndex:0 animated:TRUE];
            txtPID.text=@"";
            
            /*
            NSManagedObjectContext *managedObjectContext2 = [self managedObjectContext];
            NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"LabLog"];
            //NSPredicate *predicate = [NSPredicate predicateWithFormat:@"id == %@", pid];
            //[fetchRequest setPredicate:predicate];
            visits = [[managedObjectContext2 executeFetchRequest:fetchRequest error:nil] mutableCopy];
            
            for(NSManagedObjectContext * thing in visits)
            {
                NSLog(@"%@",[thing valueForKey:@"time"]);
            }*/
        }
        
    }
    else
    {
        UIAlertView *sevenDigits = [[UIAlertView alloc]
                                        initWithTitle:@"Invalid Panther ID" message:@"Pather ID can only be a 7 digit number." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [sevenDigits show];
        CFRunLoopRunInMode(kCFRunLoopDefaultMode,5, false);
        [sevenDigits dismissWithClickedButtonIndex:0 animated:TRUE];
        txtPID.text=@"";
    }
    
    
}

@end
