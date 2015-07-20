//
//  ApiUtils.h
//  iSearch
//
//  Created by lijunjie on 15/6/23.
//  Copyright (c) 2015年 Intfocus. All rights reserved.
//

#ifndef iSearch_DataHelper_h
#define iSearch_DataHelper_h
#import <UIKit/UIKit.h>

/**
 *  处理数据: ApiHelper + CacheHelper
 */
@interface DataHelper : NSObject

/**
 *  同步用户行为操作
 *
 *  @param unSyncRecords 未同步数据
 */
+ (NSMutableArray *)products:(NSMutableArray *)unSyncRecords;
@end

#endif
