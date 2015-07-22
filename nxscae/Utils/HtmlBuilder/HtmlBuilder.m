//
//  HtmlBuilder.m
//  nxscae
//
//  Created by lijunjie on 15/7/22.
//  Copyright (c) 2015年 solife. All rights reserved.
//

#import "HtmlBuilder.h"

@implementation HtmlBuilder

- (HtmlBuilder *)init {
    if(self = [super init]) {
        _content = [[NSMutableString alloc] init];
    }
    return self;
}

- (void)clear {
    _content = nil;
    _content = [[NSMutableString alloc] init];
}

+ (NSString *)attrToString:(NSDictionary *)attrDict {
    NSMutableArray *attrArray = [[NSMutableArray alloc] init];
    for(NSString *key in attrDict) {
        [attrArray addObject:[NSString stringWithFormat:@"%@='%@'", key, attrDict[key]]];
    }
    return [attrArray componentsJoinedByString:@" "];
}

+ (NSString *)tag:(NSString *)tagName Content:(NSString *)content Attribute:(NSString *)attrString {
    return [NSString stringWithFormat:@"<%@ %@>%@</%@>", tagName, attrString, content, tagName];
}

+ (NSString *)tag:(NSString *)tagName Content:(NSString *)content Attributes:(NSDictionary *)attrDict {
    return [HtmlBuilder tag:tagName Content:content Attribute:[HtmlBuilder attrToString:attrDict]];
}
+ (NSString *)tag:(NSString *)tagName Content:(NSString *)content {
    return [HtmlBuilder tag:tagName Content:content Attribute:[HtmlBuilder attrToString:@{}]];
}

+ (NSString *)tag:(NSString *)tagName Contents:(NSArray *)contents Attributes:(NSDictionary *)attrDict {
    NSMutableString *tmpString = [[NSMutableString alloc] init];
    NSString *attrString = [HtmlBuilder attrToString:attrDict];
    for(id content in contents) {
        [tmpString appendString:[HtmlBuilder tag:tagName Content:content Attribute:attrString]];
    }
    return [NSString stringWithString:tmpString];
}
+ (NSString *)tag:(NSString *)tagName Contents:(NSArray *)contents {
    NSMutableString *tmpString = [[NSMutableString alloc] init];
    for(id content in contents) {
        [tmpString appendString:[HtmlBuilder tag:tagName Content:content Attribute:@""]];
    }
    return [NSString stringWithString:tmpString];
}

+ (NSString *)script:(NSString *)fileName {
    return [NSString stringWithFormat:@"<script src='%@' type='text/javascript'></script>", fileName];
}

+ (NSString *)stylesheet:(NSString *)fileName {
    return [NSString stringWithFormat:@"<link href='%@' media='screen' rel='stylesheet' type='text/css'>", fileName];
}

- (void)script:(NSString *)fileName {
    [self.content appendString: [HtmlBuilder script:fileName]];
}

- (void)stylesheet:(NSString *)fileName {
    [self.content appendString: [HtmlBuilder stylesheet:fileName]];
}

- (void)tag:(NSString *)tagName Content:(NSString *)content Attributes:(NSDictionary *)attrDict {
    [self.content appendString:[HtmlBuilder tag:tagName Content:content Attributes:attrDict]];
}

- (void)tag:(NSString *)tagName Contents:(NSArray *)contents Attributes:(NSDictionary *)attrDict {
    [self.content appendString:[HtmlBuilder tag:tagName Contents:contents Attributes:attrDict]];
}

- (void)tag:(NSString *)tagName Content:(NSString *)content {
    [self.content appendString:[HtmlBuilder tag:tagName Content:content Attributes:@{}]];
}

- (void)tag:(NSString *)tagName Contents:(NSArray *)contents {
    [self.content appendString:[HtmlBuilder tag:tagName Contents:contents Attributes:@{}]];
}

- (void)wrap:(NSString *)tagName {
    _content = [NSMutableString stringWithString:[NSString stringWithFormat:@"<%@>%@</%@>", tagName, self.content, tagName]];
}

- (NSString *)string {
    return [NSString stringWithString:self.content];
}
@end
