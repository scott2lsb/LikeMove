//
//  MainTabViewController.m
//  LikeMoves
//
//  Created by 粒橙Leo on 14-9-29.
//  Copyright (c) 2014年 Licheng Yang. All rights reserved.
//

#import "MainTabViewController.h"

@interface MainTabViewController ()

@end

@implementation MainTabViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tabBar.opaque=NO;
    self.tabBar.selectedImageTintColor=[UIColor orangeColor];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - TabBarControllerDelegate
/*
 添加TabBar中transition跳转效果为波纹
 */
-(void)tabBar:(UITabBar*)atabBar didSelectItem:(UITabBarItem*)item
{
    CATransition* animation = [CATransition animation];
    [animation setDuration:0.5f];
    [animation setType:@"rippleEffect"];//波纹效果 @“rippleEffect”kCATransitionFade
    
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [[self.view layer]addAnimation:animation forKey:@"switchView"];
}

@end
