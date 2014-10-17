//
//  ShowsViewController.m
//  MyView
//
//  Created by Chris Hulbert on 17/10/2014.
//  Copyright (c) 2014 Chris Hulbert. All rights reserved.
//

#import "ShowsViewController.h"

#import "ShowsService.h"
#import "Show.h"
#import "ShowViewController.h"

static NSString *kCellId = @"cell";

@implementation ShowsViewController {
    NSArray *_shows;
}

- (id)init {
    if (self = [super init]) {
        self.title = @"Shows";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellId];

    [ShowsService requestShowsWithCompletion:^(NSArray *shows, BOOL success) {
        if (success) {
            _shows = shows;
            [self.tableView reloadData];
        } else {
            NSLog(@"Error");
        }
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _shows.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Show *show = _shows[indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellId forIndexPath:indexPath];
    cell.textLabel.text = show.name;

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Show *show = _shows[indexPath.row];
    [self.navigationController pushViewController:[[ShowViewController alloc] initWithShow:show] animated:YES];
}

@end
