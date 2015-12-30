//
//  ArticolDetailViewController.m
//  LoveLife
//
//  Created by qianfeng on 15/12/30.
//  Copyright © 2015年 DBBPerson. All rights reserved.
//

#import "ArticolDetailViewController.h"

@interface ArticolDetailViewController ()

@end

@implementation ArticolDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self settingNav];
    [self createUI];
}

-(void)createUI
{
    UIWebView * webView=  [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H)];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:ARTICALDETAILURL,self.model.dataID]]]];
    //让 webView 适应屏幕大小
    webView.scalesPageToFit = YES;
    [self.view addSubview:webView];
}

-(void)settingNav
{
    self.titleLabel.text = @"详情";
    [self.leftButton setImage:[UIImage imageNamed:@"iconfont-back"] forState:UIControlStateNormal];
    [self.rightButton setImage:[UIImage imageNamed:@"iconfont-fenxiang"] forState:UIControlStateNormal];
    [self setLeftButtonClick:@selector(leftButtonClick)];
    [self setRightButtonClick:@selector(rightButtonClick)];
}

#pragma mark 按钮响应
-(void)leftButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
//分享
-(void)rightButtonClick
{
    UIImage * image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.model.pic]]];
    
    [UMSocialSnsService presentSnsIconSheetView:self appKey:APPKEY shareText:[NSString stringWithFormat:ARTICALDETAILURL,self.model.dataID] shareImage:image shareToSnsNames:@[UMShareToSina,UMShareToQzone,UMShareToQQ,UMShareToWechatTimeline,UMShareToWechatSession] delegate:nil]; //nil 是回调的通知分享成功还是失败
    
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
