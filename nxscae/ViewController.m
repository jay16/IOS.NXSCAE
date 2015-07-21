//
//  ViewController.m
//  nxscae
//
//  Created by lijunjie on 15/7/20.
//  Copyright (c) 2015年 solife. All rights reserved.
//

#import "ViewController.h"
#import "HttpUtils.h"
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
    
    NSString *html=@"<html>", *table = @"<table class='table table-strip table-condensed table-bordered'>", *tr;
    for(ProductDayinfo *dayinfo in [ProductDayinfo list]) {
        tr = [NSString stringWithFormat:@"<tr><td>%@</td><td>%@</td><td>%@</td></tr>", dayinfo.fullname, dayinfo.curPrice, dayinfo.currentGains];
        table = [table stringByAppendingString:tr];
    }
    table = [table stringByAppendingString:@"</table>"];
    
    html = [html stringByAppendingString:@"<script src='jquery-2.1.1.min.js' type='text/javascript'></script>"];
    html = [html stringByAppendingString:@"<script src='bootstrap.320.min.js' type='text/javascript'></script>"];
    html = [html stringByAppendingString:@"<link href='bootstrap.320.min.css' media='screen' rel='stylesheet' type='text/css'>"];
    
    html = [html stringByAppendingString:table];
    html = [html stringByAppendingString:@"</html>"];
    
    NSURL *baseURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]];
    [self.webView loadHTMLString:html baseURL:baseURL
     ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
