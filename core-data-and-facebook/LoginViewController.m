//
//  ViewController.m
//  core-data-and-facebook
//
//  Created by Ariel Robles on 2/22/15.
//  Copyright (c) 2015 Ariel Robles. All rights reserved.
//



#import "LoginViewController.h"
#import "UserProfileViewController.h"
#import <FacebookSDK/FacebookSDK.h>
#import "UserModel.h"
#import "AppDelegate.h"

@interface LoginViewController () <FBLoginViewDelegate>
@property UIStoryboard *profileStoryboard;
- (IBAction)fbSignIn:(id)sender;
- (void)getInfo;
- (NSManagedObjectContext *) managedObjectContext;
@end

@implementation LoginViewController

#pragma mark - Life Circle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.profileStoryboard = [UIStoryboard storyboardWithName:@"UserProfile" bundle:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

- (IBAction)fbSignIn:(id)sender{
    if (FBSession.activeSession.isOpen) {
        [self changeStoryboard];
    }
    [FBSession openActiveSessionWithReadPermissions:@[@"public_profile", @"email"]
                                       allowLoginUI:YES
                                  completionHandler:
     ^(FBSession *session, FBSessionState state, NSError *error) {
         if(!error){
             [self getInfo];
         } else {
             NSLog(@"It couldn't sign in");
         }
     }];
}


-(void)getInfo {
    [[FBRequest requestForMe] startWithCompletionHandler:^(FBRequestConnection *connection, NSDictionary<FBGraphUser> *user, NSError *error) {
        if (!error) {
            NSManagedObjectContext *context = [self managedObjectContext];
            UserModel *newList = [NSEntityDescription insertNewObjectForEntityForName:@"UserModel" inManagedObjectContext:context];
            newList.firstName = user[@"first_name"];
            newList.lastName = user[@"last_name"];
            newList.name = user[@"name"];
            newList.gender = user[@"gender"];
            newList.accessToken = [self getToken];
            newList.idProfile = user[@"id"];
            [self performSelector:@selector(changeStoryboard) withObject:nil afterDelay:0.3];
        }
    }];
}


- (void)changeStoryboard {
    
    AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    UserProfileViewController *profileViewController = [self.profileStoryboard instantiateViewControllerWithIdentifier:@"profileViewController"];
    
    
    
    [UIView animateWithDuration:0.5 animations:^{
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:appDelegate.window cache:NO];
        appDelegate.window.rootViewController = profileViewController;
    }];
    
    
//    UserProfileViewController *profileViewController = [self.profileStoryboard instantiateViewControllerWithIdentifier:@"profileViewController"];
//    [self presentViewController:profileViewController animated:YES completion:nil];
}

- (NSString*) getToken {
    return FBSession.activeSession.accessTokenData.accessToken;
}

- (NSManagedObjectContext *) managedObjectContext {
    return [(AppDelegate *) [[UIApplication sharedApplication] delegate] managedObjectContext];
}
@end
