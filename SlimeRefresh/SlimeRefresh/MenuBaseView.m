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

@property (nonatomic, weak) id<MenuBaseViewDelegate> delegate;

@property (nonatomic, strong) UIView *baseView;

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) UIButton *cancelBtn;

@end

@implementation MenuBaseView

+ (MenuBaseView *)getMenuViewWithFrame:(CGRect)frame delegate:(id<MenuBaseViewDelegate>)delegate
{
    MenuBaseView *view = [[MenuBaseView alloc] initWithFrame:frame];
    view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.25];
    view.delegate = delegate;
    [view configSubViews];
    return view;
}

- (void)configSubViews {
    
    originFrame = self.frame;
    
    self.baseView = [[UIView alloc] initWithFrame:self.bounds];
    [self addSubview:self.baseView];
    
    self.contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, 200)];
    self.contentView.backgroundColor = [UIColor whiteColor];
    [self.baseView addSubview:self.contentView];
    
    self.cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    self.cancelBtn.frame = CGRectMake(0, 0, 60, 40);
    self.cancelBtn.backgroundColor = [UIColor redColor];
    [self.baseView addSubview:self.cancelBtn];
    self.cancelBtn.center = CGPointMake(self.baseView.center.x, self.baseView.center.y + 50);
    [self.cancelBtn addTarget:self action:@selector(cancelClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addTestText];
}

-(void)addTestText {
    UILabel *label = [[UILabel alloc] initWithFrame:self.contentView.bounds];
    label.text = @"这里可以摆放一些控件";
    label.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:label];
    
    label.layer.borderWidth = 0.5;
    label.layer.borderColor = [UIColor lightGrayColor].CGColor;
}

- (void)cancelClick:(UIButton *)btn {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(menuBaseView:cancelBtnClicked:)]) {
        [self.delegate menuBaseView:self cancelBtnClicked:btn];
    }
}

#pragma mark - Other

- (void)resetFrame
{
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = originFrame;
    }];
}

@end
