//
//  MusicPlayingViewController.h
//  LoveLife
//
//  Created by qianfeng on 16/1/5.
//  Copyright © 2016年 DBBPerson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MusicModel.h"

@interface MusicPlayingViewController : UIViewController
//传值
@property(nonatomic,strong)MusicModel * model;
//MP3文件
@property(nonatomic,strong)NSArray * urlArray;
//index 值
@property(nonatomic,assign)int currentIndex;
@end
