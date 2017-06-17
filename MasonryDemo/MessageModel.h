//
//  MessageModel.h
//  MasonryDemo
//
//  Created by luckyCoderCai on 2017/6/17.
//  Copyright © 2017年 luckyCoderCai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageModel : NSObject

@property (nonatomic, copy) NSString *headImageName;//头像
@property (nonatomic, assign) BOOL isRead;//是否已读 0.未读 1.已读
@property (nonatomic, copy) NSString *name;//姓名
@property (nonatomic, copy) NSString *information;//描述信息
@property (nonatomic, copy) NSString *time;//时间

@end
