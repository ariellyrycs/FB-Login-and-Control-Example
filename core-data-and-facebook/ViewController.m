//
//  ViewController.m
//  core-data-and-facebook
//
//  Created by Ariel Robles on 2/22/15.
//  Copyright (c) 2015 Ariel Robles. All rights reserved.
//

#import "ViewController.h"
#import "UserProfileViewController.h"

@interface ViewController ()

@end

@implementation ViewController

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
        UserProfileViewController *profileViewController = [self.profileStoryboard instantiateViewControllerWithIdentifier:@"profileViewController"];
        [self presentViewController:profileViewController animated:YES completion:nil];
    } else {
        [FBSession openActiveSessionWithReadPermissions:@[@"public_profile", @"email"]
                                           allowLoginUI:YES
                                      completionHandler:
         ^(FBSession *session, FBSessionState state, NSError *error) {
             if(!error){
                 UserProfileViewController *profileViewController = [self.profileStoryboard instantiateViewControllerWithIdentifier:@"profileViewController"];
                 [self presentViewController:profileViewController animated:YES completion:nil];
             } else {
                 NSLog(@"It couldn't sign in");
             }
         }];
    }
}
@end
