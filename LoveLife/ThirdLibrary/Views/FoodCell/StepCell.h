//
//  StepCell.h
//  LoveLife
//
//  Created by qianfeng on 16/1/5.
//  Copyright © 2016年 DBBPerson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StepModel.h"

@interface StepCell : UITableViewCell
{
    UIImageView * _stepImageView;
    UILabel * _stepLabel;
}

-(void)config:(StepModel*)model indexPath:(NSIndexPath*)indexPath;

@end
