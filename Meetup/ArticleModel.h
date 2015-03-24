//
//  ArticleModel.h
//  Meetup
//
//  Created by Rockstar. on 3/23/15.
//  Copyright (c) 2015 Fantastik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ArticleModel : NSObject


+ (ArticleModel *)sharedInstance;

@property NSString *eventDescription;
@property NSString *eventURL;
@property NSString *eventName;
@property NSString *eventID;
@property NSString *rsvpCount;

@property NSString *groupName;
@property NSString *groupID;
@property NSString *groupURLName;

@property NSString *venueAddress;
@property NSString *venueCity;
@property NSString *venueState;
@property NSString *venueName;

@property NSURL *image;

@property NSArray *comments;


@property NSString *completeAddress;
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
- (void)searchWithKeyword:(NSString *)keyword withCompletionHandler:(void(^)(NSMutableArray *searchArray))completionHandler;




@end
