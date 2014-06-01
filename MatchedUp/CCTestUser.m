//
//  CCTestUser.m
//  MatchedUp
//
//  Created by Yordan Georgiev on 6/1/14.
//  Copyright (c) 2014 Code Coalition. All rights reserved.
//

#import "CCTestUser.h"

@implementation CCTestUser

+(void)saveTestUserToParse
{
    PFUser *newUser = [PFUser user];
    newUser.username = @"nightWish";
    newUser.password = @"myBaby";
    
    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            NSDictionary *profile = @{
                                      @"age"        : @16,
                                      @"birthday"   : @"02/07/1998",
                                      @"firstName"  : @"Sonq",
                                      @"lastName"   : @"Bqlkova",
                                      @"gender"     : @"female",
                                      @"location"   : @"Plovdiv/Bulgaria"
                                      };
            [newUser setObject:profile forKey:@"profile"];
            [newUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                UIImage *profileImage = [UIImage imageNamed:@"1459326_549190171836357_1050945138_n.jpg"];
                NSData *imageData = UIImageJPEGRepresentation(profileImage, 0.8);
                
                PFFile *photoFile = [PFFile fileWithData:imageData];
                [photoFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                    if (succeeded) {
                        PFObject *photo = [PFObject objectWithClassName:kCCPhotoClassKey];
                        [photo setObject:newUser forKey:kCCPhotoUserKey];
                        [photo setObject:photoFile forKey:kCCPhotoPictureKey];
                        [photo saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                            NSLog(@"Photo saved successfully");
                        }];
                    }
                }];
                
                
            }];
        }
    }];
}

@end
