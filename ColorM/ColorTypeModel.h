//
//  ColorTypeModel.h
//  ColorM
//
//  Created by gongwenkai on 2017/1/30.
//  Copyright © 2017年 gongwenkai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ColorTypeModel : NSObject
@property (nonatomic,copy)NSString *plistName;
@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *descriptionName;
@property (nonatomic,copy)NSString *detail;
- (instancetype)initWithDict:(NSDictionary*)dict;
+ (instancetype)colorTypeModelModelWithDict:(NSDictionary*)dict;
@end
