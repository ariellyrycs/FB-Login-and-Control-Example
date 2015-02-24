//
//  UserProfileViewController.m
//  core-data-and-facebook
//
//  Created by Ariel Robles on 2/22/15.
//  Copyright (c) 2015 Ariel Robles. All rights reserved.
//

#import "UserProfileViewController.h"
#import "UserModel.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import <FacebookSDK/FacebookSDK.h>

@interface UserProfileViewController () <FBLoginViewDelegate>
@property (weak, nonatomic) IBOutlet FBProfilePictureView *userImage;
@property (weak, nonatomic) IBOutlet UILabel *firstNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *genderLabel;
@property (weak, nonatomic) IBOutlet UILabel *tokenLabel;
@property (weak, nonatomic) IBOutlet UILabel *idProfileLabel;
- (IBAction)signOut:(id)sender;
- (void) showInfo;
- (void)saveContext;
- (void) deleteCurrentUserInfo;
- (id)getCurrentUser;
@end

@implementation UserProfileViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self showInfo];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

- (IBAction)signOut:(id)sender {
    NSLog(@"You're logged out");
    [self deleteCurrentUserInfo];
    [FBSession.activeSession closeAndClearTokenInformation];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *profileViewController = [storyboard instantiateViewControllerWithIdentifier:@"loginViewController"];
    
    [self presentViewController:profileViewController animated:YES completion:nil];
}

- (NSManagedObjectContext *) managedObjectContext{
    return [(AppDelegate *) [[UIApplication sharedApplication] delegate] managedObjectContext];
}


-(id)getCurrentUser {
    NSManagedObjectContext *context = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [NSFetchRequest new];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"UserModel" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSError *error;
    
    NSArray *results = [context executeFetchRequest:fetchRequest error:&error];
    
    if (error) {
        NSLog(@"Error %@", error);
        return nil;
    }
    
    return [results objectAtIndex:0];
}

- (void) showInfo {
    UserModel *managedObject = self.getCurrentUser;
    self.firstNameLabel.text = managedObject.firstName;
    self.lastNameLabel.text = managedObject.lastName;
    self.nameLabel.text = managedObject.name;
    self.genderLabel.text = managedObject.gender;
    self.tokenLabel.text= managedObject.accessToken;
    self.idProfileLabel.text = self.userImage.profileID = managedObject.idProfile;
    [self saveContext];
}

- (void) deleteCurrentUserInfo {
    NSManagedObject *managedObject = self.getCurrentUser;
    [[self managedObjectContext] deleteObject:managedObject];
    [self saveContext];
}

- (void)saveContext{
    NSError *error;
    if(![[self managedObjectContext] save:&error]){
        NSLog(@"Error %@",error);
    }
}



#pragma mark - FBLoginViewDelegate
/*
- (void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView {
    
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
