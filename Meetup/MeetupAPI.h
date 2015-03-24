//
//  MeetupAPI.h
//  Meetup
//
//  Created by Rockstar. on 3/23/15.
//  Copyright (c) 2015 Fantastik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ArticleModel.h"

@interface MeetupAPI : NSObject
typedef void(^CompletionBlock)(BOOL success, NSData *response, NSError *error);

+ (MeetupAPI *)sharedInstance;
@property (nonatomic) NSJSONSerialization *serialization;
@property NSMutableArray *receivedItems;

- (void)requestArticlesWithURL:(NSString *)url withCompletion:(CompletionBlock)completionBlock;

@end
