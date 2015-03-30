//
//  CommentModel.m
//  Meetup
//
//  Created by Rockstar. on 3/29/15.
//  Copyright (c) 2015 Fantastik. All rights reserved.
//

#import "CommentModel.h"
#import "Member.h"

@implementation CommentModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        double time = [dictionary[@"time"] doubleValue] / 1000;
        self.commentDate = [NSDate dateWithTimeIntervalSince1970:time];
        self.comment = dictionary[@"comment"];
        self.member = [Member new];
        self.member.memberID = dictionary[@"member_id"];
        self.member.name = dictionary[@"member_name"];
    }
    return self;
}

+ (void)getCommentsForEvent:(NSString *)eventId withCompletion:(void (^)(NSArray *))completionHandler {
    NSString *urlString =[NSString stringWithFormat:@"https://api.meetup.com/2/event_comments?&sign=true&photo-host=public&event_id=%@&page=20&key=61843107c6fc55826453135e261d", eventId];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
     {
         if (!connectionError)
         {
             NSMutableArray *tempArray = [NSMutableArray new];
             NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
             NSArray *jsonArray = [json objectForKey:@"results"];
             for (NSDictionary *comments in jsonArray)
             {
                 CommentModel *newComment = [[CommentModel alloc]initWithDictionary:comments];
                 [tempArray addObject:newComment];
             }
             completionHandler(tempArray);
         }
     }];
}

@end
