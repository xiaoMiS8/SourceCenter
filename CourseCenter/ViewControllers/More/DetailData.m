//
//  DetailData.m
//  CourseCenter
//
//  Created by 2345 on 15/7/19.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "DetailData.h"
#import "DetailDataCell.h"
#import "FileInfo.h"
@interface DetailData ()
{
    FileInfo *fileInfo;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic)CCHttpManager *httpManager;
@property (strong,nonatomic)ResponseObject *reob;
@property (strong,nonatomic)NSMutableArray *dataArray;
@end

@implementation DetailData

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.tableView registerNib:[UINib nibWithNibName:@"DetailDataCell" bundle:nil] forCellReuseIdentifier:@"DetailDataCell"];
     self.httpManager = [[CCHttpManager alloc]init];
    self.dataArray = [[NSMutableArray alloc]init];
    [self kLoadData];
}
-(void)kLoadData
{
    [MBProgressHUD showMessage:nil];
    [self.httpManager getAppFileSearchwithSearchkey:nil OCID:161 FileType:1 PageIndex:1 PageSize:10 finished:^(EnumServerStatus status, NSObject *object) {
        [MBProgressHUD hideHUD];
        if (status==0) {
            self.reob=(ResponseObject *)object;
            if ([self.reob.errrorCode isEqualToString:@"0"]) {
                self.dataArray=self.reob.resultArray;
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
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailDataCell *cell=[_tableView dequeueReusableCellWithIdentifier:@"DetailDataCell"];
    cell.fileInfo=[_dataArray objectAtIndex:indexPath.row];
    return cell;
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
