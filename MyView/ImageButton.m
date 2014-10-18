//
//  ImageButton.m
//  MyView
//
//  Created by Chris Hulbert on 19/10/2014.
//  Copyright (c) 2014 Chris Hulbert. All rights reserved.
//
//  Button with an image that fades in.

#import "ImageButton.h"

#import "UIImageView+WebCache.h"

@implementation ImageButton {
    UIImageView *_imageView;
    UIView *_darken;
}

+ (instancetype)buttonWithImage:(NSURL *)image {
    ImageButton *button = [self buttonWithType:UIButtonTypeSystem];
    [button postInitWithImage:image];
    return button;
}

- (void)postInitWithImage:(NSURL *)image {
    _imageView = [[UIImageView alloc] init];
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    _imageView.clipsToBounds = YES;
    [self addSubview:_imageView];
    
    __block BOOL loadedSynchronously = YES;
    [_imageView sd_setImageWithURL:image completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        _imageView.image = image;
        _imageView.alpha = 0;
        [UIView animateWithDuration:.3 animations:^{
            _imageView.alpha = 1;
        }];
    }];
    loadedSynchronously = NO;
    
    _darken = [[UIView alloc] init];
    _darken.backgroundColor = [UIColor blackColor];
    _darken.alpha = 0;
    [self addSubview:_darken];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _imageView.frame = self.bounds;
    _darken.frame = self.bounds;
}

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    
    if (highlighted) {
        [UIView animateWithDuration:.1 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            _darken.alpha = .3;
        } completion:nil];
    } else {
        [UIView animateWithDuration:.3 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            _darken.alpha = 0;
        } completion:nil];
    }
}

@end
