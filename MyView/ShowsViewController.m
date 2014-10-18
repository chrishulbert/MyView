//
//  ShowsViewController.m
//  MyView
//
//  Created by Chris Hulbert on 17/10/2014.
//  Copyright (c) 2014 Chris Hulbert. All rights reserved.
//

#import "ShowsViewController.h"

#import "ShowsView.h"
#import "ShowsService.h"
#import "Show.h"
#import "ShowViewController.h"
#import "UIButton+WebCache.h"
#import "UIView+MyUserInfo.h"

static NSString *kCellId = @"cell";

@implementation ShowsViewController {
    ShowsView *_view;
}

- (id)init {
    if (self = [super init]) {
        self.title = @"Shows";
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    return self;
}

- (void)loadView {
    _view = [[ShowsView alloc] init];
    self.view = _view;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [ShowsService requestShowsWithCompletion:^(NSArray *shows, BOOL success) {
        if (success) {
            // Clear.
            for (UIView *view in _view.subviews.copy) {
                [view removeFromSuperview];
            }
            
            // Add new ones.
            for (Show *show in shows) {
                UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
                [button sd_setBackgroundImageWithURL:show.image forState:UIControlStateNormal];
                button.imageView.contentMode = UIViewContentModeScaleAspectFill;
                button.clipsToBounds = YES;
                button.myUserInfo = show;
                [button addTarget:self action:@selector(tapShow:) forControlEvents:UIControlEventTouchUpInside];
                [_view addSubview:button];
            }
            [_view setNeedsLayout];
        } else {
            NSLog(@"Error");
        }
    }];
}

- (void)tapShow:(UIButton *)button {
    [self.navigationController pushViewController:[[ShowViewController alloc] initWithShow:button.myUserInfo] animated:YES];
}

@end
