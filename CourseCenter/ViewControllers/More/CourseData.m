//
//  CourseData.m
//  CourseCenter
//
//  Created by 2345 on 15/7/18.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "CourseData.h"
#import "FileInfo.h"
#import "DetailData.h"
@interface CourseData ()
{
    FileInfo *fileInfo;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic)CCHttpManager *httpManager;
@property (strong,nonatomic)ResponseObject *reob;
@end

@implementation CourseData

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tableView.tableFooterView=[[UIView alloc]init];
    self.httpManager = [[CCHttpManager alloc]init];
    [self mLoadData];
    
}
-(void)mLoadData
{
    [MBProgressHUD showMessage:nil];
    [self.httpManager getAppFileCountWithOCID:161 finished:^(EnumServerStatus status, NSObject *object) {
        [MBProgressHUD hideHUD];
        if (status==0) {
            self.reob=(ResponseObject *)object;
            if ([self.reob.errrorCode isEqualToString:@"0"]) {
                fileInfo=self.reob.resultObject;
                [_tableView reloadData];
                return ;
            }
        }
        [MBProgressHUD showError:LOGINMESSAGE_F];
    }];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIndentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (!cell) {
        cell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    switch (indexPath.row) {
        case 0:
            cell.imageView.image=[UIImage imageNamed:@"icon_datum1"];
            cell.textLabel.text =[NSString stringWithFormat:@"全部资料 (%d)",fileInfo.AllCount];
            break;
        case 1:
            cell.imageView.image=[UIImage imageNamed:@"icon_document"];
            cell.textLabel.text =[NSString stringWithFormat:@"文稿资料 (%d)",fileInfo.ElseCount];
            break;
        case 2:
            cell.imageView.image=[UIImage imageNamed:@"icon_photo1"];
            cell.textLabel.text =[NSString stringWithFormat:@"图片资料 (%d)",fileInfo.PicCount];
            break;
        case 3:
            cell.imageView.image=[UIImage imageNamed:@"icon_video1"];
            cell.textLabel.text =[NSString stringWithFormat:@"视频资料 (%d)",fileInfo.VideoCount];
            break;
        default:
            break;
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailData *detailData=[[DetailData alloc]init];
    [((AppDelegate *)app).nav pushViewController:detailData animated:YES];
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
