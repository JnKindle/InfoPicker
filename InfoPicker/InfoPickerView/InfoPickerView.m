//
//  InfoPickerView.m
//  New_Patient
//
//  Created by Jn_Kindle on 2018/5/29.
//  Copyright © 2018年 新开元 iOS. All rights reserved.
//



#import "InfoPickerView.h"


@interface InfoPickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>

//设备列表view
@property (nonatomic, weak) UIView *listView;


@property (nonatomic, weak) UIView *headerView;
@property (nonatomic, weak) UIButton *cancelButton;
@property (nonatomic, weak) UIButton *certainButton;
@property (nonatomic, weak) UILabel *promptLabel;
@property (nonatomic, weak) UIPickerView *pickView;

@property (nonatomic, weak) UILabel *contenLabel;



@end

@implementation InfoPickerView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        //设置背景色
        self.backgroundColor = RGBA_COLOR(255, 255, 255, 0.0);
        
        [self listView];
        
        [self headerView];
        [self cancelButton];
        [self certainButton];
        [self promptLabel];
        [self pickView];
        
        [self contenLabel];
        
        
        
        //添加移除手势
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissInfoPickerView)];
        [self addGestureRecognizer:tapGesture];
        
        
    }
    return self;
}

-(void)setDataSourceArry:(NSArray *)dataSourceArry
{
    _dataSourceArry = dataSourceArry;
    [self.pickView reloadAllComponents];
}

- (void)setCurrentString:(NSString *)currentString
{
    _currentString = currentString;
    
    int i = 0;
    for (int j = 0; j<self.dataSourceArry.count; j++) {
        NSString *contentString = self.dataSourceArry[j];
        if ([contentString isEqualToString:currentString]) {
            i = j;
        }
    }
    //滚动到当前选择项中
    [self.pickView selectRow:i inComponent:0 animated:YES];
}

-(void)setPromptTitle:(NSString *)promptTitle
{
    _promptTitle = promptTitle;
    self.promptLabel.text = promptTitle;
}

-(void)setContent:(NSString *)content
{
    _content = content;
    self.contenLabel.text = content;
}

- (UIView *)listView
{
    if (!_listView) {
        UIView *listView = [[UIView alloc] initWithFrame:CGRectMake(0, JnScreenHeight, JnScreenWidth, 250*JnScreenPercentage)];
        listView.backgroundColor = [UIColor whiteColor];
        [self addSubview:listView];
        _listView = listView;
        
    }
    return _listView;
}

- (UIView *)headerView
{
    if (!_headerView) {
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, JnScreenWidth, 40*JnScreenPercentage)];
        headerView.backgroundColor = RGBA_COLOR(238, 238, 238, 1.0);
        [self.listView addSubview:headerView];
        _headerView = headerView;
    }
    return _headerView;
}

- (UIButton *)cancelButton{
    if (!_cancelButton) {
        UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelButton.frame = CGRectMake(12*JnScreenPercentage, 0, 60*JnScreenPercentage, 40*JnScreenPercentage);
        [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [cancelButton setTitleColor:[GlobalFunction colorWithHexString:@"#4086FF"] forState:UIControlStateNormal];
        [cancelButton addTarget:self action:@selector(cancelButtonClick) forControlEvents:UIControlEventTouchUpInside];
        cancelButton.titleLabel.font = [UIFont systemFontOfSize:18.0*JnScreenPercentage];
        cancelButton.titleLabel.textAlignment = NSTextAlignmentLeft;
        [self.headerView addSubview:cancelButton];
        _cancelButton = cancelButton;
    }
    return _cancelButton;
}

- (UIButton *)certainButton{
    if (!_certainButton) {
        UIButton *certainButton = [UIButton buttonWithType:UIButtonTypeCustom];
        certainButton.frame = CGRectMake(JnScreenWidth-(12+60)*JnScreenPercentage, 0, 60*JnScreenPercentage, 40*JnScreenPercentage);
        [certainButton setTitle:@"确定" forState:UIControlStateNormal];
        [certainButton setTitleColor:[GlobalFunction colorWithHexString:@"#4086FF"] forState:UIControlStateNormal];
        
        [certainButton addTarget:self action:@selector(certainButtonClick) forControlEvents:UIControlEventTouchUpInside];
        
        certainButton.titleLabel.font = [UIFont systemFontOfSize:18.0*JnScreenPercentage];
        certainButton.titleLabel.textAlignment = NSTextAlignmentRight;
        [self.headerView addSubview:certainButton];
        _certainButton = certainButton;
    }
    return _certainButton;
}


-(UILabel *)promptLabel
{
    if (!_promptLabel) {
        UILabel *promptLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 53*JnScreenPercentage, JnScreenWidth, 20.0*JnScreenPercentage)];
        promptLabel.text = @"请选择";
        promptLabel.font = [UIFont systemFontOfSize:15.0*JnScreenPercentage];
        promptLabel.textColor = RGBA_COLOR(170, 170, 170, 1.0);
        promptLabel.textAlignment = NSTextAlignmentCenter;
        [self.listView addSubview:promptLabel];
        _promptLabel = promptLabel;
    }
    return _promptLabel;
}

