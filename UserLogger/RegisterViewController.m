//
//  RegisterViewController.m
//  UserLogger
//
//  Created by Andy Heermance on 12/10/14.
//  Copyright (c) 2014 aheer001. All rights reserved.
//

#import "RegisterViewController.h"
#import "UserViewController.h"
#import <MessageUI/MessageUI.h>
@interface RegisterViewController ()
{
    NSArray * departments;
}
@end

@implementation RegisterViewController

@synthesize pid,departmentPicker,txtEmail,txtFirstName,txtLastName,theUsers,reason;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Register", @"Register");
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    departments = @[@"Computer Science",@"IT",@"Biology",@"English",@"Economics",@"Law",@"Marketing",@"Art",@"Education",@"Engineering"];
    departmentPicker.dataSource = self;
    departmentPicker.delegate = self;
}
//Number of collumns in UiPickerView
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return departments.count;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [departments objectAtIndex:row];
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
- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}
- (void)insertNewObjectToLabLog
{
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    // Create a new managed object
    NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:@"LabLog" inManagedObjectContext:context];
    
    
    // If appropriate, configure the new managed object.
    // Normally you should use accessor methods, but using KVC here avoids the need to add a custom class to the template.
    [newManagedObject setValue: reason forKey:@"purpose"];
    [newManagedObject setValue: pid forKey:@"id"];
    [newManagedObject setValue:[NSDate date] forKey:@"time"];
    
    // Save the context.
    NSError *error = nil;
    if (![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        
        abort();
    }
    
}
- (void)insertNewObject
{
    //Get the context
    NSManagedObjectContext *context = [self managedObjectContext];
    
    // Create a new managed object for Entity Users
    NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:@"Users" inManagedObjectContext:context];
    
    
    //Send data to Core data
    [newManagedObject setValue: [departments objectAtIndex:[departmentPicker selectedRowInComponent:0]] forKey:@"department"];
    [newManagedObject setValue: txtEmail.text forKey:@"email"];
    [newManagedObject setValue:txtFirstName.text forKey:@"firstName"];
    [newManagedObject setValue:txtLastName.text forKey:@"lastName"];
    [newManagedObject setValue:pid forKey:@"id"];
    
    // Save the context.
    NSError *error = nil;
    if (![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        
        abort();
    }
    
}
- (NSFetchedResultsController *)fetchedResultsController
{
    
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Users" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor1 = [[NSSortDescriptor alloc] initWithKey:@"department" ascending:NO];
    NSSortDescriptor *sortDescriptor2 = [[NSSortDescriptor alloc] initWithKey:@"email" ascending:NO];
    NSSortDescriptor *sortDescriptor3 = [[NSSortDescriptor alloc] initWithKey:@"firstName" ascending:NO];
    NSSortDescriptor *sortDescriptor4 = [[NSSortDescriptor alloc] initWithKey:@"lastName" ascending:NO];
    NSSortDescriptor *sortDescriptor5 = [[NSSortDescriptor alloc] initWithKey:@"id" ascending:NO];
    NSArray *sortDescriptors = @[sortDescriptor1,sortDescriptor2,sortDescriptor3,sortDescriptor4,sortDescriptor5];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:@"Register"];
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
    NSError *error = nil;
    if (![self.fetchedResultsController performFetch:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _fetchedResultsController;
}
- (CIImage *)createQRForString:(NSString *)qrString
{
    // Need to convert the string to a UTF-8 encoded NSData object
    NSData *stringData = [qrString dataUsingEncoding:NSUTF8StringEncoding];
    
    // Create the filter
    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // Set the message content and error-correction level
    [qrFilter setValue:stringData forKey:@"inputMessage"];
    [qrFilter setValue:@"M" forKey:@"inputCorrectionLevel"];
    
    // Send the image back
    return qrFilter.outputImage;
}
- (UIImage *)createNonInterpolatedUIImageFromCIImage:(CIImage *)image withScale:(CGFloat)scale
{
    // Render the CIImage into a CGImage
    CGImageRef cgImage = [[CIContext contextWithOptions:nil] createCGImage:image fromRect:image.extent];
    
    // Now we'll rescale using CoreGraphics
    UIGraphicsBeginImageContext(CGSizeMake(image.extent.size.width * scale, image.extent.size.width * scale));
    CGContextRef context = UIGraphicsGetCurrentContext();
    // We don't want to interpolate (since we've got a pixel-correct image)
    CGContextSetInterpolationQuality(context, kCGInterpolationNone);
    CGContextDrawImage(context, CGContextGetClipBoundingBox(context), cgImage);
    // Get the image out
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // Tidy up
    UIGraphicsEndImageContext();
    CGImageRelease(cgImage);
    return scaledImage;
}
- (IBAction)registerUser:(UIButton *)sender
{
    if([txtLastName.text  isEqual: @""] || [txtFirstName.text  isEqual:@""] ||
       [txtEmail.text  isEqual: @""])
    {
        UIAlertView *noEmpty = [[UIAlertView alloc]
                                    initWithTitle:@"Empty Fields" message:@"Please fill out all of the fields." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [noEmpty show];
        CFRunLoopRunInMode(kCFRunLoopDefaultMode,5, false);
        [noEmpty dismissWithClickedButtonIndex:0 animated:TRUE];
        
    }
    else
    {
        [self insertNewObject];
        [self insertNewObjectToLabLog];
        
        NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
        
        //NSPredicate *predicate = [NSPredicate predicateWithFormat:@"id == %@", @"1234567"];
        
        
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"LabLog"];
        //[fetchRequest setPredicate:predicate];
        theUsers = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
        //NSLog(@"%@",[[theUsers objectAtIndex:0]valueForKey:@"firstName"]);
        for(NSManagedObjectContext* thing in theUsers)
        {
            NSLog(@"%@",[thing valueForKey:@"purpose"]);
        }
        CIImage *qrCode = [self createQRForString:pid];
        UIImage *qrCodeImg = [self createNonInterpolatedUIImageFromCIImage:qrCode withScale:2*[[UIScreen mainScreen] scale]];
        NSData * qrToJpg = UIImageJPEGRepresentation(qrCodeImg, 1.0 );
        [self showEmail:qrToJpg];
        //UIImageWriteToSavedPhotosAlbum (qrCodeImg, nil, nil , nil);
        //theQR.image = qrCodeImg;
        
        
        UserViewController * child = [self.navigationController.viewControllers objectAtIndex:0];
        child.flag = YES;
        
        [self.navigationController popToViewController:child animated:(YES)];
    }
}
- (void)showEmail:(NSData*)file {
    
    NSString *emailTitle = @"Welcome to the ETS Lab";
    NSString *messageBody =[NSString stringWithFormat: @"Hello %@ ,check this out!", txtFirstName.text];
    NSArray *toRecipents = [NSArray arrayWithObject:txtEmail.text];
    
    
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setSubject:emailTitle];
    [mc setMessageBody:messageBody isHTML:YES];
    [mc setToRecipients:toRecipents];
    
    
    
   
    // Add attachment
    [mc addAttachmentData:file mimeType:@"image/jpeg" fileName:[NSString stringWithFormat:@"qr.jpg"]];
    
    //show email view
    //[self presentViewController:mc animated:YES completion:NULL];
    
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    NSLog(@"hello");
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}
@end
