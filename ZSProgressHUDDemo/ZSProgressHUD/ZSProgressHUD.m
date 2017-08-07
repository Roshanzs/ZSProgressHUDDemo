//
//  ZSShowViewTools.m
//  Enjoy-Booking
//
//  Created by 紫贝壳 on 2017/1/6.
//  Copyright © 2017年 tony. All rights reserved.
//

#import "ZSProgressHUD.h"

typedef enum{
    ZSMBProgressHUDOnlyText = 0,
    ZSMBProgressHUDOnlyInfo,
    ZSMBProgressHUDOnlyLoading ,
    ZSMBProgressHUDOnlyCircleLoading,
    ZSMBProgressHUDOnlySuccess ,
    ZSMBProgressHUDOnlyError
}StatusMode;

@interface ZSProgressHUD ()
@property(nonatomic,strong)MBProgressHUD *mbp;
@end

#define HSCREEN [UIScreen mainScreen].bounds.size.height
@implementation ZSProgressHUD

+(instancetype)share{
    static ZSProgressHUD *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[ZSProgressHUD alloc] init];
    });
    return instance;
}

+(void)showMessage:(NSString *)msg WithMode:(StatusMode)mode{
    
    UIWindow *view = [self lastWindow];
    
    if ([ZSProgressHUD share].mbp != nil) {
        [[ZSProgressHUD share].mbp hideAnimated:YES];
        [ZSProgressHUD share].mbp = nil;
    }
    
    [ZSProgressHUD share].mbp = [MBProgressHUD showHUDAddedTo:view animated:YES];
    [ZSProgressHUD share].mbp.bezelView.color = [UIColor grayColor];
    [ZSProgressHUD share].mbp.bezelView.alpha = 0.8;
    [ZSProgressHUD share].mbp.contentColor = [UIColor whiteColor];
    [[ZSProgressHUD share].mbp setMargin:30];
    [ZSProgressHUD share].mbp.label.numberOfLines = 0;
    [[ZSProgressHUD share].mbp setRemoveFromSuperViewOnHide:YES];
    [ZSProgressHUD share].mbp.detailsLabel.text = msg;
    [ZSProgressHUD share].mbp.detailsLabel.font = [UIFont systemFontOfSize:14.0/667.0*HSCREEN];
    switch ((NSInteger)mode) {
        case ZSMBProgressHUDOnlyText:
            [ZSProgressHUD share].mbp.mode = MBProgressHUDModeText;
            break;
            
        case ZSMBProgressHUDOnlyLoading:
            [ZSProgressHUD share].mbp.mode = MBProgressHUDModeIndeterminate;
            break;
            
        case ZSMBProgressHUDOnlyCircleLoading:{
            [ZSProgressHUD share].mbp.mode = MBProgressHUDModeDeterminate;
            break;
        }
        case ZSMBProgressHUDOnlyInfo:{
            [ZSProgressHUD share].mbp.mode = MBProgressHUDModeCustomView;
            [ZSProgressHUD getCustomViewWithImgStr:@"hud_info@2x.png"];
            break;
        }
        case ZSMBProgressHUDOnlyError:{
            [ZSProgressHUD share].mbp.mode = MBProgressHUDModeCustomView;
            [ZSProgressHUD getCustomViewWithImgStr:@"hud_error@2x.png"];
            break;
        }
        case ZSMBProgressHUDOnlySuccess:
            [ZSProgressHUD share].mbp.mode = MBProgressHUDModeCustomView;
            [ZSProgressHUD getCustomViewWithImgStr:@"hud_success@2x"];
            break;
            
        default:
            break;
    }
}

+(void)getCustomViewWithImgStr:(NSString *)str{
    [ZSProgressHUD share].mbp.customView = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:[[[NSBundle mainBundle] pathForResource:@"ZSProgressHUD" ofType:@"bundle"] stringByAppendingPathComponent:str]]];
}

+(void)showInfo:(NSString *)msg{
    [self showMessage:msg WithMode:ZSMBProgressHUDOnlyInfo];
    [[ZSProgressHUD share].mbp hideAnimated:YES afterDelay:1.0];
}

+(void)showMessage:(NSString *)msg{
    [self showMessage:msg WithMode:ZSMBProgressHUDOnlyText];
    [[ZSProgressHUD share].mbp hideAnimated:YES afterDelay:1.0];
}

