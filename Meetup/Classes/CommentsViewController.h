//
//  CommentsViewController.h
//  Meetup
//
//  Created by Rockstar. on 3/24/15.
//  Copyright (c) 2015 Fantastik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArticleModel.h"
#import "DetailViewController.h"
@interface CommentsViewController : UIViewController<DetailViewDelegate>

@property ArticleModel *selectedEvent;

@end