//
//  CustomColorViewController.m
//  ColorM
//
//  Created by gongwenkai on 2017/1/30.
//  Copyright © 2017年 gongwenkai. All rights reserved.
//

#import "CustomColorViewController.h"
#import "WSColorImageView.h"
#import "CoreDataOperations.h"

@interface CustomColorViewController ()
@property(nonatomic,copy)NSString *colorRgbStr;
@end

@implementation CustomColorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat colorWidth = CGRectGetWidth(self.view.frame) * 0.8;
    CGFloat colorX = CGRectGetMidX(self.view.frame) - colorWidth/2;
    CGFloat colorY = 100;
    
    //btn
    CGFloat btnWidth = CGRectGetWidth(self.view.frame) * 0.4;
    CGFloat btnX = CGRectGetMidX(self.view.frame) - btnWidth/2;
    CGFloat btnY = colorY + colorWidth + colorY * 0.2;
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(btnX, btnY, btnWidth, btnWidth/2)];
    [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    //lab ox
    CGFloat laboxWidth = btnWidth;
    CGFloat laboxX = CGRectGetMidX(self.view.frame) - laboxWidth/2;
    CGFloat laboxY = CGRectGetMaxY(btn.frame) + colorY * 0.2;
    UILabel *labelox = [[UILabel alloc]initWithFrame:CGRectMake(laboxX,laboxY,laboxWidth,laboxWidth/4)];
    labelox.textAlignment = NSTextAlignmentCenter;
    labelox.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:labelox];
    
    //lab rgb
    CGFloat labrgbWidth = btnWidth;
    CGFloat labrgbX = CGRectGetMidX(self.view.frame) - laboxWidth/2;
    CGFloat labrgbY = CGRectGetMaxY(labelox.frame);
    UILabel *labelrgb = [[UILabel alloc]initWithFrame:CGRectMake(labrgbX,labrgbY,labrgbWidth,labrgbWidth/4)];
    labelrgb.textAlignment = NSTextAlignmentCenter;
    labelrgb.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:labelrgb];
    
    WSColorImageView *ws = [[WSColorImageView alloc]initWithFrame:CGRectMake(colorX,colorY,colorWidth,colorWidth)];
    [self.view addSubview:ws];
    ws.currentColorBlock = ^(UIColor *color,NSString *rgbStr){
        btn.backgroundColor = color;
        self.colorRgbStr = rgbStr;
        
        NSArray *arr = [rgbStr componentsSeparatedByString:@","];
        int r = [arr[0] intValue];
        int g = [arr[1] intValue];
        int b = [arr[2] intValue];
        
        NSString *rOX = [self stringWithHexNumber:r];
        NSString *gOX = [self stringWithHexNumber:g];
        NSString *bOX = [self stringWithHexNumber:b];
        NSString *ox = [NSString stringWithFormat:@"ox%@%@%@",rOX,gOX,bOX];
        NSString *rgb = [NSString stringWithFormat:@"RGB(%@)",rgbStr];
        labelox.text = ox;
        labelrgb.text = rgb;
    };
    



}




- (void)clickBtn:(UIButton*)btn{
    NSArray *arr = [self.colorRgbStr componentsSeparatedByString:@","];
    CGFloat r = [arr[0] intValue];
    CGFloat g = [arr[1] intValue];
    CGFloat b = [arr[2] intValue];
    
    NSString *rOX = [self stringWithHexNumber:r];
    NSString *gOX = [self stringWithHexNumber:g];
    NSString *bOX = [self stringWithHexNumber:b];
    NSString *oxStr = [NSString stringWithFormat:@"ox%@%@%@",rOX,gOX,bOX];
    NSString *rgbStr = [NSString stringWithFormat:@"RGB(%@)",self.colorRgbStr];

    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"复制到剪切板" preferredStyle:UIAlertControllerStyleActionSheet];
    [alertController addAction:[UIAlertAction actionWithTitle:oxStr style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        [pasteboard setString:oxStr];
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:rgbStr style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        [pasteboard setString:rgbStr];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"收藏" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        //save
        NSLog(@"click fav");
        [[CoreDataOperations sharedInstance] saveColorOX:[NSString stringWithFormat:@"%@%@%@",rOX,gOX,bOX] andRGB:[NSString stringWithFormat:@"%@",self.colorRgbStr]];
        
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];

}

//转16进制字符串
- (NSString *)stringWithHexNumber:(NSUInteger)hexNumber{
    char hexChar[6];
    sprintf(hexChar, "%X", (int)hexNumber);
    NSString *hexString = [NSString stringWithCString:hexChar encoding:NSUTF8StringEncoding];
    return hexString;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
