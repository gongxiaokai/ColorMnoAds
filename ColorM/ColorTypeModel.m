//
//  ColorTypeModel.m
//  ColorM
//
//  Created by gongwenkai on 2017/1/30.
//  Copyright © 2017年 gongwenkai. All rights reserved.
//

#import "ColorTypeModel.h"

@implementation ColorTypeModel
- (instancetype)initWithDict:(NSDictionary*)dict{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
+ (instancetype)colorTypeModelModelWithDict:(NSDictionary*)dict{
    return [[ColorTypeModel alloc] initWithDict:dict];
}
@end
