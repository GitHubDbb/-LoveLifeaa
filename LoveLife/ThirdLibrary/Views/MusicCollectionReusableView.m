//
//  MusicCollectionReusableView.m
//  LoveLife
//
//  Created by qianfeng on 16/1/5.
//  Copyright © 2016年 DBBPerson. All rights reserved.
//

#import "MusicCollectionReusableView.h"

@implementation MusicCollectionReusableView
-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.titleLabel = [FactoryUI createLabelWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height) text:nil textColor:nil font:[UIFont systemFontOfSize:15]];
        [self addSubview:self.titleLabel];
    }
    
    return self;
}


@end
