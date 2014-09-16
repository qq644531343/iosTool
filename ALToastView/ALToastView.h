//
//  ALToastView.h
//
//  Created by libo on 16.01.13.
//  Copyright 2013 libo. All rights reserved.


#import <Foundation/Foundation.h>

@interface ALToastView : UIView {
@private
	UILabel *_textLabel;
}

+ (ALToastView *)toastInView:(UIView *)parentView withText:(NSString *)text;

+ (ALToastView *)toastInView:(UIView *)parentView withText:(NSString *)text offSetY:(float)y;

+(void)setDuration:(float)dat;

+(void)enableRotaion:(BOOL)rotaion;


@end
