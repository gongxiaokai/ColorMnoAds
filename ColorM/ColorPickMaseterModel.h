//
//  ColorPickMaseterModel.h
//  ColorM
//
//  Created by gongwenkai on 2017/1/26.
//  Copyright © 2017年 gongwenkai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ColorPickMaseterModel : NSObject
@property (nonatomic,copy)NSString *colorName;
@property (nonatomic,copy)NSString *colorDescription;
@property (nonatomic,copy)NSString *color;
@property (nonatomic,strong)NSArray *colors;


- (instancetype)initWithDict:(NSDictionary*)dict;
+ (instancetype)colorPickMaseterModelWithDict:(NSDictionary*)dict;
@end
