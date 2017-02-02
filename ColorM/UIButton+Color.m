//
//  UIButton+Color.m
//  ColorM
//
//  Created by gongwenkai on 2017/1/29.
//  Copyright © 2017年 gongwenkai. All rights reserved.
//

#import "UIButton+Color.h"
static const void *kColorStr = @"colorStr";

@implementation UIButton (Color)
- (NSString *)colorStr {
    return objc_getAssociatedObject(self, kColorStr);
    
}
- (void)setColorStr:(NSString *)colorStr{
    objc_setAssociatedObject(self, kColorStr, colorStr, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

}

@end
