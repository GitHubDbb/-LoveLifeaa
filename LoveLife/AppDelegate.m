//
//  AppDelegate.m
//  LoveLife
//
//  Created by qianfeng on 15/12/29.
//  Copyright © 2015年 DBBPerson. All rights reserved.
//

#import "AppDelegate.h"
#import "MyTabBarViewController.h"
#import "GuidePageView.h"
#import "MMDrawerController.h"
#import "LeftViewController.h"
#define isRuned @"1"

//友盟
#import "UMSocialQQHandler.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialSinaHandler.h"

@interface AppDelegate ()
@property(nonatomic,retain)MyTabBarViewController * myTabBar;

@property(nonatomic,retain)GuidePageView * GuidePage;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];

    self.myTabBar =[[MyTabBarViewController alloc]init];
    LeftViewController * leftVC = [[LeftViewController alloc]init];
    MMDrawerController * drawVc = [[MMDrawerController alloc]initWithCenterViewController:self.myTabBar leftDrawerViewController:leftVC];
    //打开关闭的模式
    drawVc.openDrawerGestureModeMask = MMOpenDrawerGestureModeAll;
    drawVc.closeDrawerGestureModeMask = MMCloseDrawerGestureModeAll;
    
    //设置左页面打开之后的宽度
    drawVc.maximumLeftDrawerWidth = SCREEN_W - 100;
    
    self.window.rootViewController=drawVc;

    
    //添加引导页
    [self createGuidePage];
    [self addUMShare];
    
    return YES;
}

#pragma mark 添加友盟分享
-(void)addUMShare
{
    //注册友盟
    [UMSocialData setAppKey:APPKEY];
    //设置 QQ 的 appId appkey 和 url  
    [UMSocialQQHandler setQQWithAppId:@"1104908293" appKey:@"MnGtpPN5AiB6MNvj" url:nil];
    //微信
    [UMSocialWechatHandler setWXAppId:@"wx12b249bcbf753e87" appSecret:@"0a9cd00c48ee47a9b23119086bcd3b30" url:nil];
    //打开微博的 SSO 开关
    [UMSocialSinaHandler openSSOWithRedirectURL:nil];
    //隐藏未安装的客户端 (主要针对 qq 和 微信)
    [UMSocialConfig hiddenNotInstallPlatforms:@[UMShareToQQ,UMShareToQzone,UMShareToWechatSession,UMShareToWechatTimeline]];
}


//添加引导页
-(void)createGuidePage
{
    if (![[NSUserDefaults standardUserDefaults]objectForKey:isRuned])
    {
        
        //初始化
        NSArray * imageArray=@[@"welcome1",@"welcome2",@"welcome3",@"welcome4",@"welcome5"];
        
        self.GuidePage =[[GuidePageView alloc]initWithFrame:self.window.bounds ImageArray:imageArray];
        
        [self.myTabBar.view addSubview:self.GuidePage];
        
        //第一次运行完成之后进行记录
        [[NSUserDefaults standardUserDefaults] setObject:@YES forKey:isRuned];
    }
    
    [self.GuidePage.GoInButton addTarget:self action:@selector(GoInAppClick) forControlEvents:UIControlEventTouchUpInside];
    
}


-(void)GoInAppClick
{
    [self.GuidePage removeFromSuperview];
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
