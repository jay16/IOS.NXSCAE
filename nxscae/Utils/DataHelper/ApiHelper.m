//
//  ApiHelper.m
//  iSearch
//
//  Created by lijunjie on 15/7/10.
//  Copyright (c) 2015年 Intfocus. All rights reserved.
//

#import "ApiHelper.h"
#import "const.h"
#import "HttpUtils.h"
#import "HttpResponse.h"
#import "ExtendNSLogFunctionality.h"

@implementation ApiHelper

/**
 *  用户操作记录
 *
 *  @param params ActionLog.toParams
 *
 *  @return 服务器响应信息
 */
+ (HttpResponse *)products {
    HttpResponse *httpResponse = [HttpUtils httpPost:NxscaeUrl Params:@{}];
    return httpResponse;
}


@end
