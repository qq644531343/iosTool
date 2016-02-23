//
//  MenuBaseView.m
//  SlimeRefresh
//
//  Created by libo on 16/2/19.
//  Copyright © 2016年 zrz. All rights reserved.
//

#import "MenuBaseView.h"

@interface MenuBaseView ()
{
    CGRect originFrame;
}

@property (nonatomic, strong) FXBlurView *blurView;

@property (nonatomic, strong) UIView *baseView;

@property (nonatomic, weak) UIView *parentView;

@property (nonatomic, weak) id<MenuBaseViewDelegate> delegate;

@end

@implementation MenuBaseView

+ (MenuBaseView *)getMenuViewWithFrame:(CGRect)frame parentView:(UIView *)view delegate:(id<MenuBaseViewDelegate>)delegate
{
    FXBlurView *blurView = [[FXBlurView alloc] initWithFrame:frame];
    blurView.blurRadius = 15;
    blurView.tintColor = [UIColor clearColor];
    blurView.userInteractionEnabled = NO;
    blurView.hidden = YES;
    [view addSubview:blurView];
    
    MenuBaseView *menu = [[MenuBaseView alloc] initWithFrame:frame];
    menu.parentView = view;
    menu.blurView = blurView;
    menu.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    menu.delegate = delegate;
    
    [menu configSubViews];
    
    [view addSubview:menu];
    
    return menu;
}

- (void)configSubViews {
    
    originFrame = self.frame;
    
    self.baseView = [[UIView alloc] initWithFrame:self.bounds];
    self.baseView.clipsToBounds = YES;
    [self addSubview:self.baseView];
    
    self.cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    self.cancelBtn.frame = CGRectMake(0, 0, 60, 40);
    self.cancelBtn.backgroundColor = [UIColor redColor];
    [self addSubview:self.cancelBtn];
    self.cancelBtn.center = CGPointMake(self.baseView.center.x, self.baseView.center.y);
    [self.cancelBtn addTarget:self action:@selector(cancelClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
}

- (void)cancelClick:(UIButton *)btn {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(menuBaseView:cancelBtnClicked:)]) {
        [self.delegate menuBaseView:self cancelBtnClicked:btn];
    }
}

- (void)changeAlpha:(float)alpha
{
    self.alpha = alpha;
    if (alpha == 0) {
        self.blurView.hidden = YES;
    }else {
        self.blurView.hidden = NO;
    }
    
}

- (void)changeFrame:(CGRect)frame
{
    self.frame = frame;
    self.blurView.frame = frame;
}

@end
