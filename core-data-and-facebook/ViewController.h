//
//  ViewController.h
//  core-data-and-facebook
//
//  Created by Ariel Robles on 2/22/15.
//  Copyright (c) 2015 Ariel Robles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
@interface ViewController : UIViewController <FBLoginViewDelegate>
@property UIStoryboard *profileStoryboard;
//@property (weak, nonatomic) IBOutlet FBLoginView *loginButton;
- (IBAction)fbSignIn:(id)sender;

@end

