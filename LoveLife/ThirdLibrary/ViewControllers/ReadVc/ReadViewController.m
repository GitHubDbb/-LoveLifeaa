//
//  ReadViewController.m
//  LoveLife
//
//  Created by qianfeng on 15/12/29.
//  Copyright © 2015年 DBBPerson. All rights reserved.
//

#import "ReadViewController.h"
#import "ArticolViewController.h"
#import "RecordViewController.h"

@interface ReadViewController ()<UIScrollViewDelegate>
{
    UIScrollView * _scrollView;
    UISegmentedControl * _segmentControl;
}

@end

@implementation ReadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self settingNav];
    [self createUI];
}

-(void)settingNav
{
    //创建 segment
    _segmentControl = [[UISegmentedControl alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    //插入标题
    [_segmentControl insertSegmentWithTitle:@"读美文" atIndex:0 animated:YES];
    [_segmentControl insertSegmentWithTitle:@"看语录" atIndex:1 animated:YES];
    //字体颜色
    _segmentControl.tintColor = [UIColor whiteColor];
    //
    //_segmentControl.backgroundColor = [UIColor blueColor];
    
    //设置默认选中 读美文
    _segmentControl.selectedSegmentIndex = 0;
    //响应方法
    [_segmentControl addTarget:self action:@selector(changeOptions:) forControlEvents:UIControlEventValueChanged];
    
    self.navigationItem.titleView = _segmentControl;
}

#pragma segment响应方法
-(void)changeOptions:(UISegmentedControl*)segment
{
    //判断不好,用下边的
//    if (segment.selectedSegmentIndex==1) {
//        _scrollView.contentOffset = CGPointMake(SCREEN_W, 0);
//    }
//    else
//    {
//        _scrollView.contentOffset = CGPointMake(0, 0);
//    }
    
    _scrollView.contentOffset = CGPointMake(segment.selectedSegmentIndex *SCREEN_W, 0);
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    _segmentControl.selectedSegmentIndex = scrollView.contentOffset.x/SCREEN_W;
}


#pragma mark-创建 UI
-(void)createUI
{
    //创建 scrollView
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H)];
    _scrollView.delegate = self;
    //设置分页
    _scrollView.pagingEnabled = YES;
    //这个有冲突. 暂时关闭,就滑动不了了
    _scrollView.scrollEnabled = NO;
    //隐藏指示条
    _scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_scrollView];
    //容量  写成0 就不会乱窜了
    _scrollView.contentSize = CGSizeMake(SCREEN_W*2, 0);
    //实例化子控制器
    ArticolViewController * articolVc = [[ArticolViewController alloc]
                                         init];
    RecordViewController * recordVc = [[RecordViewController alloc]init];
    NSArray * VcArray = @[articolVc,recordVc];
#warning 滚动框架
    //滚动框架实现
    int i = 0;
    for (UIViewController *vc in VcArray) {
        vc.view.frame = CGRectMake(i*SCREEN_W, 0, SCREEN_W, SCREEN_H);
        //先给本页面添加子控制器,才能添加 View
        [self addChildViewController:vc];
        [_scrollView addSubview:vc.view];
        i++;
        
    }
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
