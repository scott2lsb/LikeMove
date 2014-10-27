//
//  LMAppDelegate.m
//  LikeMoves
//
//  Created by 粒橙Leo on 14-9-14.
//  Copyright (c) 2014年 Licheng Yang. All rights reserved.
//

#import "LMAppDelegate.h"
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialQQHandler.h"
#import "UMessage.h"
#define UMSYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v) ([[[UIDevice currentDevice]systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define _IPHONE80_ 80000
@implementation LMAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    /**
     *  友盟远程推送集成
     */
    //set AppKey and LaunchOptions
    [UMessage startWithAppkey:@"5440d3aafd98c5a72a00567b" launchOptions:launchOptions];
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED < _IPHONE80_
    //register remoteNotification types
    [UMessage registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge
     |UIRemoteNotificationTypeSound
     |UIRemoteNotificationTypeAlert];
#else
    //register remoteNotification types
    UIMutableUserNotificationAction *action1 = [[UIMutableUserNotificationAction alloc] init];
    action1.identifier = @"action1_identifier";
    action1.title=@"Accept";
    action1.activationMode = UIUserNotificationActivationModeForeground;//当点击的时候启动程序
    
    UIMutableUserNotificationAction *action2 = [[UIMutableUserNotificationAction alloc] init];  //第二按钮
    action2.identifier = @"action2";
    action2.title=@"Reject";
    action2.activationMode = UIUserNotificationActivationModeBackground;//当点击的时候不启动程序，在后台处理
    action2.authenticationRequired = YES;//需要解锁才能处理，如果action.activationMode = UIUserNotificationActivationModeForeground;则这个属性被忽略；
    action2.destructive = YES;
    
    UIMutableUserNotificationCategory *categorys = [[UIMutableUserNotificationCategory alloc] init];
    categorys.identifier = @"alert";//这组动作的唯一标示
    [categorys setActions:@[action1,action2] forContext:(UIUserNotificationActionContextMinimal)];
    
    UIUserNotificationSettings *userSettings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge|UIUserNotificationTypeSound|UIUserNotificationTypeAlert
                                                                                 categories:[NSSet setWithObject:categorys]];
    [UMessage registerRemoteNotificationAndUserNotificationSettings:userSettings];
#endif
    
    //for log
    [UMessage setLogEnabled:YES];

    
    
    
    
    //友盟注册AppKey
    [UMSocialData setAppKey:um_appkey];
    //设置微信AppId，设置分享url，默认使用友盟的网址
    [UMSocialWechatHandler setWXAppId:@"wxb63a8a59702e5ddb" appSecret:@"abe6cc00ca7a6fab78009545da6cd449" url:@"http://www.kaidechuanmei.com"];
    //    //设置分享到QQ和QQ空间的应用Id，和分享url 链接
    [UMSocialQQHandler setQQWithAppId:@"1103374241" appKey:@"ODe0qJKSqfWItJph" url:@"http://www.kaidechuanmei.com"];

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
    page1.bgImage = [UIImage imageNamed:@"launch"];
    
    
    
    

    EAIntroPage *page2 = [EAIntroPage page];
    page2.title = @"为能量充值";
    page2.titlePositionY=    [[UIScreen mainScreen] bounds].size.height-50;
    page2.titleFont=[UIFont systemFontOfSize:30.0f];
    page2.titleColor=[UIColor orangeColor];
    page2.bgImage = [UIImage imageNamed:@"first"];
    

    EAIntroPage *page3 = [EAIntroPage page];
    page3.title = @"给自己奖励";
    page3.titleFont=[UIFont systemFontOfSize:30.0f];
    page3.titlePositionY=[[UIScreen mainScreen] bounds].size.height-50;
    page3.titleColor=[UIColor orangeColor];
    page3.bgImage = [UIImage imageNamed:@"sec"];
    
    
    EAIntroPage *page4 = [EAIntroPage page];
    page4.title = @"传递动能量";
    page4.titlePositionY=[[UIScreen mainScreen] bounds].size.height-50;
    page4.titleFont=[UIFont systemFontOfSize:30.0f];
    page4.titleColor=[UIColor orangeColor];
    page4.bgImage = [UIImage imageNamed:@"share"];
    
    
    EAIntroView *intro = [[EAIntroView alloc] initWithFrame:rootView.bounds andPages:@[page1,page2,page3,page4]];
    [intro setDelegate:self];
    SMPageControl *pageControl = [[SMPageControl alloc] init];
    pageControl.pageIndicatorImage = [UIImage imageNamed:@"pageDot"];
    pageControl.currentPageIndicatorImage = [UIImage imageNamed:@"selectedPageDot"];
    [pageControl sizeToFit];
    intro.pageControl = (UIPageControl *)pageControl;
//    intro.pageControlY = 100.0f;
    [intro showInView:rootView animateDuration:0.3];
    [[NSUserDefaults standardUserDefaults] setObject:@"123" forKey:mUseTime];
    return introPage;
}
#pragma mark intro-delegate
- (void)introDidFinish:(EAIntroView *)introView {
    DLog(@"introDidFinish callback");
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *tabVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"LoginPage"];
    [self.window.rootViewController presentViewController:tabVC animated:YES completion:^(void){}];
    
}


#pragma mark - UMPush
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    [UMessage registerDeviceToken:deviceToken];
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    [UMessage didReceiveRemoteNotification:userInfo];
}
#pragma mark - UMShare
-(BOOL)application:(UIApplication*)application handleOpenURL:(NSURL*)url
{
    return[UMSocialSnsService handleOpenURL:url];
}
-(BOOL)application:(UIApplication*)application openURL:(NSURL*)url sourceApplication:(NSString*)sourceApplication annotation:(id)annotation
{
    return[UMSocialSnsService handleOpenURL:url];
}
#pragma mark - ApplicationDelegate
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    ACPReminder * localNotifications = [ACPReminder sharedManager];
    
    //Settings
    localNotifications.messages = @[@"改变从运动开始",@"每天为能量充值",@"每天给自己一个奖励"];
    localNotifications.timePeriods = @[@(1)]; //days
    localNotifications.appDomain = @"com.mydomain.appName";
    localNotifications.randomMessage = NO; //By default is NO (optional)
    localNotifications.testFlagInSeconds = NO; //By default is NO (optional) --> For testing purpose only!
    localNotifications.circularTimePeriod = YES; // By default is NO (optional)
    
    [localNotifications createLocalNotification];

}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    [[ACPReminder sharedManager] checkIfLocalNotificationHasBeenTriggered];

}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
