//
//  ColorFavTableViewController.m
//  ColorM
//
//  Created by gongwenkai on 2017/1/30.
//  Copyright © 2017年 gongwenkai. All rights reserved.
//

#import "ColorFavTableViewController.h"
#import "CoreDataOperations.h"
#import "ColorFavTableViewCell.h"

@interface ColorFavTableViewController ()

@property (nonatomic,strong)NSArray *favArray;
@end
static NSString *cellID = @"cellIdendity";

@implementation ColorFavTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"ColorFavTableViewCell" bundle:nil] forCellReuseIdentifier:@"ColorFavCell"];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];


}

- (void)viewWillAppear:(BOOL)animated{
    NSLog(@"will");
    [super viewWillAppear:animated];

    NSArray *array = [[CoreDataOperations sharedInstance] showFavList];
    self.favArray = [NSArray arrayWithArray:array];
    [self.tableView reloadData];
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"t");

    return self.favArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ColorFavTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ColorFavCell" forIndexPath:indexPath];
    if (cell == NULL) {
        [tableView registerNib:[UINib nibWithNibName:@"ColorFavTableViewCell" bundle:nil] forCellReuseIdentifier:@"ColorFavCell"];
        
    }
    Fav *obj = self.favArray[indexPath.row];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设置日期格式
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    //将日期转换成字符串输出
    NSString *currentDateStr = [dateFormatter   stringFromDate:obj.timestamp];
    ColorFavCellModel *model = [[ColorFavCellModel alloc] init];
    model.oxStr = obj.colorOX;
    model.rgbStr = obj.colorRGB;
    model.favTimeStr = currentDateStr;
    model.colorID = obj.colorID;
    cell.model = model;
    
    
    return cell;
}

//行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return CGRectGetWidth(self.view.frame)* 0.2;

}

//滑动删除
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        ColorFavTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        [[CoreDataOperations sharedInstance] deleteWithModel:cell.model];
        NSArray *array = [[CoreDataOperations sharedInstance] showFavList];
        self.favArray = [NSArray arrayWithArray:array];

        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}


@end
