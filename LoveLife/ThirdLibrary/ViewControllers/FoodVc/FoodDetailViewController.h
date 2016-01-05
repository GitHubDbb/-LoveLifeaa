//
//  FoodDetailViewController.h
//  LoveLife
//
//  Created by qianfeng on 16/1/5.
//  Copyright © 2016年 DBBPerson. All rights reserved.
//

#import "RootViewController.h"

@interface FoodDetailViewController : RootViewController

//id
@property(nonatomic,copy) NSString * dataId;
//菜名
@property(nonatomic,copy) NSString * NavTitle;
//视频url
@property(nonatomic,strong) NSString * videoUrl;


@end
