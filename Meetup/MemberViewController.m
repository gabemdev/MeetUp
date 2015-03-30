//
//  MemberViewController.m
//  Meetup
//
//  Created by Rockstar. on 3/28/15.
//  Copyright (c) 2015 Fantastik. All rights reserved.
//

#import "MemberViewController.h"
#define APIKey @"f73637d7e3e21353b5d7730385f2f77"
#import "Member.h"

@interface MemberViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSArray *memberArray;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UILabel *locationLabel;
@property (strong, nonatomic) IBOutlet UIImageView *memberImageView;
@property (weak, nonatomic) IBOutlet UILabel *memberLabel;
@property NSString *imageString;

@end

@implementation MemberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.memberArray = [[NSMutableArray alloc] init];

    NSString *urlString = [NSString stringWithFormat:@"https://api.meetup.com/2/members?&sign=true&photo-host=public&member_id=%@&page=20&key=%@", self.memberID, APIKey];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
     {
         NSError *jsonError = nil;
         NSDictionary *results = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
         NSDictionary *resultDict = results[@"results"][0];
         self.locationLabel.text = [NSString stringWithFormat:@"%@, %@", resultDict[@"city"], resultDict[@"state"]];
         self.memberLabel.text = [NSString stringWithFormat:@"%@", resultDict[@"name"]];
         self.memberImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:resultDict[@"photo"][@"photo_link"]]]];

         NSLog(@"Reult Dict %@", resultDict);
     }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"topicCell"];
//    cell.textLabel.text = [self.memberArray objectAtIndex: indexPath.row];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.memberArray.count;
}

@end
