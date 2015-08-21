//
//  SelectSViewController.m
//  CourseCenter
//
//  Created by 任晓健 on 15/8/9.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "SelectSViewController.h"
#import "NewTypeViewController.h"
#import "LineNavigationController.h"
@interface SelectSViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic, strong) CCHttpManager *httpManager;
@property(nonatomic, strong) NSMutableArray *forumTypes;

@end

@implementation SelectSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择板块";
    [self initManager];
    [self loadData];
    [self addNavItem];
    NSString *role = [[NSUserDefaults standardUserDefaults]objectForKey:@"role"];
    if (![role isEqualToString:@"4"]) {
        
    } else {
        [self addNavItem];
    }
   
}

- (void)addNavItem {
    NSString *role = [[NSUserDefaults standardUserDefaults]objectForKey:@"role"];
    if ([role isEqualToString:@"4"]) {
    } else {
        UIBarButtonItem *Item = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(itemAction)];
        self.navigationItem.rightBarButtonItem = Item;
    }
}

- (void)itemAction {
    self.tableView.editing = YES;
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_confirm_hover"] style:UIBarButtonItemStylePlain target:self action:@selector(itemOkAction)];
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"notification_add"] style:UIBarButtonItemStylePlain target:self action:@selector(itemAddAction)];
    self.navigationItem.rightBarButtonItems = @[item2, item1];
}

- (void)itemOkAction {
    self.tableView.editing = NO;
    self.navigationItem.rightBarButtonItems = nil;
    [self addNavItem];
}
- (void)itemAddAction {
    NewTypeViewController *newVC = [NewTypeViewController new];
    newVC.OCID = self.OCID;
    newVC.AddBlock = ^ {
        [self loadData];
        self.tableView.editing = NO;
    };
    LineNavigationController *nav = [[LineNavigationController alloc] initWithRootViewController:newVC];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)initManager {
    self.httpManager = [CCHttpManager new];

}

- (void)loadData {
    [self.httpManager getForumTypeListwithOCID:self.OCID finished:^(EnumServerStatus status, NSObject *object) {
        self.forumTypes = [[NSMutableArray alloc] initWithArray:((ResponseObject *)object).resultArray];
        [self.tableView reloadData];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.forumTypes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = ((ForumTypeInfo *)self.forumTypes[indexPath.row]).Title;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedBlcok(self.forumTypes[indexPath.row]);
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.httpManager deleteForumTypeWithForumTypeID: ((ForumTypeInfo *)self.forumTypes[indexPath.row]).ForumTypeID OCID:self.OCID finished:^(EnumServerStatus status, NSObject *object) {
        if ([((ResponseObject *)object).errrorCode isEqualToString:@"0"]) {
            [MBProgressHUD showSuccess:((ResponseObject *)object).errorMessage];
            [self loadData];
        } else {
             [MBProgressHUD showError:((ResponseObject *)object).errorMessage];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
