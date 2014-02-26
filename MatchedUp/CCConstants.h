//
//  CCConstants.h
//  MatchedUp
//
//  Created by Vincent Inverso on 2/21/14.
//  Copyright (c) 2014 Vincent Inverso. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCConstants : NSObject

#pragma mark - user class

extern NSString * const kCCUserTagLineKey;

extern NSString * const kCCUserProfileKey;
extern NSString * const kCCUserProfileNameKey;
extern NSString * const kCCUserProfileFirstNameKey;
extern NSString * const kCCUserProfileLocationKey;
extern NSString * const kCCUserProfileGenderKey;
extern NSString * const kCCUserProfileBirthdayKey;
extern NSString * const kCCUserProfileInterestedInKey;
extern NSString * const kCCUserProfilePictureURL;
extern NSString * const kCCUserProfileRelationshipStatusKey;
extern NSString * const kCCUserProfileAgeKey;

#pragma mark - photo class

extern NSString * const kCCPhotoClassKey;
extern NSString * const kCCPhotoUserKey;
extern NSString * const kCCPhotoPictureKey;

#pragma mark - activity class

extern NSString * const kCCActivityClassKey;
extern NSString * const kCCActivityTypeKey;
extern NSString * const kCCActivityFromUserKey;
extern NSString * const kCCActivityToUserKey;
extern NSString * const kCCActivityPhotoKey;
extern NSString * const kCCActivityTypeLikeKey;
extern NSString * const kCCActivityTypeDislikeKey;


@end
