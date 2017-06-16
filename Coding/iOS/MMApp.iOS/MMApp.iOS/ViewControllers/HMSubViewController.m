//
//  JGSubViewController.m
//
//  Created by Sam Yu on 2/23/17.
//  Copyright © 2017 LLBT. All rights reserved.
//

#import "HMSubViewController.h"

@interface HMSubViewController ()
@property(nonatomic, strong) NSString *url;
@end

@implementation HMSubViewController

-(id) initWithUrl:(NSString *)url
{
    if(self = [super init])
    {
        _url = [[NSString alloc]initWithString:url];
    }
    return self;
    
}

//启动web页面
- (void)loadWebPage:(UIWebView*)webView
{
    [self loadRemotePage:webView remoteURLStr:_url];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
