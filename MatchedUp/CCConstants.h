//
//  CCConstants.h
//  MatchedUp
//
//  Created by Yordan Georgiev on 5/30/14.
//  Copyright (c) 2014 Code Coalition. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCConstants : NSObject
#pragma mark - User Profile

extern NSString *const kCCuserTagLineKey;

extern NSString *const kCCuserProfileKey;
extern NSString *const kCCuserProfileFistNameKey;
extern NSString *const kCCuserProfileLastNameKey;
extern NSString *const kCCuserProfileLocationKey;
extern NSString *const kCCuserProfileGenderKey;
extern NSString *const kCCuserProfileBirthDayKey;
extern NSString *const kCCuserProfileBioKey;
extern NSString *const kCCuserProfileEmailKey;
extern NSString *const kCCuserProfilePictureUrlKey;
extern NSString *const kCCuserProfileAgeKey;

#pragma mark - Photo class

extern NSString *const kCCPhotoClassKey;
extern NSString *const kCCPhotoUserKey;
extern NSString *const kCCPhotoPictureKey;

#pragma mark - Activity Class

extern NSString *const kCCActivityClassKey;
extern NSString *const kCCActivityTypeKey;
extern NSString *const kCCActivityFromUserKey;
extern NSString *const kCCActivityToUserKey;
extern NSString *const kCCActivityPhotoKey;
extern NSString *const kCCActivityTypeLikeKey;
extern NSString *const kCCActivityTypeDislikeKey;

#pragma mark - Settings

extern NSString *const kCCMenEnabledKey;
extern NSString *const kCCWomenEnabledKey;
extern NSString *const kCCAgeMaxKey;

@end
