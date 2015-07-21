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

@interface MyClass : NSObject {}
- (NSString *)appendMyString:(NSString *)string;
@end

@implementation MyClass
- (NSString *)appendMyString:(NSString *)string {
    return [NSString stringWithFormat:@"%@ after append method", string];
}


- (NSString *)appendMyString:(NSString *)one Two:(NSString *)two Three:(NSString *)three {
    return [NSString stringWithFormat:@"one: %@, two: %@, three: %@", one, two, three];
}
@end

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

- (void)testNSInvocation {
    MyClass *myClass = [[MyClass alloc] init];
    NSString *myString = @"My string";
    
    //普通调用
    NSString *normalInvokeString = [myClass appendMyString:myString];
    NSLog(@"The normal invoke string is: %@", normalInvokeString);
    
    //NSInvocation调用
    SEL mySelector = @selector(appendMyString:Two:Three:);
    NSMethodSignature * sig = [[myClass class]
                               instanceMethodSignatureForSelector: mySelector];
    
    NSInvocation * myInvocation = [NSInvocation invocationWithMethodSignature: sig];
    [myInvocation setTarget: myClass];
    [myInvocation setSelector: mySelector];
    
    [myInvocation setArgument: &myString atIndex: 2];
    [myInvocation setArgument: &myString atIndex: 3];
    [myInvocation setArgument: &myString atIndex: 4];
    
    NSString * result = nil;
    [myInvocation retainArguments];
    [myInvocation invoke];
    [myInvocation getReturnValue: &result];
    NSLog(@"The NSInvocation invoke string is: %@", result);
}


@end
