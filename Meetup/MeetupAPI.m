//
//  MeetupAPI.m
//  Meetup
//
//  Created by Rockstar. on 3/23/15.
//  Copyright (c) 2015 Fantastik. All rights reserved.
//

#import "MeetupAPI.h"
#import "ArticleModel.h"

@implementation MeetupAPI

+ (MeetupAPI *)sharedInstance {
    static dispatch_once_t once;
    static MeetupAPI *instance;
    dispatch_once(&once, ^{
        if (!instance) {
            instance = [[MeetupAPI alloc] init];
        }
    });
    return instance;
}

- (void)requestArticlesWithURL:(NSString *)url withCompletion:(CompletionBlock)completionBlock {
    NSString *reques = url;
    [self getRequest:reques parameters:nil completion:^(BOOL success, NSData *response, NSError *error) {
        completionBlock(success, response, error);
    }];
}

- (void)getRequest:(NSString *)requesPath parameters:(NSDictionary *)parameters completion:(CompletionBlock)completion {
    NSURL *url = [NSURL URLWithString:requesPath];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {

        if (!connectionError) {
            NSDictionary *itemDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&connectionError];
            NSArray *itemArray = itemDict[@"results"];
            for (NSDictionary *items in itemArray) {
                ArticleModel *model = [[ArticleModel alloc] initWithDictionary:items];
                [self.receivedItems addObject:model];
                NSLog(@"%@", model.eventName);
            }
        }
    }];
}



@end
