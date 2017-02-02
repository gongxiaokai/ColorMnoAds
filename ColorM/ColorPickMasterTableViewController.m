//
//  ColorPickMasterTableViewController.m
//  ColorM
//
//  Created by gongwenkai on 2017/1/25.
//  Copyright © 2017年 gongwenkai. All rights reserved.
//

#import "ColorPickMasterTableViewController.h"
#import "ColorPickDetailTableViewController.h"
#import "ColorTypeModel.h"
#import "CoreDataOperations.h"
@interface ColorPickMasterTableViewController ()
@property (nonatomic,strong)NSArray *plistArray;
@property (nonatomic,strong)NSArray *colorArray;
@end
static NSString *cellID = @"reuseIdentifier";

@implementation ColorPickMasterTableViewController

- (NSArray *)plistArray{
    if (!_plistArray) {
        NSMutableArray *array = [NSMutableArray array];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"colorList" ofType:@"plist"];
        NSArray *plist = [NSArray arrayWithContentsOfFile:path];
        for (NSDictionary *dict in plist) {
            ColorTypeModel *model = [ColorTypeModel colorTypeModelModelWithDict:dict];
            [array addObject:model];
        }
        _plistArray = array;

    }
    return _plistArray;
}

- (NSArray *)colorArray {
    if (!_colorArray) {
        _colorArray = [NSArray arrayWithObjects:[UIColor redColor],[UIColor orangeColor],
                                                [UIColor yellowColor],[UIColor greenColor],
                                                [UIColor cyanColor],[UIColor purpleColor],
                                                [UIColor lightGrayColor],nil];
    }
    return _colorArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@",NSHomeDirectory());
    self.title = @"色系";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.plistArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return CGRectGetWidth(self.view.frame)* 0.15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    ColorTypeModel *model = self.plistArray[indexPath.row];
    cell.textLabel.text = model.name;
    cell.detailTextLabel.text = model.descriptionName;
    
    cell.textLabel.textColor = [UIColor blackColor];
    cell.detailTextLabel.textColor = [UIColor darkGrayColor];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.detailTextLabel.backgroundColor = [UIColor clearColor];
    cell.contentView.backgroundColor = self.colorArray[indexPath.row];
    
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSMutableArray *typeArray = [NSMutableArray array];
    for (ColorTypeModel *model in self.plistArray) {
        [typeArray addObject:model.plistName];
    }
    
    ColorPickDetailTableViewController *vc = [[ColorPickDetailTableViewController alloc] initWithColor:typeArray[indexPath.row] andTypeModel:self.plistArray[indexPath.row]];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
