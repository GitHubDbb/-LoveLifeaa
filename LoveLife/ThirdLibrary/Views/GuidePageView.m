//
//  GuidePageView.m
//  LoveLife
//
//  Created by qianfeng on 15/12/29.
//  Copyright © 2015年 DBBPerson. All rights reserved.
//

#import "GuidePageView.h"

@interface GuidePageView()
{
    UIScrollView * _scrollView;
}

@end

@implementation GuidePageView
-(id)initWithFrame:(CGRect)frame ImageArray:(NSArray *)imageArray{
    if (self = [super initWithFrame:frame]) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H+64)];
        //设置分页
        _scrollView.pagingEnabled = YES;
        //显示内容
        _scrollView.contentSize = CGSizeMake(imageArray.count * SCREEN_W, SCREEN_H + 64);
        [self addSubview:_scrollView];
                for (int i=0; i<imageArray.count; i++) {
            UIImageView * imageView = [FactoryUI createImageViewWithFrame:CGRectMake(i*SCREEN_W, 0, SCREEN_W, SCREEN_H+64) imageName:imageArray[i]];
            [_scrollView addSubview:imageView];
            
            if (i==imageArray.count - 1) {
                self.GoInButton = [UIButton buttonWithType:UIButtonTypeCustom];
                self.GoInButton.frame = CGRectMake(100, 100, 50, 50);
                
                [self.GoInButton setImage:[UIImage imageNamed:@"LinkedIn"] forState:UIControlStateNormal];
                //交互
                imageView.userInteractionEnabled = YES;
                [imageView addSubview:self.GoInButton];
            }
        }
    }
    return self;
}

@end
