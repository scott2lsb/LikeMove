//
//  LMAppDelegate.m
//  LikeMoves
//
//  Created by 粒橙Leo on 14-9-14.
//  Copyright (c) 2014年 Licheng Yang. All rights reserved.
//

#import "LMAppDelegate.h"
#import "UMSocial.h"
@implementation LMAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //友盟注册AppKey
    [UMSocialData setAppKey:um_appkey];
    //短信验证key注册
    [SMS_SDK	registerApp:sms_appKey withSecret:sms_appSecret];
    
    //启动页面
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];

    if(   [[NSUserDefaults standardUserDefaults] objectForKey:mUseTime]){
        self.window.rootViewController=[self showLaunchImage];
        [self performSelector:@selector(presentLoginPage) withObject:nil afterDelay:2.5];
    }else{
            self.window.rootViewController=[self showIntroWithCrossDissolve];
    }

    application.statusBarStyle = UIStatusBarStyleLightContent;
    
    [self.window makeKeyAndVisible];
    
    return YES;
}
/**
 *  跳转登陆界面
 */
-(void)presentLoginPage{
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *tabVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"LoginPage"];
    [self.window.rootViewController presentViewController:tabVC animated:YES completion:^(void){}];

}
/**
 *  返回登陆页面
 *
 *  @return 登陆页面
 */
-(UIViewController*)showLaunchImage{
        UIViewController* introPage=[[UIViewController alloc]init];
    UIImageView* imgView=[[UIImageView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [imgView setImage:[UIImage imageNamed:@"launchP-568h@2x.png"]];
    [introPage.view addSubview:imgView];

    /**
     *  自定义闪烁效果字
     */
    
    UIView *viewForPage = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    FBShimmeringView *shimmeringView = [[FBShimmeringView alloc] initWithFrame:CGRectMake(0, 200, introPage.view.bounds.size.width, 44)];
    shimmeringView.shimmeringBeginFadeDuration=0.3;
    shimmeringView.shimmeringOpacity=0.0;
    shimmeringView.shimmeringSpeed=130.0;
    [viewForPage addSubview:shimmeringView];
    
    UILabel *loadingLabel = [[UILabel alloc] initWithFrame:shimmeringView.bounds];
    loadingLabel.textAlignment = NSTextAlignmentCenter;
    loadingLabel.text = NSLocalizedString(@"Change begins with movement", nil);
    loadingLabel.textColor=[UIColor whiteColor];
    loadingLabel.backgroundColor=[UIColor clearColor];
    loadingLabel.font=[UIFont systemFontOfSize:20.0];
    shimmeringView.contentView = loadingLabel;
    // Start shimmering.
    shimmeringView.shimmering = YES;
    
    UILabel *labelForPage = [[UILabel alloc] initWithFrame:CGRectMake(0, 150, introPage.view.bounds.size.width, 50)];
    labelForPage.text = @"改变从运动开始";
    labelForPage.textAlignment = NSTextAlignmentCenter;
    labelForPage.font = [UIFont systemFontOfSize:40];
    labelForPage.textColor = [UIColor whiteColor];
    labelForPage.backgroundColor = [UIColor clearColor];
    
    [viewForPage addSubview:labelForPage];
    [introPage.view addSubview:viewForPage];
//    EAIntroPage *page1 = [EAIntroPage pageWithCustomView:viewForPage];
//    page1.bgImage = [UIImage imageNamed:@"launchP-568h@2x.png"];
    
    
    
    return introPage;
}
- (UIViewController*)showIntroWithCrossDissolve {
    UIViewController* introPage=[[UIViewController alloc]init];
    rootView=introPage.view;
    /**
     *  自定义闪烁效果字
     */
    
    UIView *viewForPage = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    FBShimmeringView *shimmeringView = [[FBShimmeringView alloc] initWithFrame:CGRectMake(0, 200, rootView.bounds.size.width, 44)];
    shimmeringView.shimmeringBeginFadeDuration=0.3;
    shimmeringView.shimmeringOpacity=0.0;
    shimmeringView.shimmeringSpeed=130.0;
    [viewForPage addSubview:shimmeringView];
    
    UILabel *loadingLabel = [[UILabel alloc] initWithFrame:shimmeringView.bounds];
    loadingLabel.textAlignment = NSTextAlignmentCenter;
    loadingLabel.text = NSLocalizedString(@"Change begins with movement", nil);
    loadingLabel.textColor=[UIColor whiteColor];
    loadingLabel.backgroundColor=[UIColor clearColor];
    loadingLabel.font=[UIFont systemFontOfSize:20.0];
    shimmeringView.contentView = loadingLabel;
    // Start shimmering.
    shimmeringView.shimmering = YES;
    
    UILabel *labelForPage = [[UILabel alloc] initWithFrame:CGRectMake(0, 150, rootView.bounds.size.width, 50)];
    labelForPage.text = @"改变从运动开始";
    labelForPage.textAlignment = NSTextAlignmentCenter;
    labelForPage.font = [UIFont systemFontOfSize:40];
    labelForPage.textColor = [UIColor whiteColor];
    labelForPage.backgroundColor = [UIColor clearColor];
    
    [viewForPage addSubview:labelForPage];
    EAIntroPage *page1 = [EAIntroPage pageWithCustomView:viewForPage];
    page1.bgImage = [UIImage imageNamed:@"launchP-568h@2x.png"];
    
    
    
    
    
    EAIntroPage *page2 = [EAIntroPage page];
    page2.title = @"为能量充值";
    page2.titlePositionY=500;
    page2.titleFont=[UIFont systemFontOfSize:30.0f];
    page2.titleColor=[UIColor orangeColor];
    page2.bgImage = [UIImage imageNamed:@"firstP-568h"];
    
    
    EAIntroPage *page3 = [EAIntroPage page];
    page3.title = @"给自己奖励";
    page3.titleFont=[UIFont systemFontOfSize:30.0f];
    page3.titlePositionY=500;
    page3.titleColor=[UIColor orangeColor];
    page3.bgImage = [UIImage imageNamed:@"secondP-568h"];
    
    
    EAIntroPage *page4 = [EAIntroPage page];
    page4.title = @"传递动能量";
    page4.titlePositionY=500;
    page4.titleFont=[UIFont systemFontOfSize:30.0f];
    page4.titleColor=[UIColor orangeColor];
    page4.bgImage = [UIImage imageNamed:@"shareP-568h"];
    
    
    EAIntroView *intro = [[EAIntroView alloc] initWithFrame:rootView.bounds andPages:@[page1,page2,page3,page4]];
    [intro setDelegate:self];
    SMPageControl *pageControl = [[SMPageControl alloc] init];
    pageControl.pageIndicatorImage = [UIImage imageNamed:@"pageDot"];
    pageControl.currentPageIndicatorImage = [UIImage imageNamed:@"selectedPageDot"];
    [pageControl sizeToFit];
    intro.pageControl = (UIPageControl *)pageControl;
    intro.pageControlY = 110.0f;
    [intro showInView:rootView animateDuration:0.3];
    [[NSUserDefaults standardUserDefaults] setObject:@"123" forKey:mUseTime];
    return introPage;
}
#pragma mark intro-delegate
- (void)introDidFinish:(EAIntroView *)introView {
    NSLog(@"introDidFinish callback");
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *tabVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"LoginPage"];
    [self.window.rootViewController presentViewController:tabVC animated:YES completion:^(void){}];
    
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
