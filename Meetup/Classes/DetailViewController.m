//
//  DetailViewController.m
//  Meetup
//
//  Created by Rockstar. on 3/23/15.
//  Copyright (c) 2015 Fantastik. All rights reserved.
//

#import "DetailViewController.h"
#import "URLViewController.h"
#import "CommentsViewController.h"

@interface DetailViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UILabel *evenName;
@property (weak, nonatomic) IBOutlet UILabel *evenDescription;
@property (weak, nonatomic) IBOutlet UILabel *groupName;
@property (weak, nonatomic) IBOutlet UILabel *groupInfo;
@property (weak, nonatomic) IBOutlet UIButton *eventButton;
@property (weak, nonatomic) IBOutlet UIButton *rsvpCountButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;


@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadInfo];
    [self updateUI];
    // Do any additional setup after loading the view.
}

#pragma mark - UIWebView
- (void)webViewDidStartLoad:(UIWebView *)webView{
    [self.activityIndicator startAnimating];

}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.activityIndicator stopAnimating];
}


#pragma mark - Helper Methods
- (void)updateUI {
    self.eventButton.layer.cornerRadius = 3;
    self.rsvpCountButton.layer.cornerRadius = self.rsvpCountButton.frame.size.width/2;
    self.rsvpCountButton.userInteractionEnabled = NO;
}

- (void)loadInfo {
    self.evenName.text = self.selectedEvent.eventName;
    self.evenDescription.text = self.selectedEvent.eventDescription;
    self.groupName.text = [NSString stringWithFormat:@"%@",self.selectedEvent.groupName];
    self.groupInfo.text = self.selectedEvent.groupURLName;
    [self.rsvpCountButton setTitle:[NSString stringWithFormat:@"%@", self.selectedEvent.rsvpCount] forState:UIControlStateNormal];

    NSString *urlString = self.selectedEvent.eventDescription;
    self.webView.delegate = self;
    [self.webView loadHTMLString:urlString baseURL:nil];
}


#pragma mark - Segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showWeb"]) {
        URLViewController *vc = segue.destinationViewController;
        vc.webString = self.selectedEvent.eventURL;
    }else if ([segue.identifier isEqualToString:@"comments"]) {
        
        CommentsViewController *vc = segue.destinationViewController;
        vc.eventID = self.selectedEvent.eventID;
        
    }
}
@end
