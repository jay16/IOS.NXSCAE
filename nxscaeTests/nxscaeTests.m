//
//  nxscaeTests.m
//  nxscaeTests
//
//  Created by lijunjie on 15/7/20.
//  Copyright (c) 2015年 solife. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "ApiHelper.h"
#import "HttpResponse.h"
#import "Product.h"

@interface nxscaeTests : XCTestCase

@end

@implementation nxscaeTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testPost {
    HttpResponse *httpResponse = [ApiHelper products];
    XCTAssertEqual([httpResponse.statusCode intValue], 200);
    XCTAssertEqualObjects(httpResponse.chartset, @"utf-8");
    //XCTAssertEqualObjects(httpResponse.contentType, @"application/json");
    XCTAssertGreaterThan([httpResponse.data[@"tables"] count], 0);
}

- (void)testProduct {
    Product *product = [[Product alloc] init];
    [product refresh];
}
@end
