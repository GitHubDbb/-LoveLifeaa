//
//  DetailModel.h
//  LoveLife
//
//  Created by qianfeng on 16/1/5.
//  Copyright © 2016年 DBBPerson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DetailModel : NSObject
@property(nonatomic,copy) NSString * dashes_id;
@property(nonatomic,copy) NSString * dishes_name;
@property(nonatomic,copy) NSString * image;
@property(nonatomic,copy) NSString * material_desc;
@property(nonatomic,copy) NSString * material_video;
@property(nonatomic,copy) NSString * process_video;
@property(nonatomic,copy) NSString * share_url;
@property(nonatomic,strong) NSArray * step;

@end
