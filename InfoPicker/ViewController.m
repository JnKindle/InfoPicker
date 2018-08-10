//
//  ViewController.m
//  InfoPicker
//
//  Created by Jn_Kindle on 2018/8/10.
//  Copyright © 2018年 JnKindle. All rights reserved.
//

#import "ViewController.h"

#import "InfoPickerView.h"

@interface ViewController ()

@property (nonatomic, strong) InfoPickerView *pickView;

@end

@implementation ViewController

- (InfoPickerView *)pickView
{
    if (!_pickView) {
        NSArray *data = @[@"10",@"11",@"12",@"13",@"14",@"15"];
        
        _pickView = [[InfoPickerView alloc] initWithFrame:CGRectMake(0, 0, JnScreenWidth, JnScreenHeight)];
        _pickView.promptTitle = @"请选择";
        _pickView.dataSourceArry = data; //传值信息数组
        _pickView.currentString = data[3]; //设置当前显示行
        _pickView.content = @"cm";
        _pickView.certainClick = ^(NSInteger tag) {
            NSLog(@"点击了第%ld个,数据内容：%@",(long)tag,data[tag]);
        };
    }
    return _pickView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *tempBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    tempBtn.backgroundColor = [UIColor orangeColor];
    tempBtn.frame = CGRectMake((JnScreenWidth-100)/2, 100, 100, 50);
    [tempBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:tempBtn];
    
}

- (void)click:(UIButton *)senderr
{
    //显示
    [self.pickView showInfoPickerView];
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
