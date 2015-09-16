//
//  DropDownMenuView.m
//  DropDownMenu
//
//  Created by  Toradora on 15/9/15.
//  Copyright (c) 2015年  Toradora. All rights reserved.
//

#import "DropDownMenuView.h"

#define defaultTitleText    @"无"
#define ImageViewLength     20
#define LabelOffsetX        15
#define defaultItemHeight   30
#define defaultHeaderBackGroundColor        [UIColor grayColor]
#define defaultMenuItembackGroundColor      [UIColor clearColor]
#define defaultMenuItemSelectedColor        [UIColor orangeColor]

@implementation DropDownMenuView
{
    UITableView *_tableView;
    NSArray *_menuArray;
    UIControl *_headerView;
    NSIndexPath *_currentSelectedIndex;
}

+ (DropDownMenuView *)menuWithArray:(NSArray *)menuArray andFrame:(CGRect)frame
{
    return [[DropDownMenuView alloc] initWithArray:menuArray andFrame:frame];
}

- (instancetype)initWithArray:(NSArray *)menuArray andFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        _menuArray = menuArray;
        
        [self initViews];
    }
    
    return self;
}

- (void)initViews
{
    _isOpen = NO;
    _itemHeight = defaultItemHeight;
    _headerBackGroundColor = defaultHeaderBackGroundColor;
    _menuItembackGroundColor = defaultMenuItembackGroundColor;
    _menuItemSelectedColor = defaultMenuItemSelectedColor;

    self.clipsToBounds = YES;
    self.backgroundColor = [UIColor clearColor];
    
    _headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(LabelOffsetX, 0, self.frame.size.width, self.frame.size.height)];
    _headerLabel.text = defaultTitleText;
    
    _headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width - ImageViewLength - 10, (self.frame.size.height - ImageViewLength)/2, ImageViewLength, ImageViewLength)];
    _headerImageView.image = [UIImage imageNamed:@"down@2x"];
    
    _headerView = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    _headerView.backgroundColor = _headerBackGroundColor;
    
    [_headerView addSubview:_headerLabel];
    [_headerView addSubview:_headerImageView];
    
    [_headerView addTarget:self action:@selector(clickAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:_headerView];

    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.frame.size.height, self.frame.size.width, _menuArray.count*_itemHeight) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [[UIView alloc] init];
    
    [self addSubview:_tableView];
}

- (NSString *)selectedMenuItem
{
    return _headerLabel.text;
}

#pragma mark - setter
- (void)setContentSize:(CGSize)contentSize
{
    _contentSize = contentSize;
    
    _tableView.frame = CGRectMake(_tableView.frame.origin.x, _tableView.frame.origin.y, _contentSize.width, _contentSize.height);

    if (_contentSize.height < _menuArray.count * _itemHeight) {
        _tableView.contentSize = CGSizeMake(_contentSize.width, _menuArray.count * _itemHeight);
    }
}

- (void)setItemHeight:(CGFloat)itemHeight
{
    _itemHeight = itemHeight;
    
    if (_contentSize.height != 0 && _contentSize.height < _menuArray.count * _itemHeight) {
        _tableView.contentSize = CGSizeMake(_contentSize.width, _menuArray.count * _itemHeight);
    }
    
}

- (void)setHeaderBackGroundColor:(UIColor *)headerBackGroundColor
{
    _headerBackGroundColor = headerBackGroundColor;
    _headerView.backgroundColor = _headerBackGroundColor;
}
#pragma mark -

- (void)changeMenuState
{
    _isOpen = !_isOpen;
    
    _headerImageView.transform = CGAffineTransformRotate(_headerImageView.transform, M_PI);
    
    CGFloat width = _isOpen ?  (_tableView.frame.size.width > _headerView.frame.size.width ? _tableView.frame.size.width:_headerView.frame.size.width) : _headerView.frame.size.width;
    CGFloat height = _isOpen ? _headerView.frame.size.height + _menuArray.count*_itemHeight: _headerView.frame.size.height;
    
    if (_isOpen) {
        [_tableView reloadData];
    }

    [UIView animateWithDuration:_isOpen?.3:.0 animations:^{
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, width, height);
    }];
    
    if ([self.delegate respondsToSelector:@selector(menuStateDidChangeInMenuView:)]) {
        [self.delegate menuStateDidChangeInMenuView:self];
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _menuArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.textLabel.font = _itemTextFont;
        cell.textLabel.textColor = _itemTextColor;
        cell.textLabel.textAlignment = _itemTextAlignment;
    }
    
    cell.textLabel.text = _menuArray[indexPath.row];
    
    if (indexPath == _currentSelectedIndex) {
        cell.backgroundColor = _menuItemSelectedColor;
    }else {
        cell.backgroundColor = _menuItembackGroundColor;
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _isOpen ? _itemHeight : 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _headerLabel.text = _menuArray[indexPath.row];
    _currentSelectedIndex = indexPath;

    [self changeMenuState];
    
    if ([self.delegate respondsToSelector:@selector(menuView:didSelectItemAtIndex:)]) {
        [self.delegate menuView:self didSelectItemAtIndex:indexPath.row];
    }
}
#pragma mark -

- (void)clickAction
{
    [self changeMenuState];
    if ([self.delegate respondsToSelector:@selector(headerViewDidClickInMenuView:)]) {
        [self.delegate headerViewDidClickInMenuView:self];
    }
}

@end
