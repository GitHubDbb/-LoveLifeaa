//
//  ArticolModel.m
//  LoveLife
//
//  Created by qianfeng on 15/12/30.
//  Copyright © 2015年 DBBPerson. All rights reserved.
//

#import "ArticolModel.h"

@implementation ArticolModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.dataID = value;
    }
}

@end
