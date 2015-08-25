//
//  ViewController.m
//  CourseCenter
//
//  Created by renxiaojian on 15/5/26.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "ViewController.h"
#import "SchoolInfo.h"
@interface ViewController ()
{
    UISearchBar *mySearchBar;
    UISearchDisplayController *searchDC;

}
@property(nonatomic, strong) CCHttpManager * httpManager;
@property(nonatomic, strong) ResponseObject *reob;
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *dataResult;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addTableviewHeader];
    self.httpManager = [[CCHttpManager alloc]init];
    self.dataArray=[[NSMutableArray array]init];
    self.dataResult=[[NSMutableArray alloc]init];
    [self LoadDataWithKey:@""];
}
- (void)addTableviewHeader
{
    mySearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 64,Swidth, 40)];
    mySearchBar.placeholder = @"输入学校和关键字来搜索";
    mySearchBar.delegate=self;
    [self.view addSubview:mySearchBar];
    searchDC=[[UISearchDisplayController alloc]initWithSearchBar:mySearchBar contentsController:self];
    searchDC.searchResultsDataSource=self;
    searchDC.searchResultsDelegate=self;
}
-(void)LoadDataWithKey:(NSString *)string
{
    [MBProgressHUD showMessage:nil];
    [self.httpManager chooseSchoolWithOpt:@"getschool"
        key:string finished:^(EnumServerStatus status, NSObject *object) {
        [MBProgressHUD hideHUD];
        if (status==0) {
            self.reob=(ResponseObject *)object;
            self.dataArray=self.reob.resultArray;
            [_tableView reloadData];
            return ;
        }
        [MBProgressHUD showError:LOGINMESSAGE_F];
    }];
}

- (IBAction)sure:(UIButton *)sender {
    ((AppDelegate *)app).nav =[(AppDelegate *)app inNavigationController];
    ((AppDelegate *)app).window.rootViewController = ((AppDelegate *)app).nav;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIndentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@",((SchoolInfo *)_dataArray[indexPath.row]).Schoolname];
    return cell;
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
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
