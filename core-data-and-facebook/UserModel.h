//
//  UserModel.h
//  core-data-and-facebook
//
//  Created by Ariel Robles on 2/22/15.
//  Copyright (c) 2015 Ariel Robles. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface UserModel : NSManagedObject

@property (nonatomic, retain) NSString * accessToken;
@property (nonatomic, retain) NSString * gender;
@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * idProfile;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSString * name;

@end
