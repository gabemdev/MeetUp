//
//  CommentModel.h
//  Meetup
//
//  Created by Rockstar. on 3/29/15.
//  Copyright (c) 2015 Fantastik. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Member;
@interface CommentModel : NSObject

@property NSString *comment;
@property NSDate *commentDate;
@property Member *member;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
+ (void)getCommentsForEvent:(NSString *)eventId withCompletion:(void(^)(NSArray *commentArray))completionHandler;

@end
