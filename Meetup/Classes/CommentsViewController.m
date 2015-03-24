//
//  CommentsViewController.m
//  Meetup
//
//  Created by Rockstar. on 3/24/15.
//  Copyright (c) 2015 Fantastik. All rights reserved.
//

#import "CommentsViewController.h"
#import "ArticleModel.h"

@interface CommentsViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSArray *commentArray;
@property NSDateFormatter *dteFormatter;

@end

@implementation CommentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];

    // Do any additional setup after loading the view.
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"%d", self.commentArray.count);
    return self.commentArray.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"commentCell"];

    return cell;
}


#pragma mark - Helper 
- (void)loadData {

}

- (void)setCommentArray:(NSMutableArray *)commentArray {
    _commentArray = commentArray;
}

@end
