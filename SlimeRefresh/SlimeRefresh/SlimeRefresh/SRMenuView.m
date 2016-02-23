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
    self.clipsToBounds = YES;
    [self addTestText];
}

-(void)addTestText {
    UILabel *label = [[UILabel alloc] initWithFrame:self.bounds];
    label.text = @"这里可以摆放一些控件";
    label.backgroundColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
    
    label.layer.borderWidth = 0.5;
    label.layer.borderColor = [UIColor lightGrayColor].CGColor;
}

-(void)setHeight:(float)height
{
    NSLog(@"height;%f",height);
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, height);
}

- (float)height
{
    return self.frame.size.height;
}


@end
