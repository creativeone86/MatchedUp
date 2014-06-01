//
//  CCConstants.m
//  MatchedUp
//
//  Created by Yordan Georgiev on 5/30/14.
//  Copyright (c) 2014 Code Coalition. All rights reserved.
//

#import "CCConstants.h"

@implementation CCConstants

#pragma mark - User Class

NSString *const kCCuserTagLineKey               = @"tabLine";

NSString *const kCCuserProfileKey               = @"profile";
NSString *const kCCuserProfileFistNameKey       = @"firstName";
NSString *const kCCuserProfileLastNameKey       = @"lastName";
NSString *const kCCuserProfileLocationKey       = @"location";
NSString *const kCCuserProfileGenderKey         = @"gender";
NSString *const kCCuserProfileBirthDayKey       = @"birthDay";
NSString *const kCCuserProfileBioKey            = @"bio";
NSString *const kCCuserProfileEmailKey          = @"email";
NSString *const kCCuserProfilePictureUrlKey     = @"pictureURL";
NSString *const kCCuserProfileAgeKey            = @"age";

#pragma mark - Photo Class

NSString *const kCCPhotoClassKey                = @"Photo";
NSString *const kCCPhotoUserKey                 = @"user";
NSString *const kCCPhotoPictureKey              = @"image";

#pragma mark - Activity Class

NSString *const kCCActivityClassKey             = @"Activity";
NSString *const kCCActivityTypeKey              = @"type";
NSString *const kCCActivityFromUserKey          = @"fromUser";
NSString *const kCCActivityToUserKey            = @"toUser";
NSString *const kCCActivityPhotoKey             = @"photo";
NSString *const kCCActivityTypeLikeKey          = @"like";
NSString *const kCCActivityTypeDislikeKey       = @"dislike";

#pragma mark - Settings

NSString *const kCCMenEnabledKey                = @"men";
NSString *const kCCWomenEnabledKey              = @"women";
NSString *const kCCAgeMaxKey                    = @"ageMax";

@end
