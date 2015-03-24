//
//  MeetTableViewCell.m
//  Meetup
//
//  Created by Rockstar. on 3/23/15.
//  Copyright (c) 2015 Fantastik. All rights reserved.
//

#import "MeetTableViewCell.h"

@implementation MeetTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier])) {
        self.eventName.textColor = [UIColor colorWithRed:0.86 green:0.00 blue:0.16 alpha:1.00];
        self.eventName.font = [UIFont fontWithName:@"Avenir-Medium" size:17];
        self.eventAddress.textColor = [UIColor colorWithRed:0.45 green:0.45 blue:0.45 alpha:1.00];
        self.eventAddress.font = [UIFont fontWithName:@"Avenir-Roman" size:12];
        self.distance.textColor = [UIColor whiteColor];
        self.distance.font = [UIFont fontWithName:@"Avenir-Light" size:11];
        self.distance.backgroundColor = [UIColor colorWithRed:0.86 green:0.00 blue:0.16 alpha:1.00];
    }
    return self;
}

@end
