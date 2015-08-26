//
//  HWorkDetailWebViewController.m
//  CourseCenter
//
//  Created by muzhenhua on 15/8/26.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "HWorkDetailWebViewController.h"

@interface HWorkDetailWebViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property(nonatomic, strong)CCHttpManager *httpManager;
@property (strong,nonatomic)ResponseObject *reob;
@end

@implementation HWorkDetailWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"作业";
    self.httpManager = [[CCHttpManager alloc]init];
    [self setupCustomRightWithtitle:@"提交" target:self action:@selector(submit)];
     [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]]];
}
-(void)submit
{
    [MBProgressHUD showMessage:nil];
    [self.httpManager SubmitTestWithTestID:_TestID
     Answer:@"wshgkjqbwhfbxlfrh_b2" finished:^(EnumServerStatus status, NSObject *object) {
        [MBProgressHUD hideHUD];
        if (status==0) {
            self.reob=(ResponseObject *)object;
            if ([self.reob.errrorCode isEqualToString:@"0"]) {
                [MBProgressHUD showSuccess:@"作业提交成功!"];
                [self.navigationController popViewControllerAnimated:YES];
                return ;
            }
        }
        [MBProgressHUD showError:LOGINMESSAGE_F];
    }];
}
#pragma mark - WebViewDelegate delegate
-(void)webViewDidStartLoad:(UIWebView *)webView{
    
    [MBProgressHUD showMessage:nil];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    
    [MBProgressHUD hideHUD];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [MBProgressHUD hideHUD];
    [MBProgressHUD showError:LOGINMESSAGE_F];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