+(void)showMessage:(NSString *)msg WithAfterDelay:(NSTimeInterval)delay{
    [self showMessage:msg WithMode:ZSMBProgressHUDOnlyText];
    [[ZSProgressHUD share].mbp hideAnimated:YES afterDelay:delay];
}

+(void)showNet:(NSString *)msg{
    [self showMessage:msg WithMode:ZSMBProgressHUDOnlyLoading];
}

+(void)showSuccess:(NSString *)msg{
    [self showMessage:msg WithMode:ZSMBProgressHUDOnlySuccess];
    [[ZSProgressHUD share].mbp hideAnimated:YES afterDelay:1.0];
}

+(void)showError:(NSString *)msg{
    [self showMessage:msg WithMode:ZSMBProgressHUDOnlyError];
    [[ZSProgressHUD share].mbp hideAnimated:YES afterDelay:1.0];
}

+(MBProgressHUD *)showProgressCircle:(NSString *)msg{
    UIView *view = (UIView*)[UIApplication sharedApplication].delegate.window;
    [ZSProgressHUD share].mbp = [MBProgressHUD showHUDAddedTo:view animated:YES];
    [ZSProgressHUD share].mbp.mode = MBProgressHUDModeAnnularDeterminate;
    [ZSProgressHUD share].mbp.label.text = msg;
    return [ZSProgressHUD share].mbp;
}

+(void)hide{
    if ([ZSProgressHUD share].mbp != nil) {
        [[ZSProgressHUD share].mbp hideAnimated:YES];
    }
}


//中间一个按钮
+(void)ZSAlertWithOneBtnTitle:(NSString *)title Message:(NSString *)message BtnStr:(NSString *)Btnstr WithCancelBtn:(BOOL)cancelbtn ClickBlock:(void(^)())btnClickBlock{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:Btnstr style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        btnClickBlock();
    }];
    [alert addAction:action];
    
    if (cancelbtn) {
        UIAlertAction *Cancelaction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:Cancelaction];
    }
    //获取到窗口最上层的viewcontroller
    UIWindow *view = [self lastWindow];
    [view.rootViewController presentViewController:alert animated:YES completion:^{
    }];
}


//底部一个按钮
+(void)ZSAlertWithOneSheetBtnTitle:(NSString *)title Message:(NSString *)message BtnStr:(NSString *)Btnstr WithCancelBtn:(BOOL)cancelbtn ClickBlock:(void(^)())btnClickBlock{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action = [UIAlertAction actionWithTitle:Btnstr style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        btnClickBlock();
    }];
    [alert addAction:action];
    
    if (cancelbtn) {
        UIAlertAction *Cancelaction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:Cancelaction];
    }
    
    //获取到窗口最上层的viewcontroller
    UIWindow *view = [self lastWindow];
    [view.rootViewController presentViewController:alert animated:YES completion:^{
    }];
}

//中间弹框修改框
+(void)ZSAlertWithBoxBtnTitle:(NSString *)title Message:(NSString *)message BtnStr:(NSString *)Btnstr WithCancelBtn:(BOOL)cancelbtn ClickBlock:(void(^)(NSString * str))btnClickBlock{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = [NSString stringWithFormat:@"请输入新的%@",title];
    }];
    UIAlertAction *action = [UIAlertAction actionWithTitle:Btnstr style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        btnClickBlock(alert.textFields.firstObject.text);
    }];
    [alert addAction:action];
    
    if (cancelbtn) {
        UIAlertAction *Cancelaction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:Cancelaction];
    }
    
    //获取到窗口最上层的viewcontroller
    UIWindow *view = [self lastWindow];
    [view.rootViewController presentViewController:alert animated:YES completion:^{
    }];
}



+ (UIWindow *)lastWindow
{
    NSArray *windows = [UIApplication sharedApplication].windows;
    for(UIWindow *window in [windows reverseObjectEnumerator]) {
        
        if ([window isKindOfClass:[UIWindow class]] &&
            CGRectEqualToRect(window.bounds, [UIScreen mainScreen].bounds))
            
            return window;
    }
    
    return [UIApplication sharedApplication].keyWindow;
}



@end
