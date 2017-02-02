//
//  ColorPickTableViewCell.m
//  ColorM
//
//  Created by gongwenkai on 2017/1/26.
//  Copyright © 2017年 gongwenkai. All rights reserved.
//

#import "ColorPickTableViewCell.h"


@interface ColorPickTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *colorDescription;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLab;

@property (weak, nonatomic) IBOutlet UIView *colorType1;
@property (weak, nonatomic) IBOutlet UIView *colorType2;
@property (weak, nonatomic) IBOutlet UIView *colorType3;
@property (weak, nonatomic) IBOutlet UIImageView *line;

@property (weak, nonatomic) IBOutlet UIView *colorType4;
@property (weak, nonatomic) IBOutlet UIImageView *colorName;
@property (weak, nonatomic) IBOutlet UILabel *colorNameLab;
@end

@implementation ColorPickTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCellModel:(ColorPickCellModel *)cellModel {
    _cellModel = cellModel;
    
    //刷新约束
    [self layoutIfNeeded];


    
    NSArray *arr = [_cellModel.color componentsSeparatedByString:@","];
    CGFloat r = [arr[0] floatValue];
    CGFloat g = [arr[1] floatValue];
    CGFloat b = [arr[2] floatValue];
    UIColor *color = [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1];
    self.colorDescription.layer.cornerRadius = 10;
    self.colorName.backgroundColor = color;
    self.colorDescription.backgroundColor = color;
    self.line.backgroundColor = color;
    [self.descriptionLab setTextColor:color];
    self.descriptionLab.text = _cellModel.colorDescription;
    self.colorNameLab.text = _cellModel.colorName;
    
    //type1 btn
    NSArray *type1BtnBg = _cellModel.typeArray[0];
    for (int i = 0; i < 3; i++) {
        CGFloat x = i * self.colorType1.frame.size.width/3;
        CGFloat y = 0;
        CGFloat width = self.colorType1.frame.size.width/3;
        CGFloat height = self.colorType1.frame.size.height;
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(x,y,width,height)];
        btn.tag = 200+i;
        btn.colorStr = type1BtnBg[i];
        NSArray *array = [type1BtnBg[i] componentsSeparatedByString:@","];
        CGFloat r = [array[0] floatValue];
        CGFloat g = [array[1] floatValue];
        CGFloat b = [array[2] floatValue];
        UIColor *color = [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1];
        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        
        btn.backgroundColor = color;
        [self.colorType1 addSubview:btn];

    }
    
    //type2 btn
    NSArray *type2BtnBg = _cellModel.typeArray[1];
    for (int i = 0; i < 3; i++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(i*self.colorType1.frame.size.width/3, 0,self.colorType1.frame.size.width/3, self.colorType1.frame.size.height)];
        btn.tag = 300+i;
        btn.colorStr = type2BtnBg[i];

        NSArray *array = [type2BtnBg[i] componentsSeparatedByString:@","];
        CGFloat r = [array[0] floatValue];
        CGFloat g = [array[1] floatValue];
        CGFloat b = [array[2] floatValue];
        UIColor *color = [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1];
        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];

        btn.backgroundColor = color;
        [self.colorType2 addSubview:btn];
        
    }
    
    
    
    //type3 btn
    NSArray *type3BtnBg = _cellModel.typeArray[2];
    for (int i = 0; i < 3; i++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(i*self.colorType1.frame.size.width/3, 0,self.colorType1.frame.size.width/3, self.colorType1.frame.size.height)];
        btn.tag = 400+i;
        btn.colorStr = type3BtnBg[i];

        NSArray *array = [type3BtnBg[i] componentsSeparatedByString:@","];
        CGFloat r = [array[0] floatValue];
        CGFloat g = [array[1] floatValue];
        CGFloat b = [array[2] floatValue];
        UIColor *color = [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1];
        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];

        btn.backgroundColor = color;
        [self.colorType3 addSubview:btn];
        
    }
    //type4 btn
    NSArray *type4BtnBg = _cellModel.typeArray[3];
    for (int i = 0; i < 3; i++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(i*self.colorType1.frame.size.width/3, 0,self.colorType1.frame.size.width/3, self.colorType1.frame.size.height)];
        btn.tag = 500+i;
        btn.colorStr = type4BtnBg[i];

        NSArray *array = [type4BtnBg[i] componentsSeparatedByString:@","];
        CGFloat r = [array[0] floatValue];
        CGFloat g = [array[1] floatValue];
        CGFloat b = [array[2] floatValue];
        UIColor *color = [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1];
        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        btn.backgroundColor = color;
        [self.colorType4 addSubview:btn];
        
    }

}

//点击事件
- (void)click:(UIButton*)btn{

    if ([self.delegate respondsToSelector:@selector(didSelectedColor:)]) {
        [self.delegate didSelectedColor:btn.colorStr];
    }
}

@end
