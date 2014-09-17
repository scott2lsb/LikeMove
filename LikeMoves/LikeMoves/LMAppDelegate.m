//
//  LMAppDelegate.m
//  LikeMoves
//
//  Created by 粒橙Leo on 14-9-14.
//  Copyright (c) 2014年 Licheng Yang. All rights reserved.
//

#import "LMAppDelegate.h"
#import <SMS_SDK/SMS_SDK.h>
#import "OnboardingViewController.h"
#import "OnboardingContentViewController.h"

@implementation LMAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //短信验证key注册
    [SMS_SDK	registerApp:sms_appKey withSecret:sms_appSecret];
    
    //启动页面
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    // obviously, only do one of these at a time
    self.window.rootViewController = [self generateFirstDemoVC];
    //    self.window.rootViewController = [self generateSecondDemoVC];
    //    self.window.rootViewController = [self generateThirdDemoVC];
    //    self.window.rootViewController = [self generateFourthDemoVC];
    
    application.statusBarStyle = UIStatusBarStyleLightContent;
    
    [self.window makeKeyAndVisible];
    
    return YES;
}
- (OnboardingViewController *)generateFirstDemoVC {
    
    OnboardingContentViewController *firstPage = [[OnboardingContentViewController alloc] initWithTitle:@"It's one small step for a man..." body:@"The first man on the moon, Buzz Aldrin, only had one photo taken of him while on the lunar surface due to an unexpected call from Dick Nixon." image:[UIImage imageNamed:@"space1"] buttonText:nil action:nil];
    firstPage.bodyFontSize = 25;
    
    OnboardingContentViewController *secondPage = [[OnboardingContentViewController alloc] initWithTitle:@"The Drake Equation" body:@"In 1961, Frank Drake proposed a probabilistic formula to help estimate the number of potential active and radio-capable extraterrestrial civilizations in the Milky Way Galaxy." image:[UIImage imageNamed:@"space2"] buttonText:nil action:nil];
    secondPage.bodyFontSize = 24;
    
    OnboardingContentViewController *thirdPage = [[OnboardingContentViewController alloc] initWithTitle:@"Cold Welding" body:@"Two pieces of metal without any coating on them will form into one piece in the vacuum of space." image:[UIImage imageNamed:@"space3"] buttonText:nil action:nil];
    
    OnboardingContentViewController *fourthPage = [[OnboardingContentViewController alloc] initWithTitle:@"Goodnight Moon" body:@"Every year the moon moves about 3.8cm further away from the Earth." image:[UIImage imageNamed:@"space4"] buttonText:@"See Ya Later!" action:^{
        
        UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *tabVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"LoginPage"];
        [self.window.rootViewController setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
        [self.window.rootViewController presentViewController:tabVC animated:YES completion:^(void){
        }];
    }];
    
    OnboardingViewController *onboardingVC = [[OnboardingViewController alloc] initWithBackgroundImage:[UIImage imageNamed:@"milky_way.jpg"] contents:@[firstPage, secondPage, thirdPage, fourthPage]];
    onboardingVC.shouldMaskBackground = NO;
    onboardingVC.shouldBlurBackground = YES;
    return onboardingVC;
}

-(void)toLoginPage{
    

    
}
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
