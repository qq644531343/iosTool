//
//  MenuBaseView.h
//  SlimeRefresh
//
//  Created by libo on 16/2/19.
//  Copyright © 2016年 zrz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SHSBlurView.h"

@class MenuBaseView;

@protocol MenuBaseViewDelegate <NSObject>

- (void)menuBaseView:(MenuBaseView *)menuView cancelBtnClicked:(UIButton *)btn;

@end

@interface MenuBaseView : UIView

+ (MenuBaseView *)getMenuViewWithFrame:(CGRect)frame delegate:(id<MenuBaseViewDelegate>)delegate;

@property (nonatomic, strong) UIButton *cancelBtn;

@end
