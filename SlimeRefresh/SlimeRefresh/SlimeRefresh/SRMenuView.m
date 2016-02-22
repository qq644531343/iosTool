//
//  SRMenuView.m
//  SlimeRefresh
//
//  Created by libo on 16/2/22.
//  Copyright © 2016年 zrz. All rights reserved.
//

#import "SRMenuView.h"

@implementation SRMenuView

- (void)configSubViews {
    
    [self addTestText];
}

-(void)addTestText {
    UILabel *label = [[UILabel alloc] initWithFrame:self.bounds];
    label.text = @"这里可以摆放一些控件";
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
    
    label.layer.borderWidth = 0.5;
    label.layer.borderColor = [UIColor lightGrayColor].CGColor;
}


@end
