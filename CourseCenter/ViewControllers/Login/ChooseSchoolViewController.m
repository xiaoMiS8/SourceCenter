//
//  ChooseSchoolViewController.m
//  CourseCenter
//
//  Created by muzhenhua on 15/8/28.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "ChooseSchoolViewController.h"
#import "SchoolInfo.h"
@interface ChooseSchoolViewController ()
{
    UISearchBar *mySearchBar;
    UISearchDisplayController *searchDC;
    NSInteger selectNumber;
    BOOL isTableView;
    NSInteger resultRow;
    
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic, strong) CCHttpManager * httpManager;
@property(nonatomic, strong) ResponseObject *reob;
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,strong)NSMutableArray *dataResult;

@end

@implementation ChooseSchoolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"请选择您所在的学校";
    [self setupCustomRightWithtitle:@"确定" target:self action:@selector(chooseSchool)];
    [self addTableviewHeader];
    self.tableView.tableFooterView=[[UIView alloc]init];
    self.httpManager = [[CCHttpManager alloc]init];
    self.dataArray=[[NSMutableArray array]init];
    self.dataResult=[[NSMutableArray alloc]init];
    selectNumber=INT_MAX;
    [self LoadDataWithKey:@"" isTableView:YES];
}

- (void)addTableviewHeader
{
    mySearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 64,Swidth, 40)];
    mySearchBar.placeholder = @"输入学校和关键字来搜索";
    mySearchBar.delegate=self;
    mySearchBar.showsCancelButton=NO;
    self.tableView.tableHeaderView = mySearchBar;
    searchDC=[[UISearchDisplayController alloc]initWithSearchBar:mySearchBar contentsController:self];
    searchDC.searchResultsDataSource=self;
    searchDC.searchResultsDelegate=self;
    searchDC.searchResultsTableView.tableFooterView=[[UIView alloc]init];
}

-(void)LoadDataWithKey:(NSString *)string isTableView:(BOOL)isTV
{
    [MBProgressHUD showMessage:nil];
    [self.httpManager chooseSchoolWithOpt:@"getschool"
      key:string finished:^(EnumServerStatus status, NSObject *object) {
            [MBProgressHUD hideHUD];
        if (status==0) {
        self.reob=(ResponseObject *)object;
        if (isTV) {
        self.dataArray=self.reob.resultArray;
            isTableView=YES;
            [_tableView reloadData];
            }else
        {
            self.dataResult=self.reob.resultArray;
            isTableView=NO;
        [searchDC.searchResultsTableView reloadData];
                                              }
            return ;
            }
        [MBProgressHUD showError:LOGINMESSAGE_F];
   }];
}


-(void)chooseSchool
{
    if (selectNumber!=INT_MAX) {
        if (isTableView) {
            [[NSUserDefaults standardUserDefaults]setObject:((SchoolInfo *)_dataArray[selectNumber]).Url forKey:@"schoolUrl"];
        }else
        {
            [[NSUserDefaults standardUserDefaults]setObject:((SchoolInfo *)_dataResult[selectNumber]).Url forKey:@"schoolUrl"];
        }
        [self.navigationController popViewControllerAnimated:YES];
    }else
    {
        [Tool showAlertView:@"提示" withMessage:@"请选择学校!" withTarget:self withCancel:@"确定" other:nil];
    }

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView==self.tableView) {
        return _dataArray.count;
    }else
    {
        return _dataResult.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIndentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    if (tableView==self.tableView) {
        cell.textLabel.text = [NSString stringWithFormat:@"%@",((SchoolInfo *)_dataArray[indexPath.row]).Schoolname];
    }else
    {
        cell.textLabel.text = [NSString stringWithFormat:@"%@",((SchoolInfo *)_dataResult[indexPath.row]).Schoolname];
    }
    if (selectNumber==indexPath.row) {
        cell.accessoryType=UITableViewCellAccessoryCheckmark;
    }else
    {
        cell.accessoryType=UITableViewCellAccessoryNone;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==_tableView) {
        selectNumber=indexPath.row;
        [tableView reloadData];
    }else
    {
        for (int i=0;i<_dataArray.count;i++) {
            if ([((SchoolInfo *)_dataArray[i]).Schoolname isEqualToString:((SchoolInfo *)_dataResult[indexPath.row]).Schoolname] ) {
                resultRow=i;
                selectNumber=indexPath.row;
                [tableView reloadData];
                break;
            }
        }
        
    }
    
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self LoadDataWithKey:mySearchBar.text isTableView:NO];
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    selectNumber=resultRow;
    [_tableView reloadData];
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
