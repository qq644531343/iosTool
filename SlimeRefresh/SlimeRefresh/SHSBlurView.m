//
//  SHSBlurView.m
//  ShoppingStreets
//
//  Created by shenbu.lk on 16/1/18.
//  Copyright © 2016年 淘街. All rights reserved.
//

#import "SHSBlurView.h"

@interface SHSBlurView()

@property (nonatomic, strong) UIToolbar *toolbar;

@end

@implementation SHSBlurView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    [self setClipsToBounds:YES];
    
    if (!self.toolbar) {
        [self setToolbar:[[UIToolbar alloc] initWithFrame:[self bounds]]];
        [self.layer insertSublayer:[self.toolbar layer] atIndex:0];
        self.toolbar.barTintColor = nil;
    }
}

- (void) setBlurTintColor:(UIColor *)blurTintColor {
    [self.toolbar setBarTintColor:blurTintColor];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.toolbar setFrame:[self bounds]];
}


@end
