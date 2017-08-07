# ZSProgressHUDDemo
一个超简单的活动指示器。适配横屏,一句代码搞定

![image](https://raw.githubusercontent.com/Roshanzs/ZSProgressHUDDemo/master/ZSProgressHUDDemo.gif)

```
真正的一行代码调用,简单快速
```
###代码导入
* 一 , 导入`ZSProgressHUD`文件夹到你的项目中 (文件夹在 Demo 中可以找到)
* 二 , 在你需要使用的 viewController 中，`#import "ZSProgressHUD.h"`;
* 三 , 在需要显示的位置敲入代码即可
````
[ZSProgressHUD showMessage:@"文字显示"];

[ZSProgressHUD showInfo:@"提示消息"];

[ZSProgressHUD showNet:@"网络等待"];

[ZSProgressHUD showSuccess:@"成功"];

[ZSProgressHUD showSuccess:@"失败"];

````

*其中进度显示的需要传一个进度值(0.0 ~ 1.0)

````
MBProgressHUD *p = [ZSProgressHUD showProgressCircle:@"进度"];

p.progress = 0.2;

````

*手动隐藏
````
[ZSProgressHUD hide];

````

*此外ZSProgressHUD还提供了Alert显示

用法同上

````
[ZSProgressHUD ZSAlertWithOneBtnTitle:@"Alert标题" Message:@"中间显示的Alert(带取消按钮)" BtnStr:@"确定" WithCancelBtn:YES ClickBlock:^{
        NSLog(@"确定按钮点击");
    }];
    
[ZSProgressHUD ZSAlertWithOneSheetBtnTitle:@"Alert标题" Message:@"底部显示的Alert(带取消按钮)" BtnStr:@"确定" WithCancelBtn:YES ClickBlock:^{
       NSLog(@"确定按钮点击");
    }];

[ZSProgressHUD ZSAlertWithBoxBtnTitle:@"Alert标题" Message:@"中间显示的Alert(带取消按钮和修改框)" BtnStr:@"确定" WithCancelBtn:YES ClickBlock:^(NSString *str) {
        NSLog(@"修改框填写的文本 = %@",str);
    }];
    
````

*是不是超级简单方便了  哈哈!

## 提示 Tips

* HUD 是添加到当前最上层的的 window 上而不是当前的 view 上，若实在需要可以去 ZSProgressHUD 中修改。

* 加载的图片在bundle文件夹下面，可自由更换，注意把名字改成我一样的即可。（当然你也可以去改代码，不嫌麻烦的话）

* 指示器显示的文字颜色大小都可以去ZSProgressHUD.m中修改


## 如果好用给个Star吧

* 发现问题请 Issue，谢谢:-)

* Mail: roshanzs@163.com

* Blog: http://www.qibaoyouwu.com
