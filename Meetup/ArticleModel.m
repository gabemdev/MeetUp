//
//  ArticleModel.m
//  Meetup
//
//  Created by Rockstar. on 3/23/15.
//  Copyright (c) 2015 Fantastik. All rights reserved.
//

#import "ArticleModel.h"
#define APIKey @"f73637d7e3e21353b5d7730385f2f77"
#define APIURL @"https://api.meetup.com/2/open_events.json?zip=60604&text=mobile&time=,1w&key=%@"
#define APISearch @"https://api.meetup.com/2/open_events.json?zip=60604&text=%@&time=,1w&key=%@"
#define APIComment @"https://api.meetup.com/2/event_comments?&sign=true&photo-host=public&event_id=%@&page=20&key=%@"
#define APIImage @"https://api.meetup.com/2/profiles?&sign=true&photo-host=public&group_id=%@&page=1&key=%@"

@implementation ArticleModel

+ (ArticleModel *)sharedInstance {
    static dispatch_once_t once;
    static ArticleModel *instance;
    dispatch_once(&once, ^{
        if (!instance) {
            instance = [[ArticleModel alloc] init];
        }
    });
    return instance;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        //Event Main
        self.eventDescription = [NSString stringWithFormat:@"<html><head></head><body> %@ </body></html>", dictionary[@"description"]];
        self.eventURL = dictionary[@"event_url"];
        self.eventName = dictionary[@"name"];
        self.eventID = dictionary[@"id"];
        self.rsvpCount = dictionary[@"yes_rsvp_count"];

        //Group
        self.groupName = dictionary[@"group"][@"name"];
        self.groupID = dictionary[@"group"][@"id"];
        self.groupURLName = dictionary[@"group"][@"urlname"];

        //Venue
        self.venueAddress = dictionary[@"venue"][@"address_1"];
        self.venueCity = dictionary[@"venue"][@"city"];
        self.venueState = dictionary[@"venue"][@"state"];
        self.venueName = dictionary[@"venue"][@"name"];

        self.image = dictionary[@"photo_url"];

        //Address
        self.completeAddress = [NSString stringWithFormat:@"%@, %@, %@", self.venueAddress, self.venueCity, self.venueState];

    }
    return self;
}

- (void)searchWithKeyword:(NSString *)keyword withCompletionHandler:(void (^)(NSMutableArray *searchArray))completionHandler {
    NSString *searchString = [NSString stringWithFormat:@"https://api.meetup.com/2/open_events.json?zip=60604&text=%@&time=,1w&key=%@", keyword, APIKey];
    NSURL *url = [NSURL URLWithString:searchString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (!connectionError) {
            NSDictionary *searchDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&connectionError];
            NSArray *array = searchDict[@"results"];
            NSMutableArray *searchResult = [NSMutableArray new];
            for (NSDictionary *searchItems in array) {
                ArticleModel *model = [[ArticleModel alloc] initWithDictionary:searchItems];
                [searchResult addObject:model];
            }
            completionHandler(searchResult);
        }
    }];

}



@end
