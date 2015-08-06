//
//  HWorkDetailViewController.m
//  CourseCenter
//
//  Created by muzhenhua on 15/8/5.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "HWorkDetailViewController.h"
#import "UIView1.h"
#import "UIView2.h"
#import "UIView3.h"
#import "UIView4.h"
#import "UIView5.h"
#import "UIView6.h"
#define  width _scrollerView.frame.size.width
#define height _scrollerView.frame.size.height
static CGFloat xx=0;
static CGFloat yy=0;
@interface HWorkDetailViewController ()
@property (strong,nonatomic)CCHttpManager *httpManager;
@property (strong,nonatomic)ResponseObject *reob;
@property (nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)NSMutableArray *arrayViews;
@end

@implementation HWorkDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.httpManager = [[CCHttpManager alloc]init];
    self.dataArray=[[NSMutableArray array]init];
    [self setupCustomLeftWithtitle:@"暂存" target:self action:@selector(save)];
    [self setupCustomRightWithtitle:@"提交" target:self action:@selector(submit)];
    xx=0;
    _arrayViews=[[NSMutableArray alloc]initWithObjects:
                 [[UIView1 alloc]initWithNibName:@"UIView1" bundle:nil],
                 [[UIView2 alloc]initWithNibName:@"UIView2" bundle:nil],
                 [[UIView3 alloc]initWithNibName:@"UIView3" bundle:nil],
                 [[UIView4 alloc]initWithNibName:@"UIView4" bundle:nil],
                 [[UIView5 alloc]initWithNibName:@"UIView5" bundle:nil],
                 [[UIView6 alloc]initWithNibName:@"UIView6" bundle:nil],[UIView1 new],[UIView1 new],[UIView1 new],[UIView1 new],[UIView1 new], nil];
    [_arrayViews enumerateObjectsUsingBlock:^(UIView1 *obj, NSUInteger idx, BOOL *stop) {
        obj.view.frame=CGRectMake(idx*width, 0, width, height);
        [self.scrollerView addSubview:obj.view];
    }];
}
-(void)LoadData
{
    [MBProgressHUD showMessage:nil];
    [self.httpManager getPaperInfoWithPaperID:151
                                       TestID:213 finished:^(EnumServerStatus status, NSObject *object) {
                                           [MBProgressHUD hideHUD];
                                           if (status==0) {
                                               self.reob=(ResponseObject *)object;
                                               if ([self.reob.errrorCode isEqualToString:@"0"]) {
                                                   self.dataArray=self.reob.resultArray;
                                                   return ;
                                               }
                                           }
                                           [MBProgressHUD showError:LOGINMESSAGE_F];
                                       }];
}
-(void)initScrollerView
{
    self.scrollerView.contentSize=CGSizeMake(_arrayViews.count*width, height);
}
- (IBAction)last:(UIButton *)sender {
    xx-=width;
    if (xx<0) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"第一个了" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        xx=0;
        return;
    }
    [self.scrollerView setContentOffset:CGPointMake(xx,yy) animated:YES];
    
}
- (IBAction)next:(UIButton *)sender {
    xx+=width;
    if (xx>(_arrayViews.count-1)*width) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"最后一个了" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        xx=(_arrayViews.count-1)*width;
        return;
    }
    [self.scrollerView setContentOffset:CGPointMake(xx,yy) animated:YES];
    
}
-(void)save{
    
}
-(void)submit
{
    
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
