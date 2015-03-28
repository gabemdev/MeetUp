//
//  MemberViewController.h
//  Meetup
//
//  Created by Rockstar. on 3/28/15.
//  Copyright (c) 2015 Fantastik. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Member;
@interface MemberViewController : UIViewController

@property NSDictionary *meetup;
@property NSString *memberID;
@property Member *member;

@end
