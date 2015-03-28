//
//  MeetTableViewCell.h
//  Meetup
//
//  Created by Rockstar. on 3/23/15.
//  Copyright (c) 2015 Fantastik. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MeetTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *meetImage;
@property (weak, nonatomic) IBOutlet UILabel *eventName;
@property (weak, nonatomic) IBOutlet UILabel *eventAddress;
@property (weak, nonatomic) IBOutlet UILabel *distance;
@property (weak, nonatomic) IBOutlet UILabel *memberName;
@property (weak, nonatomic) IBOutlet UILabel *comment;
@property (weak, nonatomic) IBOutlet UILabel *time;


@end
