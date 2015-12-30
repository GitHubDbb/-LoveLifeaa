//
//  HomeViewController.m
//  LoveLife
//
//  Created by qianfeng on 15/12/29.
//  Copyright © 2015年 DBBPerson. All rights reserved.
//

#import "HomeViewController.h"
//打开抽屉
#import "UIViewController+MMDrawerController.h"
//二维码扫描
#import "CustomViewController.h"
//轮播
#import "Carousel.h"

#import "HomeModel.h"
#import "HomeCell.h"
#import "HomeDetailViewController.h"

@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    Carousel * _cyclePlaying;
    UITableView * _tableView;
    
    //分页
    int _page;
}
//数据源
@property(nonatomic,retain)NSMutableArray * dataArray;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self settingNav];
    [self createTableHeaderView];
    [self createTableView];
    [self createRefresh];
}

-(void)createRefresh{
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(LoadNewData)];
    _tableView.footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    //当程序第一次启动的时候让自动刷新一次
    [_tableView.header beginRefreshing];
}
//下拉刷新
-(void)LoadNewData
{
    _page =1;
    //清空数组
    self.dataArray = [NSMutableArray arrayWithCapacity:0];
    [self getData];
}
//上拉加载
-(void)loadMoreData
{
    _page++;
    [self getData];
}

//请求数据
-(void)getData{
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    [manager GET:[NSString stringWithFormat:HOMEURL,_page] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        for (NSDictionary * dict in responseObject[@"data"][@"topic"]) {
            HomeModel * model = [[HomeModel alloc]init];
            [model setValuesForKeysWithDictionary:dict];
            [self.dataArray addObject:model];
        }
        //请求成功后停止刷新,刷新界面
        if (_page ==1) {
            [_tableView.header endRefreshing];
        }
        else{
            [_tableView.footer endRefreshing];
        }
        [_tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

-(void)createTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H-49) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
/**    //修改分割线
     //方法1
    _tableView.separatorColor = [UIColor clearColor];
     //方法2
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //去除多余的线条 (空数据的)
    _tableView.tableFooterView = [[UIView alloc]init];
 */
    
    //头视图
    _tableView.tableHeaderView = _cyclePlaying;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    if(!cell){
        cell = [[HomeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
    }
    //赋值
    if (self.dataArray) {
        HomeModel * model = self.dataArray[indexPath.row];
        [cell refreshUI:model];
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200;
}

-(void)createTableHeaderView
{
    _cyclePlaying = [[Carousel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H/3)];
    //是否需要 pageControl
    _cyclePlaying.needPageControl = YES;
    //是否要无限轮播
    _cyclePlaying.infiniteLoop = YES;
    //pagecontrol 的位置
    _cyclePlaying.pageControlPositionType = PAGE_CONTROL_POSITION_TYPE_MIDDLE;
    _cyclePlaying.imageArray = @[@"shili8",@"shili2",@"shili10",@"shili13"];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeDetailViewController * detail = [[HomeDetailViewController alloc]init];
    //传值
    HomeModel * model = self.dataArray[indexPath.row];
    detail.dataID = model.dataID;
    //隐藏 tabBar
    detail.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detail animated:YES];
}


#pragma mark - 设置导航
-(void)settingNav
{
     self.titleLabel.text = @"爱生活";
    [self.leftButton setImage:[UIImage imageNamed:@"icon_function"] forState:UIControlStateNormal];
    [self.rightButton setImage:[UIImage imageNamed:@"2vm"] forState:UIControlStateNormal];
    //响应事件
    [self setLeftButtonClick:@selector(leftButtonClick)];
    [self setRightButtonClick:@selector(rightButtonClick)];
}

#pragma  mark 
-(void)leftButtonClick
{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

-(void)rightButtonClick
{
    //设置 no 一维 二维都能
    CustomViewController * Vc = [[CustomViewController alloc]initWithIsQRCode:NO Block:^(NSString * result, BOOL isSuccess) {
        if (isSuccess) {
            NSLog(@"%@",result);
        }
    }];
    [self presentViewController:Vc animated:YES completion:nil];
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
