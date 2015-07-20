//
//  Database_Utils.h
//  AudioNote
//
//  Created by lijunjie on 15-1-5.
//  Copyright (c) 2015年 Intfocus. All rights reserved.
//

#ifndef AudioNote_Database_Utils_h
#define AudioNote_Database_Utils_h
#import <Foundation/Foundation.h>

@interface DatabaseUtils : NSObject

@property NSString *userID;
@property NSString *dbVersion;
@property NSString *dbName;
@property NSString *dbPath;

// instance methods
- (NSInteger)executeSQL:(NSString *)sql;
- (NSInteger)findID:(NSString *)sql;

@end

#endif
