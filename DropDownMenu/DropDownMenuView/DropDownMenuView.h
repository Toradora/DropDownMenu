//
//  DropDownMenuView.h
//  DropDownMenu
//
//  Created by  Toradora on 15/9/15.
//  Copyright (c) 2015年  Toradora. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DropDownMenuView;

@protocol DropDownMenuViewDelegate <NSObject>

@optional
- (void)menuStateDidChangeInMenuView:(DropDownMenuView *)meunView;
- (void)headerViewDidClickInMenuView:(DropDownMenuView *)meunView;
- (void)menuView:(DropDownMenuView *)meunView didSelectItemAtIndex:(NSUInteger)index;

@end

@interface DropDownMenuView : UIView<UITableViewDelegate,UITableViewDataSource>

// view
@property (nonatomic, retain)   UIImageView *headerImageView;  //标题栏图片视图
@property (nonatomic, retain)   UILabel     *headerLabel;      //default text is "无"
@property (nonatomic, readonly) NSString    *selectedMenuItem; //output

// color
@property (nonatomic, retain) UIColor *headerBackGroundColor;   //标题栏背景颜色
@property (nonatomic, retain) UIColor *menuItembackGroundColor; //菜单栏背景颜色
@property (nonatomic, retain) UIColor *menuItemSelectedColor;   //菜单栏选中后的颜色

// size
@property (nonatomic, assign) CGFloat itemHeight;   //菜单栏宽度
@property (nonatomic, assign) CGSize  contentSize;  //下拉菜单大小

// item
@property (nonatomic, retain) UIFont           *itemTextFont;       //菜单栏字体
@property (nonatomic, retain) UIColor          *itemTextColor;      //菜单栏文字颜色
@property (nonatomic)         NSTextAlignment  itemTextAlignment;   //菜单栏文字对齐方式

@property (nonatomic, assign) id<DropDownMenuViewDelegate> delegate;
@property (nonatomic, assign, readonly) BOOL isOpen;    //菜单栏是否展开

+ (DropDownMenuView *)menuWithArray:(NSArray *)menuArray andFrame:(CGRect)frame;
- (instancetype)initWithArray:(NSArray *)menuArray andFrame:(CGRect)frame;
/**
 * 收起/展开菜单栏
 */
- (void)changeMenuState;

@end
