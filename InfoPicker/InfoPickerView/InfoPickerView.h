//
//  InfoPickerView.h
//  New_Patient
//
//  Created by Jn_Kindle on 2018/5/29.
//  Copyright © 2018年 新开元 iOS. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^CertainClick)(NSInteger tag);

@interface InfoPickerView : UIView

/**
 数据源数组
 */
@property (nonatomic, strong) NSArray *dataSourceArry;


/**
 pickview提示语
 */
@property (nonatomic, copy) NSString *promptTitle;


/**
 内容
 */
@property (nonatomic, copy) NSString *content;

/**
 当前显示的内容，用于匹配位置
 */
@property (nonatomic, strong) NSString *currentString;

/**
 确认方法回调
 */
@property (nonatomic, copy) CertainClick certainClick;

/**
 显示pickView
 */
- (void)showInfoPickerView;

/**
 隐藏pickView
 */
- (void)dismissInfoPickerView;

@end
