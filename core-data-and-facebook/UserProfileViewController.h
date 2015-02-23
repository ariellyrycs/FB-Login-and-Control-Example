//
//  UserProfileViewController.h
//  core-data-and-facebook
//
//  Created by Ariel Robles on 2/22/15.
//  Copyright (c) 2015 Ariel Robles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@interface UserProfileViewController : UIViewController <FBLoginViewDelegate>


@property (weak, nonatomic) IBOutlet FBProfilePictureView *userImage;


@property (weak, nonatomic) IBOutlet UILabel *firstNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *genderLabel;
@property (weak, nonatomic) IBOutlet UILabel *tokenLabel;
@property (weak, nonatomic) IBOutlet UILabel *idProfileLabel;


@property (strong, nonatomic) NSString *fName;
@property (strong, nonatomic) NSString *lName;
@property (strong, nonatomic) NSString *fullName;
@property (strong, nonatomic) NSString *gender;
@property (strong, nonatomic) NSString *token;
@property (strong, nonatomic) NSString *idProfile;

- (NSString*) getToken;
- (void) getInfo;
- (void) setUIInfo;
- (void) showInfo;
- (NSManagedObjectContext *) managedObjectContext;


- (IBAction)signOut:(id)sender;


@end
