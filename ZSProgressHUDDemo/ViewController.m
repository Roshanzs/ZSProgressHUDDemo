//
//  ViewController.m
//  ZSProgressHUDDemo
//
//  Created by 紫贝壳 on 2017/8/7.
//  Copyright © 2017年 stark. All rights reserved.
//

#import "ViewController.h"
#import "ZSProgressHUD.h"
@interface ViewController ()
@property(nonatomic,strong)NSTimer *timer;
@property(nonatomic,assign)CGFloat zsfloat;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _zsfloat = 0;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    UIButton *btnmsg = [[UIButton alloc]initWithFrame:CGRectMake(150, 60, 75, 40)];
    btnmsg.backgroundColor =  [UIColor grayColor];
    [btnmsg setTitle:@"文字" forState:UIControlStateNormal];
    [self.view addSubview:btnmsg];
    [btnmsg addTarget:self action:@selector(btnClickmsg) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btninfo = [[UIButton alloc]initWithFrame:CGRectMake(150, 120, 75, 40)];
    btninfo.backgroundColor =  [UIColor grayColor];
    [btninfo setTitle:@"提示消息" forState:UIControlStateNormal];
    [self.view addSubview:btninfo];
    [btninfo addTarget:self action:@selector(btnClickinfo) forControlEvents:UIControlEventTouchUpInside];

    UIButton *btnnet = [[UIButton alloc]initWithFrame:CGRectMake(150, 180, 75, 40)];
    btnnet.backgroundColor =  [UIColor grayColor];
    [btnnet setTitle:@"网络等待" forState:UIControlStateNormal];
    [self.view addSubview:btnnet];
    [btnnet addTarget:self action:@selector(btnClicknet) forControlEvents:UIControlEventTouchUpInside];

    UIButton *btnsuccess = [[UIButton alloc]initWithFrame:CGRectMake(150, 240, 75, 40)];
    btnsuccess.backgroundColor =  [UIColor grayColor];
    [btnsuccess setTitle:@"成功" forState:UIControlStateNormal];
    [self.view addSubview:btnsuccess];
    [btnsuccess addTarget:self action:@selector(btnClicksuccess) forControlEvents:UIControlEventTouchUpInside];

    UIButton *btnerror = [[UIButton alloc]initWithFrame:CGRectMake(150, 300, 75, 40)];
    btnerror.backgroundColor =  [UIColor grayColor];
    [btnerror setTitle:@"失败" forState:UIControlStateNormal];
    [self.view addSubview:btnerror];
    [btnerror addTarget:self action:@selector(btnClickerror) forControlEvents:UIControlEventTouchUpInside];

    UIButton *btntimer = [[UIButton alloc]initWithFrame:CGRectMake(150, 360, 75, 40)];
    btntimer.backgroundColor =  [UIColor grayColor];
    [btntimer setTitle:@"进度显示" forState:UIControlStateNormal];
    [self.view addSubview:btntimer];
    [btntimer addTarget:self action:@selector(btnClickProgress) forControlEvents:UIControlEventTouchUpInside];

}

-(void)btnClickmsg{
    [ZSProgressHUD showMessage:@"文字显示"];
}
-(void)btnClickinfo{
    [ZSProgressHUD showInfo:@"提示消息"];
}
-(void)btnClicknet{
    [ZSProgressHUD showNet:@"网络等待"];
}
-(void)btnClicksuccess{
    [ZSProgressHUD showSuccess:@"成功"];
}
-(void)btnClickerror{
    [ZSProgressHUD showSuccess:@"失败"];
}

-(void)btnClickProgress{
    MBProgressHUD *p = [ZSProgressHUD showProgressCircle:@"进度"];
    __weak typeof(p) weakself = p;
     __weak typeof(self) weak = self;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
        weakself.progress = _zsfloat++ * 0.1;
        if (weakself.progress >= 1) {
            [ZSProgressHUD showSuccess:@"成功"];
            [weak.timer invalidate];
            weak.timer = nil;
            weak.zsfloat = 0;
        }
    }];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
