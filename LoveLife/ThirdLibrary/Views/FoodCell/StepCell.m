//
//  StepCell.m
//  LoveLife
//
//  Created by qianfeng on 16/1/5.
//  Copyright © 2016年 DBBPerson. All rights reserved.
//

#import "StepCell.h"

@implementation StepCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

-(void)createUI
{
    _stepImageView = [FactoryUI createImageViewWithFrame:CGRectMake(10, 10, SCREEN_W-20, 170) imageName:nil];
    [self.contentView addSubview:_stepImageView];
    
    _stepLabel = [FactoryUI createLabelWithFrame:CGRectMake(10, CGRectGetMaxY(_stepImageView.frame)+5, SCREEN_W-20, 20) text:nil textColor:[UIColor darkGrayColor] font:[UIFont systemFontOfSize:16]];
    _stepLabel.numberOfLines = 0;
    _stepLabel.lineBreakMode = NSLineBreakByCharWrapping;
    [self.contentView addSubview:_stepLabel];
}
-(void)config:(StepModel *)model indexPath:(NSIndexPath *)indexPath
{
    [_stepImageView sd_setImageWithURL:[NSURL URLWithString:model.dishes_step_image] placeholderImage:[UIImage imageNamed:@""]];
    NSMutableAttributedString * string = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%ld:%@",indexPath.row+1,model.dishes_step_desc]];
    if (indexPath.row + 1>9) {
        [string addAttributes:@{NSForegroundColorAttributeName:RGB(255, 156, 187, 1)} range:NSMakeRange(0, 3)];
    }
    else{
        [string addAttributes:@{NSForegroundColorAttributeName:RGB(255, 156, 187, 1)} range:NSMakeRange(0, 2)];
    }
    _stepLabel.attributedText = string;
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end