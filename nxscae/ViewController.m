//
//  ViewController.m
//  nxscae
//
//  Created by lijunjie on 15/7/20.
//  Copyright (c) 2015年 solife. All rights reserved.
//

#import "ViewController.h"
#import "HttpUtils.h"
#import "HtmlBuilder.h"
#import "Product.h"
#import "ProductDayInfo.h"

@interface ViewController ()
@property (nonatomic, strong) IBOutlet UIWebView *webView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if([HttpUtils isNetworkAvailable]) {
        [[[Product alloc] init] refresh];
    }
    
    NSString *tr;
    
    NSMutableArray *trs = [[NSMutableArray alloc] init];
    for(ProductDayinfo *dayinfo in [ProductDayinfo list]) {
        [trs addObject:[HtmlBuilder tag:@"td" Contents:@[dayinfo.fullname, dayinfo.curPrice, dayinfo.currentGains]]];
    }
    tr = [HtmlBuilder tag:@"tr" Contents:[NSArray arrayWithArray:trs]];
    
    HtmlBuilder *builder = [[HtmlBuilder alloc] init];
    [builder script:@"jquery-2.1.1.min.js"];
    [builder script:@"bootstrap.320.min.js"];
    [builder stylesheet:@"bootstrap.320.min.css"];
    [builder tag:@"table" Content:tr Attributes:@{@"class":@"table table-strip table-condensed table-bordered"}];
    [builder wrap:@"html"];
    
    NSURL *baseURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]];
    [self.webView loadHTMLString:[builder string] baseURL:baseURL
     ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
