//
//  ColorFavTableViewCell.m
//  ColorM
//
//  Created by gongwenkai on 2017/1/30.
//  Copyright © 2017年 gongwenkai. All rights reserved.
//

#import "ColorFavTableViewCell.h"

@interface ColorFavTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *oxLab;
@property (weak, nonatomic) IBOutlet UILabel *rgbLab;
@property (weak, nonatomic) IBOutlet UILabel *favTimeLab;

@end

@implementation ColorFavTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (NSInteger)numberWithHexString:(NSString *)hexString{
    
    const char *hexChar = [hexString cStringUsingEncoding:NSUTF8StringEncoding];
    
    int hexNumber;
    
    sscanf(hexChar, "%x", &hexNumber);
    
    return (NSInteger)hexNumber;
}

- (void)setModel:(ColorFavCellModel *)model {
    _model = model;
    self.oxLab.text = _model.oxStr;
    self.rgbLab.text = _model.rgbStr;
    self.favTimeLab.text = [NSString stringWithFormat:@"收藏于:%@",_model.favTimeStr];
    NSArray *array = [_model.rgbStr componentsSeparatedByString:@","];
    CGFloat r = [array[0] floatValue];
    CGFloat g = [array[1] floatValue];
    CGFloat b = [array[2] floatValue];
    UIColor *color = [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1];

    self.contentView.backgroundColor = color;
}
@end
