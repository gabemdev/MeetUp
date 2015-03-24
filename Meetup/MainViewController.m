//
//  MainViewController.m
//  Meetup
//
//  Created by Rockstar. on 3/23/15.
//  Copyright (c) 2015 Fantastik. All rights reserved.
//

#import "MainViewController.h"
#import "ArticleModel.h"
#import "MeetupAPI.h"
#import "MeetTableViewCell.h"
#import "DetailViewController.h"

#define APIKey @"f73637d7e3e21353b5d7730385f2f77"
#define APIURL @"https://api.meetup.com/2/open_events.json?zip=60604&text=mobile&time=,1w&key=%@"

@interface MainViewController ()<UITableViewDataSource, UITableViewDelegate, DetailViewDelegate, UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UITableView *feedTableView;
@property UIRefreshControl *refreshControl;
@property (nonatomic) IBOutlet UINavigationItem *navItem;
@property NSDictionary *feedDictionary;
@property NSMutableArray *feedArray;
@property NSMutableArray *imageArray;
@property UIActivityIndicatorView *indicator;
@property ArticleModel *model;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.feedArray = [NSMutableArray new];
    self.imageArray = [NSMutableArray new];
    self.model = [ArticleModel new];
    [self setActivityIndicator];
    [self setRefControl];
    [self getData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {

}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.feedArray) {
    return self.feedArray.count;
    }
    else {
        [self messageView];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];

    if (!self.feedArray.count >0) {
        NSLog(@"Arraya lready loaded");
    }
    else {
        ArticleModel *model = [self.feedArray objectAtIndex:indexPath.row];
        cell.textLabel.text = model.eventName;
        cell.detailTextLabel.text = model.completeAddress;
        [self.indicator stopAnimating];
    }
    

    return cell;

}

#pragma mark - Search Bar
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSString *searchString = searchBar.text;
    NSCharacterSet *charSet = [NSCharacterSet whitespaceCharacterSet];
    if (![[searchString stringByTrimmingCharactersInSet:charSet] length] == 0) {
        [self.indicator startAnimating];
        [self.model searchWithKeyword:searchString withCompletionHandler:^(NSMutableArray *searchArray) {
            self.feedArray = searchArray;
            [self performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
        }];
    }
}


#pragma mark - Helper Methods
- (void)getData {
    NSString *mobile = @"mobile";
    [self.indicator startAnimating];
    [self.model searchWithKeyword:mobile withCompletionHandler:^(NSMutableArray *searchArray) {
        self.feedArray = searchArray;
        [self performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
    }];
}


- (void)selectedEvent:(ArticleModel *)selectedEvent {
     [self performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
}

- (void)reloadData {
    [self.feedTableView reloadData];
    if (self.refreshControl) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MMM d, h:mm a"];
        NSString *title = [NSString stringWithFormat:@"Last update: %@", [formatter stringFromDate:[NSDate date]]];
        NSDictionary *dict = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
        NSAttributedString *attrTitle = [[NSAttributedString alloc] initWithString:title attributes:dict];
        self.refreshControl.attributedTitle = attrTitle;
        [self.refreshControl endRefreshing];

    }
}

- (void)setRefControl {
    UIView *refreshView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [self.feedTableView insertSubview:refreshView atIndex:0];

    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor colorWithRed:0.86 green:0.00 blue:0.16 alpha:1.00];
    self.refreshControl.tintColor = [UIColor whiteColor];
    [self.refreshControl addTarget:self
                            action:@selector(getData)
                  forControlEvents:UIControlEventValueChanged];
    [refreshView addSubview:self.refreshControl];

}

- (void)setActivityIndicator {
    self.indicator= [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    UIBarButtonItem *indicatorButton = [[UIBarButtonItem alloc] initWithCustomView:self.indicator];
    self.navigationItem.rightBarButtonItem = indicatorButton;
    [self.indicator startAnimating];
}

- (void)messageView {
    UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];

    messageLabel.text = @"No data is currently available. Please pull down to refresh.";
    messageLabel.textColor = [UIColor blackColor];
    messageLabel.numberOfLines = 0;
    messageLabel.textAlignment = NSTextAlignmentCenter;
    messageLabel.font = [UIFont fontWithName:@"Avenir-Medium" size:20];
    [messageLabel sizeToFit];

    self.feedTableView.backgroundView = messageLabel;
    self.feedTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma mark - Segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(UITableViewCell *)sender {
    if ([segue.identifier isEqualToString:@"detailView"]) {
        NSIndexPath *indexPath = [self.feedTableView indexPathForCell:sender];
        ArticleModel *event = [self.feedArray objectAtIndex:indexPath.row];
        DetailViewController *vc = segue.destinationViewController;
        vc.selectedEvent = event;
    } 
}


@end
