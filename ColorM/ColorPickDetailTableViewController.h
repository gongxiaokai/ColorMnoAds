//
//  ColorPickDetailTableViewController.h
//  ColorM
//
//  Created by gongwenkai on 2017/1/26.
//  Copyright © 2017年 gongwenkai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ColorTypeModel.h"
@interface ColorPickDetailTableViewController : UITableViewController
- (instancetype)initWithColor:(NSString*)colorStr andTypeModel:(ColorTypeModel*)model;
@end
