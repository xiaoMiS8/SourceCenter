//
//  ApplyViewController.m
//  CourseCenter
//
//  Created by 2345 on 15/8/1.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "ApplyViewController.h"
#import "NSString+HandleString.h"
@interface ApplyViewController ()
{
    UISegmentedControl *myseg;
    UILabel *label;
}
@property(nonatomic,assign) NSInteger myrow;
@property(nonatomic, strong)CCHttpManager *httpManager;
@property (strong,nonatomic)ResponseObject *reob;
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,strong)RecruitInfo *info;
@end

@implementation ApplyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupCustomRightWithtitle:@"确定" target:self action:@selector(sure)];
    _myrow=100000;
    self.httpManager = [[CCHttpManager alloc]init];
    self.dataArray=[[NSMutableArray array]init];
    NSArray *array = @[@"教学班注册",@"网络班注册"];
    myseg = [[UISegmentedControl alloc] initWithItems:array];
    myseg.selectedSegmentIndex = 0;
    myseg.bounds = CGRectMake(0, 0, 160, 30);
    self.navigationItem.titleView =myseg;
    [myseg addTarget:self action:@selector(segValueChange:) forControlEvents:UIControlEventValueChanged];
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, Swidth, 40)];
    label=[[UILabel alloc]initWithFrame:CGRectMake(-1, -1, Swidth+2, 40)];
    label.layer.borderColor=[UIColor grayColor].CGColor;
    label.layer.borderWidth=1;
    label.font=[UIFont systemFontOfSize:14];
    label.numberOfLines=0;
    label.textAlignment=NSTextAlignmentCenter;
    [view addSubview:label];
    _tableView.tableHeaderView=view;
    _tableView.tableFooterView=[[UIView alloc]init];
    [self segValueChange:0];
}
-(void)LoadData
{
    [MBProgressHUD showMessage:nil];
    [self.httpManager getOCMoocRecruitCanListWithOCID:(long)self.OCID finished:^(EnumServerStatus status, NSObject *object) {
        [MBProgressHUD hideHUD];
        if (status==0) {
            self.reob=(ResponseObject *)object;
            if ([self.reob.errrorCode isEqualToString:@"0"]) {
                self.dataArray=self.reob.resultArray;
                if (_dataArray.count==0) {
                   label.text=@"暂无网络招生班级";
                }else
                {
                  label.text=@"请选择网络招生班级,点击下方注册按钮报名:";
                }
                [_tableView reloadData];
                return ;
            }
        }
        [MBProgressHUD showError:LOGINMESSAGE_F];
    }];
}
- (void)segValueChange:(UISegmentedControl *)seg {
    if (seg.selectedSegmentIndex == 0) {
        _tableView.hidden=YES;
        _titleL.hidden=NO;
        _textF.hidden=NO;
    }
    else {
        _tableView.hidden=NO;
        _titleL.hidden=YES;
        _textF.hidden=YES;
        [self LoadData];
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIndentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
  if (!cell) {
    cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIndentifier];
    UILabel *lable=[[UILabel alloc]initWithFrame:CGRectMake(0, 0,80, cell.frame.size.height)];
    lable.textAlignment=NSTextAlignmentRight;
      if (((RecruitInfo *)[_dataArray objectAtIndex:indexPath.row]).UserLimit==0) {
      lable.text=[NSString stringWithFormat:@"%@",@"不限"];
      }else
      {
      lable.text=[NSString stringWithFormat:@"%d/%d",((RecruitInfo *)[_dataArray objectAtIndex:indexPath.row]).InReadStudentNum,((RecruitInfo *)[_dataArray objectAtIndex:indexPath.row]).UserLimit];
      }
    cell.accessoryView=lable;
   }
    if (_myrow!=100000) {
        if (_myrow==indexPath.row) {
           cell.imageView.image=[UIImage imageNamed:@"btn_confirm_hover"];
        }else
        {
         cell.imageView.image=[UIImage imageNamed:@"btn_confirm"];
        }
    }else
    {
    cell.imageView.image=[UIImage imageNamed:@"btn_confirm"];
    }
    cell.textLabel.text =((RecruitInfo *)[_dataArray objectAtIndex:indexPath.row]).ClassName;
    cell.textLabel.font=Font_14;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_myrow!=indexPath.row) {
        _myrow=indexPath.row;
        [_tableView reloadData];
    }
}
-(void)sure
{
    if (myseg.selectedSegmentIndex==0) {
        if ([_textF.text isNull]) {
            [MBProgressHUD showError:REGISTERROR2];
        }else
        {
            [MBProgressHUD showMessage:nil];
            [self.httpManager OCRegisterWithRegNum:(NSString *)_textF.text OCID:self.OCID  finished:^(EnumServerStatus status, NSObject *object) {
                [MBProgressHUD hideHUD];
                if (status==0) {
                    self.reob=(ResponseObject *)object;
                    if ([self.reob.errrorCode isEqualToString:@"0"]) {
                        [MBProgressHUD showSuccess:REGISTSUCCESS];
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"registsuccess" object:nil];
                        if (self.block) {
                            self.block();
                        }
                        [self.navigationController popViewControllerAnimated:YES];
                        return ;
                    }else{
                        [MBProgressHUD showError:self.reob.errorMessage];
                        return ;
                    }
                }
                [MBProgressHUD showError:LOGINMESSAGE_F];
            }];
        }
        
    }else
    {
        if (_myrow==100000) {
            if (self.block) {
                self.block();
            }
            [self.navigationController popViewControllerAnimated:YES];
          [MBProgressHUD showError:REGISTERROR1];
        }else
        {
            NSInteger reid=((RecruitInfo *)[_dataArray objectAtIndex:_myrow]).RecruitID;
            [MBProgressHUD showMessage:nil];
            [self.httpManager jsonOCMoocRecruitClassWithRecruitID:(long)reid finished:^(EnumServerStatus status, NSObject *object) {
                [MBProgressHUD hideHUD];
                if (status==0) {
                    self.reob=(ResponseObject *)object;
                    if ([self.reob.errrorCode isEqualToString:@"0"]) {
                        [MBProgressHUD showSuccess:REGISTSUCCESS];
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"registsuccess" object:nil];
                        if (self.block) {
                            self.block();
                        }
                        [self.navigationController popViewControllerAnimated:YES];
                        return ;
                    }else{
                        [MBProgressHUD showError:self.reob.errorMessage];
                        return ;
                    }
                }
                [MBProgressHUD showError:LOGINMESSAGE_F];
            }];
        }
    }
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
