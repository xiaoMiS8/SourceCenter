//
//  SubjectSearchViewController.m
//  CourseCenter
//
//  Created by 2345 on 15/6/30.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "SubjectSearchViewController.h"
#import "SubjectSearchCell.h"
#import "ResponseObject.h"
#import "HomeDetailViewController.h"
#import "OCourseInfo.h"
#import "SearchCoreManager.h"
@interface SubjectSearchViewController ()
{
    OCourseInfo *oCource;
    UISearchBar *mySearchBar;
    UISearchDisplayController *searchDC;
    NSString *searchString;
}
@property (strong,nonatomic)CCHttpManager *httpManager;
@property (strong,nonatomic)ResponseObject *reob;
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,strong)NSMutableArray *KeywordArray;
@property (nonatomic,strong)NSMutableArray *dataResult;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation SubjectSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.tableView registerNib:[UINib nibWithNibName:@"SubjectSearchCell" bundle:nil] forCellReuseIdentifier:@"SubjectSearchCell"];
    [self addTableviewHeader];
    self.httpManager = [[CCHttpManager alloc]init];
    self.dataArray=[[NSMutableArray array]init];
    self.dataResult=[[NSMutableArray alloc]init];
    self.KeywordArray=[[NSMutableArray array]init];
    self.contactDic = [[NSMutableDictionary alloc] init];
    self.searchByName = [[NSMutableArray alloc] init];
    self.searchByPhone = [[NSMutableArray alloc] init];
    self.tableView.tableFooterView=[[UIView alloc]init];
    [self loadData];
}
-(void)loadData
{
    [MBProgressHUD showMessage:nil];
    [self.httpManager getOCAllListWithSpecialtyTypeID:self.SpecialtyTypeID key:nil PageIndex:1 PageSize:INT_MAX finished:^(EnumServerStatus status, NSObject *object) {
        [MBProgressHUD hideHUD];
        if (status==0) {
            self.reob=(ResponseObject *)object;
            if ([self.reob.errrorCode isEqualToString:@"0"]) {
                self.dataArray=self.reob.resultArray;
              //[self dataHandleWithArray:self.reob.resultArray];
                [_tableView reloadData];
                return ;
            }
        }
        [MBProgressHUD showError:LOGINMESSAGE_F];
    }];
}
-(void)searchLoadData:(NSString *)searchText
{
    [MBProgressHUD showMessage:nil];
    [self.httpManager getOCAllListWithSpecialtyTypeID:self.SpecialtyTypeID key:searchText PageIndex:1 PageSize:INT_MAX finished:^(EnumServerStatus status, NSObject *object) {
        [MBProgressHUD hideHUD];
        if (status==0) {
            self.reob=(ResponseObject *)object;
            if ([self.reob.errrorCode isEqualToString:@"0"]) {
                self.dataResult=self.reob.resultArray;
              //[self dataHandleWithArray:self.reob.resultArray];
                [searchDC.searchResultsTableView reloadData];
                return ;
            }
        }
        [MBProgressHUD showError:LOGINMESSAGE_F];
    }];
}
- (void)addTableviewHeader
{
    mySearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 0, 40)];
    mySearchBar.placeholder = @"这里可以搜索您感兴趣的视频课程哦！";
    mySearchBar.delegate=self;
    self.tableView.tableHeaderView = mySearchBar;
    searchDC=[[UISearchDisplayController alloc]initWithSearchBar:mySearchBar contentsController:self];
    searchDC.searchResultsDataSource=self;
    searchDC.searchResultsDelegate=self;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView==self.tableView) {
        return self.dataArray.count;
    } else {
        return self.dataResult.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SubjectSearchCell *cell=[_tableView dequeueReusableCellWithIdentifier:@"SubjectSearchCell"];
//    if (mySearchBar.text.length <= 0) {
//        cell.oCourse=((OCourseInfo *)[self.dataArray objectAtIndex:indexPath.row]);
//        return cell;
//    }
//    NSNumber *localID = nil;
//    NSMutableString *matchString = [NSMutableString string];
//    NSMutableArray *matchPos = [NSMutableArray array];
//    if (indexPath.row < [_searchByName count]) {
//        localID = [self.searchByName objectAtIndex:indexPath.row];
//        
//        //姓名匹配 获取对应匹配的拼音串 及高亮位置
//        if (mySearchBar.text.length) {
//            [[SearchCoreManager share] GetPinYin:localID pinYin:matchString matchPos:matchPos];
//        }
//    }else {
//        localID = [self.searchByPhone objectAtIndex:indexPath.row-[_searchByName count]];
//        NSMutableArray *matchPhones = [NSMutableArray array];
//        
//        //号码匹配 获取对应匹配的号码串 及高亮位置
//        if ([mySearchBar.text length]) {
//            [[SearchCoreManager share] GetPhoneNum:localID phone:matchPhones matchPos:matchPos];
//            [matchString appendString:[matchPhones objectAtIndex:0]];
//        }
//    }
//    OCourseInfo *oCourse = [self.contactDic objectForKey:localID];
//    cell.oCourse=oCourse;
//    return cell;
    if (tableView==self.tableView) {
        cell.oCourse=((OCourseInfo *)[self.dataArray objectAtIndex:indexPath.row]);
        return cell;
    } else {
        cell.oCourse=((OCourseInfo *)[self.dataResult objectAtIndex:indexPath.row]);
        return cell;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSInteger number=tableView==_tableView?indexPath.row:[self.searchByName[indexPath.row] integerValue];
    NSInteger number=indexPath.row;
    HomeDetailViewController *homeDetailVc = [[HomeDetailViewController alloc]init];
    homeDetailVc.OCID=((OCourseInfo *)[self.dataArray objectAtIndex:number]).OCID;
    homeDetailVc.teacherImgUrl=((OCourseInfo *)[self.dataArray objectAtIndex:number]).TeacherImgUrl;
    homeDetailVc.topImgUrl=((OCourseInfo *)[self.dataArray objectAtIndex:indexPath.row]).CourseImgUrl;
    homeDetailVc.RegStatus=((OCourseInfo *)[self.dataArray objectAtIndex:indexPath.row]).RegStatus;
    [((AppDelegate *)app).nav pushViewController:homeDetailVc animated:YES];
}
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    _dataArray=nil;
    searchBar.showsCancelButton=YES;
    searchString=searchText;
//    [[SearchCoreManager share] Search:searchText searchArray:nil nameMatch:_searchByName phoneMatch:nil];
//    [self.tableView reloadData];
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self searchLoadData:searchString];
}
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self loadData];
}
//-(void)dataHandleWithArray:(NSMutableArray *)array
//{
//    for (int i=0; i<array.count; i++) {
//        ((OCourseInfo *)array[i]).SearchID=[NSNumber numberWithInt:i];
//        [self.dataArray addObject:((OCourseInfo *)array[i])];
//    }
//    for (int j = 0; j < self.dataArray.count; j ++) {
//        [[SearchCoreManager share] AddContact:((OCourseInfo *)array[j]).SearchID name:((OCourseInfo *)array[j]).OrganizationName phone:nil];
//        [self.contactDic setObject:((OCourseInfo *)array[j]) forKey:((OCourseInfo *)array[j]).SearchID];
//    }
//}
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
