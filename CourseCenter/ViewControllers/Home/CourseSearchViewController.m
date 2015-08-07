//
//  CourseSearchViewController.m
//  CourseCenter
//
//  Created by renxiaojian on 15/5/26.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "CourseSearchViewController.h"
#import "ResponseObject.h"
#import "SpecialtyTypeInfo.h"
#import "SubjectSearchViewController.h"
#import "SearchCoreManager.h"
@interface CourseSearchViewController ()
{
    SpecialtyTypeInfo *specialtyinfo;
    UISearchBar *mysearchBar;
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

@implementation CourseSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"课程搜索";
    [self addTableviewHeader];
    self.httpManager = [[CCHttpManager alloc]init];
    self.dataArray=[[NSMutableArray array]init];
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
    [self.httpManager getSpecialtyTypeTreeWithParentID:0 SearchKey:@"" finished:^(EnumServerStatus status, NSObject *object) {
        [MBProgressHUD hideHUD];
        if (status==0) {
            self.reob=(ResponseObject *)object;
            if ([self.reob.errrorCode isEqualToString:@"0"]) {
                [self dataHandleWithArray:self.reob.resultArray];
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
    [self.httpManager getSpecialtyTypeTreeWithParentID:0 SearchKey:searchText finished:^(EnumServerStatus status, NSObject *object) {
        [MBProgressHUD hideHUD];
        if (status==0) {
            self.reob=(ResponseObject *)object;
            if ([self.reob.errrorCode isEqualToString:@"0"]) {
                [self dataHandleWithArray:self.reob.resultArray];
                [_tableView reloadData];
                return ;
            }
        }
        [MBProgressHUD showError:LOGINMESSAGE_F];
    }];
}
- (void)addTableviewHeader
{
    mysearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 0, 40)];
    mysearchBar.placeholder = @"这里可以搜索您感兴趣的视频课程哦！";
    mysearchBar.delegate=self;
    self.tableView.tableHeaderView = mysearchBar;
    searchDC=[[UISearchDisplayController alloc]initWithSearchBar:mysearchBar contentsController:self];
    searchDC.searchResultsDataSource=self;
    searchDC.searchResultsDelegate=self;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
//    if (mysearchBar.text.length <= 0) {
//        return self.dataArray.count;
//    } else {
//        return self.searchByName.count + self.searchByPhone.count;
//    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIndentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
//    if (mysearchBar.text.length <= 0) {
//        cell.textLabel.text =((SpecialtyTypeInfo *)[_dataArray objectAtIndex:indexPath.row]).SpecialtyTypeName;
//        return cell;
//    }
//    NSNumber *localID = nil;
//    NSMutableString *matchString = [NSMutableString string];
//    NSMutableArray *matchPos = [NSMutableArray array];
//    if (indexPath.row < [_searchByName count]) {
//        localID = [self.searchByName objectAtIndex:indexPath.row];
//        
//        //姓名匹配 获取对应匹配的拼音串 及高亮位置
//        if (mysearchBar.text.length) {
//            [[SearchCoreManager share] GetPinYin:localID pinYin:matchString matchPos:matchPos];
//        }
//    }else {
//        localID = [self.searchByPhone objectAtIndex:indexPath.row-[_searchByName count]];
//        NSMutableArray *matchPhones = [NSMutableArray array];
//        
//        //号码匹配 获取对应匹配的号码串 及高亮位置
//        if ([mysearchBar.text length]) {
//            [[SearchCoreManager share] GetPhoneNum:localID phone:matchPhones matchPos:matchPos];
//            [matchString appendString:[matchPhones objectAtIndex:0]];
//        }
//    }
//    SpecialtyTypeInfo  *info = [self.contactDic objectForKey:localID];
//    cell.textLabel.text =info.SpecialtyTypeName;
    cell.textLabel.text =((SpecialtyTypeInfo *)[_dataArray objectAtIndex:indexPath.row]).SpecialtyTypeName;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSInteger number=tableView==_tableView?indexPath.row:[self.searchByName[indexPath.row] integerValue];
    NSInteger number=indexPath.row;
    SubjectSearchViewController *subjectSearchVC = [SubjectSearchViewController new];
    subjectSearchVC.title=((SpecialtyTypeInfo *)[_dataArray objectAtIndex:number]).SpecialtyTypeName;
    subjectSearchVC.SpecialtyTypeID=((SpecialtyTypeInfo *)[_dataArray objectAtIndex:number]).SpecialtyTypeID;
    
    [((AppDelegate *)app).nav pushViewController:subjectSearchVC animated:YES];
}
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    _dataArray=nil;
    searchBar.showsCancelButton=YES;
    searchString=searchText;
//    [[SearchCoreManager share] Search:searchText searchArray:nil nameMatch:_searchByName phoneMatch:nil];
    
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self searchLoadData:searchString];
}
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self loadData];
}
-(void)dataHandleWithArray:(NSMutableArray *)array
{
    self.dataArray=array;
//    for (int i=0; i<array.count; i++) {
//        ((SpecialtyTypeInfo *)array[i]).SearchID=[NSNumber numberWithInt:i];
//        [self.dataArray addObject:((SpecialtyTypeInfo *)array[i])];
//    }
//    for (int j = 0; j < self.dataArray.count; j ++) {
//        [[SearchCoreManager share] AddContact:((SpecialtyTypeInfo *)array[j]).SearchID name:((SpecialtyTypeInfo *)array[j]).SpecialtyTypeName phone:nil];
//        [self.contactDic setObject:((SpecialtyTypeInfo *)array[j]) forKey:((SpecialtyTypeInfo *)array[j]).SearchID];
//    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
@end
