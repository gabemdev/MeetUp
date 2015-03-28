//
//  Member.h
//  Meetup
//
//  Created by Rockstar. on 3/28/15.
//  Copyright (c) 2015 Fantastik. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Member : NSObject

@property NSString *name;
@property NSString *memberID;
@property NSString *location;
@property NSData *imageData;
@property NSArray *topics;

- (void)retrieveMemberData: (NSString *)memberID withCompletion:(void(^)(NSArray *topicsArray))complete;

@end
