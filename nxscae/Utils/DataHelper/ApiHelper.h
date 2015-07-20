//
//  ApiHelper.h
//  iSearch
//
//  Created by lijunjie on 15/7/10.
//  Copyright (c) 2015年 Intfocus. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HttpResponse;
/**
 *  仅处理与服务器获取信息交互
 *  服务器获取失败或无网络时，交给CacheHelper
 */
@interface ApiHelper : NSObject
/**
 *  用户操作记录
 *
 *  @param params ActionLog.toParams
 *
 *  @return 服务器响应信息
 */
+ (HttpResponse *)products;
@end
