//
//  RootViewController.h
//  LoveLife
//
//  Created by qianfeng on 15/12/29.
//  Copyright © 2015年 DBBPerson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController
//左按钮
@property(nonatomic,retain)UIButton * leftButton;
//右按钮
@property(nonatomic,retain)UIButton * rightButton;
//标题
@property(nonatomic,retain)UILabel * titleLabel;

//响应事件
-(void)setLeftButtonClick:(SEL)selector;
-(void)setRightButtonClick:(SEL)selector;

@end
