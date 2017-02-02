//
//  ColorPickMaseterModel.m
//  ColorM
//
//  Created by gongwenkai on 2017/1/26.
//  Copyright © 2017年 gongwenkai. All rights reserved.
//

#import "ColorPickMaseterModel.h"

@implementation ColorPickMaseterModel

- (instancetype)initWithDict:(NSDictionary*)dict{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}


+ (instancetype)colorPickMaseterModelWithDict:(NSDictionary*)dict{
    return [[ColorPickMaseterModel alloc] initWithDict:dict];
}

@end
