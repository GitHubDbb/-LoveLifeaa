//
//  FoodTitleCollectionViewCell.m
//  LoveLife
//
//  Created by qianfeng on 15/12/31.
//  Copyright © 2015年 DBBPerson. All rights reserved.
//

#import "FoodTitleCollectionViewCell.h"

@implementation FoodTitleCollectionViewCell

-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.titleLabel = [FactoryUI createLabelWithFrame:CGRectMake(0, 0, (SCREEN_W-20)/2, 30) text:nil textColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:15]];
        self.titleLabel.textAlignment = 1;
        [self.contentView addSubview:self.titleLabel];
    }
    return self;
}

@end
