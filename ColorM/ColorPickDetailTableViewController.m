//
//  ColorPickDetailTableViewController.m
//  ColorM
//
//  Created by gongwenkai on 2017/1/26.
//  Copyright © 2017年 gongwenkai. All rights reserved.
//

#import "ColorPickDetailTableViewController.h"
#import "ColorPickMaseterModel.h"
#import "ColorPickTableViewCell.h"
#import "CoreDataOperations.h"
@interface ColorPickDetailTableViewController ()<ColorPickTableViewCellDelegate>
@property (nonatomic,strong)NSArray *colorArray;//plist
@property (nonatomic,copy)NSString *colorStr; //rgb
@property (nonatomic,strong)ColorTypeModel *typeModel;
@property (nonatomic,assign)CGFloat headerHeight;
@end

@implementation ColorPickDetailTableViewController
- (NSArray*)colorArray {
    if (!_colorArray) {
        NSMutableArray *array = [NSMutableArray array];
        NSString *path = [[NSBundle mainBundle] pathForResource:self.colorStr ofType:@"plist"];
        NSArray *plist = [NSArray arrayWithContentsOfFile:path];
        for (NSDictionary *dict in plist) {
            ColorPickMaseterModel *model = [ColorPickMaseterModel colorPickMaseterModelWithDict:dict];
            [array addObject:model];
        }
        _colorArray = array;
    }
    return  _colorArray;
}

- (instancetype)initWithColor:(NSString*)colorStr andTypeModel:(ColorTypeModel*)model{
    self = [super init];
    if (self) {
        self.colorStr = colorStr;
        self.typeModel = model;
        self.title = model.name;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"ColorPickTableViewCell" bundle:nil] forCellReuseIdentifier:@"ColorCell"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//获取label高
- (CGFloat)heightForHeaderWithStr:(NSString*)str{
    CGFloat labelWidth = [UIScreen mainScreen].bounds.size.width;
    NSDictionary *attrs = @{NSFontAttributeName : [UIFont systemFontOfSize:14]};
    
    CGSize maxSize = CGSizeMake(labelWidth, MAXFLOAT);
    CGSize size = [str boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
    return size.height;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UILabel *lab = [[UILabel alloc] init];
    lab.text = self.typeModel.detail;
    lab.textColor = [UIColor darkGrayColor];
    lab.backgroundColor = [UIColor whiteColor];
    lab.font = [UIFont systemFontOfSize:14];
    lab.numberOfLines = 0;
    CGFloat height = [self heightForHeaderWithStr:self.typeModel.detail];
    lab.frame = CGRectMake(10, 10, CGRectGetWidth(self.view.frame)-20, height);
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), height+20)];
    view.backgroundColor = [UIColor whiteColor];
    [view addSubview:lab];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return [self heightForHeaderWithStr:self.typeModel.detail] + 20;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.colorArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ColorPickTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ColorCell" forIndexPath:indexPath];
    cell.delegate = self;
    if (cell == NULL) {
        [tableView registerNib:[UINib nibWithNibName:@"ColorPickTableViewCell" bundle:nil] forCellReuseIdentifier:@"ColorCell"];
        
    }
    ColorPickMaseterModel *masterModel = self.colorArray[indexPath.row];
    ColorPickCellModel *model = [[ColorPickCellModel alloc] init];
    model.typeArray = masterModel.colors;
    model.color = masterModel.color;
    model.colorName = masterModel.colorName;
    model.colorDescription = masterModel.colorDescription;
    
    cell.cellModel = model;
    return cell;
}

//转16进制字符串
- (NSString *)stringWithHexNumber:(NSUInteger)hexNumber{
    char hexChar[6];
    sprintf(hexChar, "%X", (int)hexNumber);
    NSString *hexString = [NSString stringWithCString:hexChar encoding:NSUTF8StringEncoding];
    return hexString;
}

//点击cell中的btn回调
- (void)didSelectedColor:(NSString*)color{
    NSLog(@"color = %@",color);
    
    NSArray *arr = [color componentsSeparatedByString:@","];
    CGFloat r = [arr[0] intValue];
    CGFloat g = [arr[1] intValue];
    CGFloat b = [arr[2] intValue];
    
    NSString *rOX = [self stringWithHexNumber:r];
    NSString *gOX = [self stringWithHexNumber:g];
    NSString *bOX = [self stringWithHexNumber:b];
    NSString *oxStr = [NSString stringWithFormat:@"ox%@%@%@",rOX,gOX,bOX];
    NSString *rgbStr = [NSString stringWithFormat:@"RGB(%@)",color];
    
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
        [[CoreDataOperations sharedInstance] saveColorOX:[NSString stringWithFormat:@"%@%@%@",rOX,gOX,bOX] andRGB:[NSString stringWithFormat:@"%@",color]];
        
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return CGRectGetWidth(self.view.frame)* 0.3;
}

@end
