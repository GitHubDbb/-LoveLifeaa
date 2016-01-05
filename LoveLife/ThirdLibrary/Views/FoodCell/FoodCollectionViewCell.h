//
//  FoodCollectionViewCell.h
//  LoveLife
//
//  Created by qianfeng on 15/12/31.
//  Copyright © 2015年 DBBPerson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FoodModel.h"

@protocol playDelegate <NSObject>

-(void)play:(FoodModel*)model;

@end

@interface FoodCollectionViewCell : UICollectionViewCell

{
    //图片
    UIImageView * _imageView;
    //标题
    UILabel * _titleLabel;
    //描述
    UILabel * _desLabel;
    
}

//声明一个代理的对象  用 weak 放置内部循环引用,内存泄露  ARC 下得 strong 和 weak 相当于 MRC 的 retain 和 assign
@property(nonatomic,weak)id<playDelegate>delegate;

-(void)refreshUI:(FoodModel*)model;

@end
