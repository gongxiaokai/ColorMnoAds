//
//  ColorPickTableViewCell.h
//  ColorM
//
//  Created by gongwenkai on 2017/1/26.
//  Copyright © 2017年 gongwenkai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ColorPickCellModel.h"
#import "UIButton+Color.h"

@protocol ColorPickTableViewCellDelegate <NSObject>

//选择的颜色
- (void)didSelectedColor:(NSString*)color;

@end

@interface ColorPickTableViewCell : UITableViewCell

@property (nonatomic,strong)ColorPickCellModel *cellModel;
@property (nonatomic,strong)id<ColorPickTableViewCellDelegate> delegate;
@end
