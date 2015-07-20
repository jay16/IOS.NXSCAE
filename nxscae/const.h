//
//  const.h
//  nxscae
//
//  Created by lijunjie on 15/7/20.
//  Copyright (c) 2015年 solife. All rights reserved.
//

#ifndef nxscae_const_h
#define nxscae_const_h

#define NxscaeUrl @"http://222.185.140.167:9004/tradeweb/hq/getHqV_lbData.jsp"
#define DATABASE_DIRNAME @"db"
#define DATE_FORMAT             @"yyyy/MM/dd HH:mm:SS" // 用户验证时，用到时间字符串时的存储格式
#define DATE_SIMPLE_FORMAT      @"yyyy/MM/dd" // 公告通知api使用及日历控件

#define DB_COLUMN_CREATED           @"created_at"
#define DB_COLUMN_UPDATED           @"updated_at"


//#藏品代码
//property :code, String , :required => true, :unique => true
#define ColumnCode @"code"
//#藏品简称
//property :fullname, String
#define ColumnFullName @"fullname"
//#最高价
//property :high_price, Float
#define ColumnHighPrice @"high_price"
//#最低价
//property :low_price, Float
#define ColumnLowPrice @"low_price"
//#总成交量
//property :sum_num, Integer
#define ColumnSumNum @"sum_num"
//#总成交金额
//property :sum_money, Float
#define ColumnSumMoney @"sum_money"
//#时间
//property :time, String
#define ColumnTime @"time"
//#昨收盘
//property :yester_balance_price, Float
#define ColumnYesterBlancePrice @"yester_balance_price"
//#今开盘
//property :open_price, Float
#define ColumnOpenPrice @"open_price"
//#最新价
//property :cur_price, Float
#define ColumnCurPrice @"cur_price"
//#涨跌幅
//property :current_gains, Float
#define ColumnCurrentGains @"current_gains"
//#成交量
//property :total_amount, Integer
#define ColumnTotalAmount @"total_amount"
//#成交金额
//property :total_money, Float
#define ColumnTotalMoney @"total_money"

//property :content, Text
#define ColumnContent @"content"

#define TNProduct        @"products"
#define TNProductCache   @"product_caches"
#define TNProductDayInfo @"product_dayinfos"
#endif
