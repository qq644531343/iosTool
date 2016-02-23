//
//  MenuBaseView.h
//  SlimeRefresh
//
//  Created by libo on 16/2/19.
//  Copyright © 2016年 zrz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FXBlurView/FXBlurView.h"

@class MenuBaseView;

@protocol MenuBaseViewDelegate <NSObject>

- (void)menuBaseView:(MenuBaseView *)menuView cancelBtnClicked:(UIButton *)btn;

@end

@interface MenuBaseView : UIView

+ (MenuBaseView *)getMenuViewWithFrame:(CGRect)frame parentView:(UIView *)view delegate:(id<MenuBaseViewDelegate>)delegate;

- (void)changeAlpha:(float)alpha;

- (void)changeFrame:(CGRect)frame;

@property (nonatomic, strong) UIButton *cancelBtn;



@end
