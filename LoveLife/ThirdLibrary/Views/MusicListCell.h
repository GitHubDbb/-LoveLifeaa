//
//  MusicListCell.h
//  LoveLife
//
//  Created by qianfeng on 16/1/5.
//  Copyright © 2016年 DBBPerson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MusicModel.h"

@interface MusicListCell : UITableViewCell
{
    UIImageView * _imageView;
    //演唱者
    UILabel * _authorLabel;
    //歌曲名称
    UILabel * _nameLabel;
    
    
}
-(void)refreshUI:(MusicModel *)model;


@end
