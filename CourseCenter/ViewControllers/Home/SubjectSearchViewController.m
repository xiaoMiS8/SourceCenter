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
@interface SubjectSearchViewController ()
{
    OCourseInfo *oCource;
    UISearchBar *mySearchBar;
    UISearchDisplayController *searchDC;
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
    self.KeywordArray=[[NSMutableArray array]init];
    [self loadData];
}
-(void)loadData
{
    [self.httpManager getOCAllListWithSpecialtyTypeID:self.SpecialtyTypeID key:nil PageIndex:1 PageSize:INT_MAX finished:^(EnumServerStatus status, NSObject *object) {
        if (status==0) {
            self.reob=(ResponseObject *)object;
            if ([self.reob.errrorCode isEqualToString:@"0"]) {
                self.dataArray=self.reob.resultArray;
                [_tableView reloadData];
            }
        }
    }];
}
- (void)addTableviewHeader
{
    mySearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 0, 40)];
    mySearchBar.placeholder = @"这里可以搜索您感兴趣的视频课程哦！";
    mySearchBar.delegate=self;
    mySearchBar.showsCancelButton=YES;
    self.tableView.tableHeaderView = mySearchBar;
    searchDC=[[UISearchDisplayController alloc]initWithSearchBar:mySearchBar contentsController:self];
    searchDC.searchResultsDataSource=self;
    searchDC.searchResultsDelegate=self;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger count= tableView==_tableView? self.dataArray.count: self.dataResult.count;
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SubjectSearchCell *cell=[_tableView dequeueReusableCellWithIdentifier:@"SubjectSearchCell"];
    OCourseInfo *oCourse=tableView==_tableView?[self.dataArray objectAtIndex:indexPath.row]:[self.dataResult objectAtIndex:indexPath.row];
    cell.oCourse=oCourse;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeDetailViewController *homeDetailVc = [[HomeDetailViewController alloc]init];
    homeDetailVc.OCID=1;//((OCourse *)[self.dataArray objectAtIndex:indexPath.row]).OCID;
    homeDetailVc.teacherImgUrl=((OCourseInfo *)[self.dataArray objectAtIndex:indexPath.row]).TeacherImgUrl;
    [((AppDelegate *)app).nav pushViewController:homeDetailVc animated:YES];
}
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (self.dataResult==nil) {
        self.dataResult=[[NSMutableArray alloc]init];
        
    }
    [self.dataResult removeAllObjects];
    //NSPredicate *predicate=[NSPredicate predicateWithFormat:@"OrganizationName==测试机构"];
    for (OCourseInfo *info in self.dataArray) {
        if ([((OCourseInfo *)self.dataArray).OrganizationName rangeOfString:searchBar.text].location != NSNotFound) {
            
            [self.dataResult addObject:info];
            
        }
//        if ([predicate evaluateWithObject:info]) {
//            [self.dataArray addObject:info];
//        }
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
