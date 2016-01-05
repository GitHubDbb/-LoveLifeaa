//
//  ArticolViewController.m
//  LoveLife
//
//  Created by qianfeng on 15/12/30.
//  Copyright © 2015年 DBBPerson. All rights reserved.
//

#import "ArticolViewController.h"
#import "ArticolModel.h"
#import "ArticolTableViewCell.h"
#import "ArticolDetailViewController.h"


@interface ArticolViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    //分页
    int _page;
}

@property(nonatomic,retain)UITableView * tableView;
@property(nonatomic,retain)NSMutableArray * dataSourse;

@end

@implementation ArticolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createTableView];
    [self createRefresh];
}

-(void)createRefresh
{
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    _tableView.footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    [_tableView.header beginRefreshing];

}

-(void)loadNewData
{
    _page = 0;
    _dataSourse = [NSMutableArray arrayWithCapacity:0];
    [self getData];
}

-(void)loadMoreData
{
    _page ++;
    [self getData];
}

-(void)getData
{
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    [manager GET:[NSString stringWithFormat:ARTICALURL,_page] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSArray * array = responseObject[@"data"];
        for (NSDictionary * dict in array) {
            ArticolModel * model = [[ArticolModel alloc]init];
            [model setValuesForKeysWithDictionary:dict];
            [_dataSourse addObject:model];
        }
        if (_page ==0) {
            [_tableView.header endRefreshing];
        }
        else{
            [_tableView.footer endRefreshing];
        }
        [_tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSourse.count;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ArticolTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CELLID"];
    if (!cell) {
        cell = [[ArticolTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELLID"];
    }
    ArticolModel * model = self.dataSourse[indexPath.row];
    [cell refreshUI:model];
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150;
}

//给 cell 添加一个动画
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //设置 cell 的动画效果 为3D  ,复杂动画在 layer 层
    cell.layer.transform = CATransform3DMakeScale(0, 0.1, 1);
    [UIView animateWithDuration:1 animations:^{
        cell.layer.transform = CATransform3DMakeScale(1, 1, 1);
    }];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ArticolDetailViewController * detail = [[ArticolDetailViewController alloc]init];
    ArticolModel * model = self.dataSourse[indexPath.row];
    detail.model = model;
    
    detail.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detail animated:YES];
}


-(void)createTableView
{
    _tableView  = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
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
