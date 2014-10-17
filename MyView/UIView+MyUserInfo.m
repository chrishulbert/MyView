//
//  UIView+MyUserInfo.m
//  MyView
//
//  Created by Chris Hulbert on 17/10/2014.
//  Copyright (c) 2014 Chris Hulbert. All rights reserved.
//

#import "UIView+MyUserInfo.h"

#import <objc/runtime.h>

@implementation UIView (MyUserInfo)

- (void)setMyUserInfo:(id)myUserInfo {
    objc_setAssociatedObject(self, @selector(myUserInfo), myUserInfo, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)myUserInfo {
    return objc_getAssociatedObject(self, @selector(myUserInfo));
}

@end
