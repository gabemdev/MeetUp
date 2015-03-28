//
//  CommentsViewController.m
//  Meetup
//
//  Created by Rockstar. on 3/24/15.
//  Copyright (c) 2015 Fantastik. All rights reserved.
//

#import "CommentsViewController.h"
#import "MeetTableViewCell.h"
#define APIKey @"f73637d7e3e21353b5d7730385f2f77"
#import "MemberViewController.h"
#import "Member.h"

@interface CommentsViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSMutableArray *commentArray;
@property NSDateFormatter *dteFormatter;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSString *memberID;


@end

@implementation CommentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.commentArray = [[NSMutableArray alloc] init];

    NSString *urlString = [NSString stringWithFormat:@"https://api.meetup.com/2/event_comments?&sign=true&photo-host=public&event_id=%@&page=20&key=%@", self.eventID, APIKey];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
     {
         NSError *jsonError = nil;
         NSDictionary *results = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];

         self.commentArray = [results objectForKey:@"results"];
         [self.tableView reloadData];
     }];
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.commentArray.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MeetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"commentCell"];
    NSDictionary *meetup = [self.commentArray objectAtIndex:indexPath.row];

    double timestampval =  [[meetup objectForKey:@"time"] doubleValue]/1000;
    NSTimeInterval timestamp = (NSTimeInterval)timestampval;
    NSDate *updatetimestamp = [NSDate dateWithTimeIntervalSince1970:timestamp];

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateStyle = NSDateFormatterNoStyle;
    formatter.timeStyle = NSDateFormatterShortStyle;

    cell.memberName.text = [meetup objectForKey:@"member_name"];
    cell.time.text = [NSString stringWithFormat:@"Time: %@", [formatter stringFromDate:updatetimestamp]];
    cell.comment.text = [meetup objectForKey:@"comment"];
     self.memberID = meetup[@"member_id"];

    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(UITableViewCell *)cell{
    if ([segue.identifier isEqualToString:@"memberInfo"]) {
        MemberViewController *vc = segue.destinationViewController;
        NSDictionary *meetup = [self.commentArray objectAtIndex:[[self.tableView indexPathForCell:cell] row]];
        vc.memberID =meetup[@"member_id"];

    }
}

@end
