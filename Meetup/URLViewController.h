//
//  URLViewController.h
//  Meetup
//
//  Created by Rockstar. on 3/23/15.
//  Copyright (c) 2015 Fantastik. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface URLViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *dismissButton;
@property NSString *webString;

@end
