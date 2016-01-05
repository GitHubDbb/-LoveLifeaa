//
//  MyViewController.m
//  LoveLife
//
//  Created by qianfeng on 15/12/29.
//  Copyright © 2015年 DBBPerson. All rights reserved.
//

#import "MyViewController.h"
#import "AppDelegate.h"
#import "QRCodeGenerator.h"

@interface MyViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * _tableView;
    UIImageView * _headerImageView;
    //夜间模式
    UIView * _darkView;
}

@property(nonatomic,strong)NSArray * logoArray;
@property(nonatomic,strong)NSArray * titleArray;


@end

@implementation MyViewController
static float ImageOriginHeight = 200;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.logoArray = @[@"iconfont-iconfontaixinyizhan",@"iconfont-lajitong",@"iconfont-yejianmoshi",@"iconfont-zhengguiicon40",@"iconfont-guanyu"];
    self.titleArray = @[@"我的收藏",@"清理缓存",@"夜间模式",@"推送消息",@"关于"];
    _darkView = [[UIView alloc]initWithFrame:self.view.frame];
    [self settingNav];
    [self createUI];
    //二维码
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 200, 200)];
    imageView.image = [QRCodeGenerator qrImageForString:@"www.baidu.com" imageSize:300]; //300是清晰度,越大越清晰
    [self.view addSubview:imageView];

}

-(void)settingNav
{
    self.titleLabel.text = @"我的";
}

-(void)createUI
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.tableFooterView = [[UIView alloc]init];
    
    _headerImageView = [FactoryUI createImageViewWithFrame:CGRectMake(0, -ImageOriginHeight, SCREEN_W, ImageOriginHeight) imageName:@"welcome1"];
    [_tableView addSubview:_headerImageView];
    
    //设置tableView内容从 ImageOriginHeight 开始显示
    _tableView.contentInset = UIEdgeInsetsMake(ImageOriginHeight, 0, 0, 0);
}

#pragma mark - 代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        if (indexPath.row == 0 || indexPath.row ==1 || indexPath.row ==4) {
            //设置尾部
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        if (indexPath.row == 2 || indexPath.row == 3) {
            UISwitch * swi = [[UISwitch alloc]initWithFrame:CGRectMake(SCREEN_W- 60, 5, 50, 30)];
            //设置颜色
            swi.onTintColor = [UIColor greenColor];
            swi.tag = indexPath.row;
            [swi addTarget:self action:@selector(changeOption:) forControlEvents:UIControlEventValueChanged];
        }
    }
    //赋值
    cell.imageView.image = self.logoArray[indexPath.row];
    cell.textLabel.text = self.titleArray[indexPath.row];
    return cell;
}

-(void)changeOption:(UISwitch*)swi
{
    if (swi.tag == 2) {
        //夜间模式
        if (swi.on) {
            UIApplication * app = [UIApplication sharedApplication];
            AppDelegate * delegate = app.delegate;
            //设置 view 的背景颜色
            _darkView.backgroundColor = [UIColor blackColor];
            _darkView.alpha = 0.2;
            //关掉 view 的交互属性  不然铺上就点不了了
            _darkView.userInteractionEnabled = NO;
            [delegate.window addSubview:_darkView];
        }
        else
        {
            [_darkView removeFromSuperview];
        }
    }
    else
    {
        //清理缓存
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}

#pragma mark - scroll 的代理方法
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //通过改变 scrollView 的偏移量 (contentOffset) 来改变图片的 frame
    if (scrollView == _tableView) {
        //获取 scroll 的偏移量
        CGFloat yOffset = scrollView.contentOffset.y;
        CGFloat xOffset = (yOffset + ImageOriginHeight)/2;
        if (yOffset < -ImageOriginHeight) {
            CGRect rect = _headerImageView.frame;
            //改变 imageView 的 frame
            rect.origin.y = yOffset;
            rect.size.height = -yOffset;
            rect.origin.x = xOffset;
            rect.size.width = SCREEN_W + fabs(xOffset)*2;
            _headerImageView.frame = rect;
        }
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
