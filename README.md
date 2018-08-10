# InfoPicker

快速集成

#import "InfoPickerView.h"

实现下面代码：

@property (nonatomic, strong) InfoPickerView *pickView;

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

最后显示
[self.pickView showInfoPickerView];

方便简洁
