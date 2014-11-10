//
//  LMAppDelegate.h
//  LikeMoves
//
//  Created by 粒橙Leo on 14-9-14.
//  Copyright (c) 2014年 Licheng Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EAIntroView.h"
#import <SMS_SDK/SMS_SDK.h>

#import "SMPageControl.h"
#import "UIColor+FlatUI.h"
#import "FBShimmeringView.h"
#import "ACPReminder.h"

@interface LMAppDelegate : UIResponder <UIApplicationDelegate,EAIntroDelegate>{
    UIView *rootView;
    UIImageView *_wallpaperView;
    FBShimmeringView *_shimmeringView;
    UIView *_contentView;
    UILabel *_logoLabel;
    
    UILabel *_valueLabel;
    
    CGFloat _panStartValue;
    BOOL _panVertical;

}

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) NSString *appId;
@property (strong, nonatomic) NSString *channelId;
@property (strong, nonatomic) NSString *userId;


@end
