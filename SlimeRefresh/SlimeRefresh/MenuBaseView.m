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

@property (nonatomic, strong) SHSBlurView *baseView;

@property (nonatomic, weak) id<MenuBaseViewDelegate> delegate;

@end

@implementation MenuBaseView

+ (MenuBaseView *)getMenuViewWithFrame:(CGRect)frame delegate:(id<MenuBaseViewDelegate>)delegate
{
    MenuBaseView *view = [[MenuBaseView alloc] initWithFrame:frame];
//    view.blurTintColor = [[UIColor whiteColor] colorWithAlphaComponent:0.1];
//    view.alpha = 0.7;
    view.backgroundColor = [UIColor clearColor];
    view.delegate = delegate;
    [view configSubViews];
    return view;
}

- (void)configSubViews {
    
    originFrame = self.frame;
    
    self.baseView = [[SHSBlurView alloc] initWithFrame:self.bounds];
    self.baseView.clipsToBounds = YES;
    self.baseView.blurTintColor = [UIColor blackColor];
    self.baseView.alpha = 0.7;
    [self addSubview:self.baseView];
    
    self.cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    self.cancelBtn.frame = CGRectMake(0, 0, 60, 40);
    self.cancelBtn.backgroundColor = [UIColor redColor];
    [self.baseView addSubview:self.cancelBtn];
    self.cancelBtn.center = CGPointMake(self.baseView.center.x, self.baseView.center.y);
    [self.cancelBtn addTarget:self action:@selector(cancelClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)cancelClick:(UIButton *)btn {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(menuBaseView:cancelBtnClicked:)]) {
        [self.delegate menuBaseView:self cancelBtnClicked:btn];
    }
}

@end
