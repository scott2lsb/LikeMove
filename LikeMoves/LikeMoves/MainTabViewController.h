//
//  MainTabViewController.h
//  LikeMoves
//
//  Created by 粒橙Leo on 14-9-29.
//  Copyright (c) 2014年 Licheng Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainTabViewController : UITabBarController<UITabBarControllerDelegate>
@property (weak, nonatomic,readonly) IBOutlet UITabBar *tabBar;

@end