- (UIPickerView *)pickView{
    if (!_pickView) {
        UIPickerView *pickView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 80*JnScreenPercentage, JnScreenWidth, (250-90)*JnScreenPercentage)];
        pickView.backgroundColor = [UIColor whiteColor];
        pickView.showsSelectionIndicator = NO;
        pickView.delegate = self;
        pickView.dataSource = self;
        [self.listView addSubview:pickView];
        _pickView = pickView;
    }
    return _pickView;
}

-(UILabel *)contenLabel
{
    if (!_contenLabel) {
        UILabel *contenLabel = [[UILabel alloc]initWithFrame:CGRectMake(JnScreenWidth- 80*JnScreenPercentage, ((250-90)-20)/2*JnScreenPercentage, 60*JnScreenPercentage, 20.0*JnScreenPercentage)];
        contenLabel.text = @"";
        contenLabel.font = [UIFont systemFontOfSize:18.0*JnScreenPercentage];
        contenLabel.textColor = [UIColor blackColor];
        contenLabel.textAlignment = NSTextAlignmentRight;
        [self.pickView addSubview:contenLabel];
        _contenLabel = contenLabel;
    }
    return _contenLabel;
}

#pragma mark - pickViewDelegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.dataSourceArry.count;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    return JnScreenWidth;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 34*JnScreenPercentage;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    // 这里用label来展示要显示的文字, 然后可以用label的textAlignment来设置文字的对齐模式
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, JnScreenWidth, 34*JnScreenPercentage)];
    titleLabel.font = [UIFont systemFontOfSize:23.0*JnScreenPercentage];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    
    titleLabel.text = self.dataSourceArry[row];
    
    
    return titleLabel;
    
}


#pragma mark - Action
/**
 显示pickView
 */
- (void)showInfoPickerView
{
    UIWindow *rootWindow = [UIApplication sharedApplication].keyWindow;
    [rootWindow addSubview:self];
    
    CGRect tempRect = self.listView.frame;
    tempRect.origin.y = JnScreenHeight-250*JnScreenPercentage;
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundColor = RGBA_COLOR(0, 0, 0, 0.5);
        self.listView.frame = tempRect;
    }];
    
}

/**
 隐藏pickView
 */
- (void)dismissInfoPickerView
{
    
    CGRect tempRect = self.listView.frame;
    tempRect.origin.y = JnScreenHeight;
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundColor = RGBA_COLOR(255, 255, 255, 0.0);
        self.listView.frame = tempRect;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


/**
 确认按钮点击事件
 */
- (void)certainButtonClick
{
    //获取当前数据
    NSInteger row = [self.pickView selectedRowInComponent:0];
    //NSString *number = self.dataSourceArry[row];
    //handle
    if (self.dataSourceArry.count != 0) {
        if (_certainClick) {
            _certainClick(row);
        }
    }
    
    [self dismissInfoPickerView];
}


/**
 取消按钮点击事件
 */
- (void)cancelButtonClick
{
    [self dismissInfoPickerView];
}







@end
