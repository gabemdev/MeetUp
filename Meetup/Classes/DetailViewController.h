//
//  DetailViewController.h
//  Meetup
//
//  Created by Rockstar. on 3/23/15.
//  Copyright (c) 2015 Fantastik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArticleModel.h"

@protocol DetailViewDelegate<NSObject>

- (void)selectedEvent:(ArticleModel *)selectedEvent;

@end

@interface DetailViewController : UIViewController
@property (nonatomic, assign) id<DetailViewDelegate>delegate;
@property ArticleModel *selectedEvent;



@end
