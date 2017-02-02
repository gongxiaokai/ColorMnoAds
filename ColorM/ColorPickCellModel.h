//
//  ColorPickCellModel.h
//  ColorM
//
//  Created by gongwenkai on 2017/1/26.
//  Copyright © 2017年 gongwenkai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ColorPickCellModel : NSObject
@property (nonatomic,strong)NSArray *typeArray;

@property (nonatomic,copy)NSString *colorName; //颜色名字
@property (nonatomic,copy)NSString *color;      //颜色
@property (nonatomic,copy)NSString *colorDescription;//颜色描述
@end
