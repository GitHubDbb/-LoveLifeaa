//
//  MyTabBarViewController.m
//  LoveLife
//
//  Created by qianfeng on 15/12/29.
//  Copyright © 2015年 DBBPerson. All rights reserved.
//

#import "MyTabBarViewController.h"
#import "ReadViewController.h"
#import "MyViewController.h"
#import "HomeViewController.h"
#import "MusicViewController.h"
#import "FoodViewController.h"

@interface MyTabBarViewController ()

@end

@implementation MyTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createViewControllers];
    [self createTabBarItem];
    
}

-(void)createViewControllers{
    UINavigationController * Home = [[UINavigationController alloc]initWithRootViewController:[[HomeViewController alloc]init]];
    //阅读
    UINavigationController * Read = [[UINavigationController alloc]initWithRootViewController:[[ReadViewController alloc]init]];
    
    //美食
    UINavigationController * Food = [[UINavigationController alloc]initWithRootViewController:[[FoodViewController alloc]init]];
    
    //音乐
    UINavigationController * Music = [[UINavigationController alloc]initWithRootViewController:[[MusicViewController alloc]init]];
    
    //我的
    UINavigationController * My=[[UINavigationController alloc]initWithRootViewController:[[MyViewController alloc]init]];
    
    self.viewControllers = @[Home,Read,Food,Music,My];
}

-(void)createTabBarItem
{
    //未选中的图片
    NSArray * unSelectedImageNames=@[@"ic_tab_home_normal@2x",@"ic_tab_category_normal@2x",@"iconfont-iconfontmeishi",@"health",@"ic_tab_profile_normal_female@2x"];
    
    //选中时的图片
    NSArray * SelectedImageNames=@[@"ic_tab_home_selected@2x",@"ic_tab_category_selected@2x",@"iconfont-iconfontmeishi-2",@"health2",@"ic_tab_profile_selected_female@2x"];
    
    //标题
    NSArray * titleArray = @[@"首页",@"阅读",@"美食",@"音乐",@"我的"];
    
    //循环赋值
    for (int i =0; i<self.tabBar.items.count; i++)
    {
        UIImage * unSelectedImage=[UIImage imageNamed:unSelectedImageNames[i]];
        
        unSelectedImage = [unSelectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                UIImage * selectedImage = [UIImage imageNamed:SelectedImageNames[i]];
        
        selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        //获取Item并且赋值
        UITabBarItem * item = self.tabBar.items[i];
        
        item = [item initWithTitle:titleArray[i] image:unSelectedImage selectedImage:selectedImage];
    }
    //设置选中时的颜色
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} forState:UIControlStateSelected];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
