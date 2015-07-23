//
//  DetailData.m
//  CourseCenter
//
//  Created by 2345 on 15/7/19.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "DetailData.h"
#import "DetailDataCell.h"
@interface DetailData ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic)CCHttpManager *httpManager;
@property (strong,nonatomic)ResponseObject *reob;
@end

@implementation DetailData

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.tableView registerNib:[UINib nibWithNibName:@"DetailDataCell" bundle:nil] forCellReuseIdentifier:@"DetailDataCell"];
}
//-(void)kLoadData
//{
//    [MBProgressHUD showMessage:nil];
//    [self.httpManager getAppOCNameListWithrole:1 IsHistroy:NO finished:^(EnumServerStatus status, NSObject *object) {
//        [MBProgressHUD hideHUD];
//        if (status==0) {
//            self.reob=(ResponseObject *)object;
//            if ([self.reob.errrorCode isEqualToString:@"0"]) {
//                self.dataArray=self.reob.resultArray;
//                [_tableView reloadData];
//                return ;
//            }
//        }
//        [MBProgressHUD showError:LOGINMESSAGE_F];
//    }];
//}
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
