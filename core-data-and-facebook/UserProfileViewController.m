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

@interface UserProfileViewController ()

@end

static NSString *client_id = @"716336528479611";
static NSString *client_secret = @"45c9fbbad777dc381a8c2cfe9017ebf9";

@implementation UserProfileViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self getInfo];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


- (IBAction)signOut:(id)sender {
    NSLog(@"You're logged out");
    [FBSession.activeSession closeAndClearTokenInformation];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UserProfileViewController *profileViewController = [storyboard instantiateViewControllerWithIdentifier:@"loginViewController"];
    
    [self presentViewController:profileViewController animated:YES completion:nil];
}

- (NSManagedObjectContext *) managedObjectContext{
    return [(AppDelegate *) [[UIApplication sharedApplication] delegate] managedObjectContext];
}

-(void)getInfo {
    [[FBRequest requestForMe] startWithCompletionHandler:^(FBRequestConnection *connection, NSDictionary<FBGraphUser> *user, NSError *error) {
        if (!error) {
            
            NSManagedObjectContext *context = [self managedObjectContext];
            UserModel *newList = [NSEntityDescription insertNewObjectForEntityForName:@"UserData" inManagedObjectContext:context];
            NSLog(@"%@", user[@"first_name"]);
            newList.firstName = user[@"first_name"];
            newList.lastName = user[@"last_name"];
            newList.name = user[@"name"];
            newList.gender = user[@"gender"];
            newList.accessToken = [self getToken];
            newList.idProfile = user[@"id"];
            self.fName = user[@"first_name"];
            self.lName = user[@"last_name"];
            self.fullName = user[@"name"];
            self.gender = user[@"gender"];
            self.token = [self getToken];
            self.idProfile = user[@"id"];
            [self setUIInfo];
            [self showInfo];
        }
    }];
}

- (void) setUIInfo {
    _firstNameLabel.text = _fName;
    _lastNameLabel.text = _lName;
    _nameLabel.text = _fullName;
    _genderLabel.text = _gender;
    _tokenLabel.text = _token;
    _idProfileLabel.text = _idProfile;
    _userImage.profileID = _idProfile;

}

- (void) showInfo {
    // Test listing all FailedBankInfos from the store
    NSManagedObjectContext *context = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"UserData" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSError *error;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    if(!error) {
        for (UserModel *info in fetchedObjects) {
            NSLog(@"Name: %@", info.firstName);
            NSLog(@"Name: %@", info.lastName);
            NSLog(@"Name: %@", info.name);
            NSLog(@"Name: %@", info.gender);
            NSLog(@"Name: %@", info.accessToken);
            NSLog(@"Name: %@", info.idProfile);
        }
    } else {
        NSLog(@"there isn't information to show");
    }
    
}

- (NSString*) getToken {
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/oauth/access_token?grant_type=client_credentials&client_id=%@&client_secret=%@", client_id, client_secret]];
    NSError* error = nil;
    NSString * fullToken = [NSString stringWithContentsOfURL:url encoding:NSASCIIStringEncoding error:&error];
    NSArray *components = [fullToken componentsSeparatedByString:@"="];
    NSString *token = [components objectAtIndex:1];
    return token;
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
