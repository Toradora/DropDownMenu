//
//  ViewController.m
//  DropDownMenu
//
//  Created by  Toradora on 15/9/15.
//  Copyright (c) 2015年  Toradora. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
{
    NSArray *_arr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    DropDownMenuView *menuView1 = [DropDownMenuView menuWithArray:@[@"周",@"月",@"季度",@"年度"] andFrame:CGRectMake(0, 100, 180, 40)];
    menuView1.delegate = self;
    menuView1.headerLabel.text = @"nano";
    DropDownMenuView *menuView2 = [DropDownMenuView menuWithArray:@[@"周",@"月",@"季度",@"年度"] andFrame:CGRectMake(180, 100, 180, 40)];
    menuView2.delegate = self;
    DropDownMenuView *menuView3 = [DropDownMenuView menuWithArray:@[@"周",@"月",@"季度",@"年度"] andFrame:CGRectMake(0, 140, 180, 40)];
    menuView3.delegate = self;
    
    _arr = @[menuView1,menuView2,menuView3];

    [self.view addSubview:menuView3];
    [self.view addSubview:menuView2];
    [self.view addSubview:menuView1];
    
}

- (void)headerViewDidClickInMenuView:(DropDownMenuView *)meunView
{
    for (DropDownMenuView *view in _arr) {
        if (view != meunView && view.isOpen) {
            [view changeMenuState];
        }
    }
}

- (void)menuStateDidChangeInMenuView:(DropDownMenuView *)meunView
{
    NSLog(@"%@",meunView.selectedMenuItem);
}

- (void)menuView:(DropDownMenuView *)meunView didSelectItemAtIndex:(NSUInteger)index
{
    NSLog(@"%@",meunView.selectedMenuItem);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
