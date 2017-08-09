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
    
    UIButton *btnmsg = [[UIButton alloc]initWithFrame:CGRectMake(120, 60, 135, 40)];
    btnmsg.backgroundColor =  [UIColor grayColor];
    [btnmsg setTitle:@"文字" forState:UIControlStateNormal];
    [self.view addSubview:btnmsg];
    [btnmsg addTarget:self action:@selector(btnClickmsg) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btninfo = [[UIButton alloc]initWithFrame:CGRectMake(120, 120, 135, 40)];
    btninfo.backgroundColor =  [UIColor grayColor];
    [btninfo setTitle:@"提示消息" forState:UIControlStateNormal];
    [self.view addSubview:btninfo];
    [btninfo addTarget:self action:@selector(btnClickinfo) forControlEvents:UIControlEventTouchUpInside];

    UIButton *btnnet = [[UIButton alloc]initWithFrame:CGRectMake(120, 180, 135, 40)];
    btnnet.backgroundColor =  [UIColor grayColor];
    [btnnet setTitle:@"网络等待" forState:UIControlStateNormal];
    [self.view addSubview:btnnet];
    [btnnet addTarget:self action:@selector(btnClicknet) forControlEvents:UIControlEventTouchUpInside];

    UIButton *btnsuccess = [[UIButton alloc]initWithFrame:CGRectMake(120, 240, 135, 40)];
    btnsuccess.backgroundColor =  [UIColor grayColor];
    [btnsuccess setTitle:@"成功" forState:UIControlStateNormal];
    [self.view addSubview:btnsuccess];
    [btnsuccess addTarget:self action:@selector(btnClicksuccess) forControlEvents:UIControlEventTouchUpInside];

    UIButton *btnerror = [[UIButton alloc]initWithFrame:CGRectMake(120, 300, 135, 40)];
    btnerror.backgroundColor =  [UIColor grayColor];
    [btnerror setTitle:@"失败" forState:UIControlStateNormal];
    [self.view addSubview:btnerror];
    [btnerror addTarget:self action:@selector(btnClickerror) forControlEvents:UIControlEventTouchUpInside];

    UIButton *btntimer = [[UIButton alloc]initWithFrame:CGRectMake(120, 360, 135, 40)];
    btntimer.backgroundColor =  [UIColor grayColor];
    [btntimer setTitle:@"进度显示" forState:UIControlStateNormal];
    [self.view addSubview:btntimer];
    [btntimer addTarget:self action:@selector(btnClickProgress) forControlEvents:UIControlEventTouchUpInside];

    UIButton *btnAlertcenter = [[UIButton alloc]initWithFrame:CGRectMake(120, 420, 135, 40)];
    btnAlertcenter.backgroundColor =  [UIColor grayColor];
    [btnAlertcenter setTitle:@"Alert(中间弹出)" forState:UIControlStateNormal];
    [self.view addSubview:btnAlertcenter];
    [btnAlertcenter addTarget:self action:@selector(btnClickAlartcenter) forControlEvents:UIControlEventTouchUpInside];

    UIButton *btnAlertsheet = [[UIButton alloc]initWithFrame:CGRectMake(120, 480, 135, 40)];
    btnAlertsheet.backgroundColor =  [UIColor grayColor];
    [btnAlertsheet setTitle:@"Alert(底部弹出)" forState:UIControlStateNormal];
    [self.view addSubview:btnAlertsheet];
    [btnAlertsheet addTarget:self action:@selector(btnClickAlartsheet) forControlEvents:UIControlEventTouchUpInside];

    UIButton *btnAlertbox = [[UIButton alloc]initWithFrame:CGRectMake(120, 540, 135, 40)];
    btnAlertbox.backgroundColor =  [UIColor grayColor];
    btnAlertbox.titleLabel.font = [UIFont systemFontOfSize:12.0];
    [btnAlertbox setTitle:@"Alert(中间弹出带修改框)" forState:UIControlStateNormal];
    [self.view addSubview:btnAlertbox];
    [btnAlertbox addTarget:self action:@selector(btnclickAlertBox) forControlEvents:UIControlEventTouchUpInside];

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

-(void)btnClickAlartcenter{
    [ZSProgressHUD ZSAlertWithOneBtnTitle:@"Alert标题" Message:@"中间显示的Alert(带取消按钮)" BtnStr:@"确定" WithCancelBtn:YES ClickBlock:^{
        NSLog(@"确定按钮点击");
    }];
}

-(void)btnClickAlartsheet{
    [ZSProgressHUD ZSAlertWithOneSheetBtnTitle:@"Alert标题" Message:@"底部显示的Alert(带取消按钮)" BtnStr:@"确定" WithCancelBtn:YES ClickBlock:^{
       NSLog(@"确定按钮点击");
    }];
}


-(void)btnclickAlertBox{
    [ZSProgressHUD ZSAlertWithBoxBtnTitle:@"Alert标题" Message:@"中间显示的Alert(带取消按钮和修改框)" BtnStr:@"确定" WithCancelBtn:YES ClickBlock:^(NSString *str) {
        NSLog(@"修改框填写的文本 = %@",str);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
