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
#import "UMSocialSinaHandler.h"
#import "BPush.h"
#define UMSYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v) ([[[UIDevice currentDevice]systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define _IPHONE80_ 80000
#define SUPPORT_IOS8 0
@implementation LMAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    /**
     *  百度云推送
     */
    [BPush setupChannel:launchOptions]; // 必须
    
    [BPush setDelegate:self]; // 必须。参数对象必须实现onMethod: response:方法，本示例中为self
    
    // [BPush setAccessToken:@"3.ad0c16fa2c6aa378f450f54adb08039.2592000.1367133742.282335-602025"];  // 可选。api key绑定时不需要，也可在其它时机调用
    
#if SUPPORT_IOS8
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        UIUserNotificationType myTypes = UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:myTypes categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    }else
#endif
    {
        UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound;
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:myTypes];
    }
    
    
    //友盟注册AppKey
    [UMSocialData setAppKey:um_appkey];
    //设置微信AppId，设置分享url，默认使用友盟的网址
    [UMSocialWechatHandler setWXAppId:@"wxb63a8a59702e5ddb" appSecret:@"abe6cc00ca7a6fab78009545da6cd449" url:nil];
    //    //设置分享到QQ和QQ空间的应用Id，和分享url 链接
    [UMSocialQQHandler setQQWithAppId:@"1103374241" appKey:@"ODe0qJKSqfWItJph" url:@"http://www.kaidechuanmei.com"];
    [UMSocialSinaHandler openSSOWithRedirectURL:nil];
    
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


#pragma mark - BDPush
#if SUPPORT_IOS8
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    //register to receive notifications
    [application registerForRemoteNotifications];
}
#endif
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    
    [BPush registerDeviceToken:deviceToken]; // 必须
    
    [BPush bindChannel]; // 必须。可以在其它时机调用，只有在该方法返回（通过onMethod:response:回调）绑定成功时，app才能接收到Push消息。一个app绑定成功至少一次即可（如果access token变更请重新绑定）。
}
- (void) onMethod:(NSString*)method response:(NSDictionary*)data
{
    if ([BPushRequestMethod_Bind isEqualToString:method])
    {
        NSDictionary* res = [[NSDictionary alloc] initWithDictionary:data];
        DLog(@"BDPush-%@",res);
    }
}
- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    [BPush handleNotification:userInfo]; // 可选
    NSString* msg=[[userInfo objectForKey:@"aps"] objectForKey:@"alert"];
    UIAlertView* alert=[[UIAlertView alloc] initWithTitle:msg message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alert show];
    
}
//- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
//{
//    [UMessage registerDeviceToken:deviceToken];
//}
//- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
//{
//    [UMessage didReceiveRemoteNotification:userInfo];
//}

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
#pragma mark - UMShare
-(BOOL)application:(UIApplication*)application openURL:(NSURL*)url sourceApplication:(NSString*)sourceApplication annotation:(id)annotation
{
    if ([sourceApplication hasPrefix:@"com.alipay"]){
        [self parse:url application:application];
        return YES;
    }
    return[UMSocialSnsService handleOpenURL:url];
}
#pragma mark - Alipay-result
-(BOOL)application:(UIApplication*)application handleOpenURL:(NSURL*)url
{
    if([[url host] isEqualToString:@"safepay"]){
        [self parse:url application:application];
        return YES;
    }
    return[UMSocialSnsService handleOpenURL:url];
}



- (void)parse:(NSURL *)url application:(UIApplication *)application {
    
    //结果处理
    AlixPayResult* result = [self handleOpenURL:url];
    
	if (result)
    {
		
		if (result.statusCode == 9000)
        {
			/*
			 *用公钥验证签名 严格验证请使用result.resultString与result.signString验签
			 */
            
            //交易成功
            NSString* key = AlipayPubKey;
            id<DataVerifier> verifier;
            verifier = CreateRSADataVerifier(key);
            
            if ([verifier verifyString:result.resultString withSign:result.signString])
            {
                //验证签名成功，交易结果无篡改
                //交易成功
                DLog(@"客户端交易成功");
                
            }
            
        }
        else
        {
            //交易失败
        }
    }
    else
    {
        //失败
    }
    
}
- (AlixPayResult *)handleOpenURL:(NSURL *)url {
	AlixPayResult * result = nil;
	
	if (url != nil && [[url host] compare:@"safepay"] == 0) {
		result = [self resultFromURL:url];
	}
    
	return result;
}
- (AlixPayResult *)resultFromURL:(NSURL *)url {
	NSString * query = [[url query] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	return [[AlixPayResult alloc] initWithString:query];
}



@end
