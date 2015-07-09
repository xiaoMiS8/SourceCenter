//
//  NewNotificationViewController.m
//  CourseCenter
//
//  Created by jian on 15/6/15.
//  Copyright © 2015年 line0.com. All rights reserved.
//

#import "NewNotificationViewController.h"
#import "NewNotiTextViewCell.h"
#import "NewNotiSelectCell.h"
#import "CCHttpManager.h"
#import "ResponseObject.h"
#import "TeachingClassInfo.h"
@interface NewNotificationViewController ()

@property(nonatomic, strong) NSMutableArray *dataSource;
@property(nonatomic, assign) BOOL isOpen;
@property(nonatomic, strong) NSString *tmpSelectedStr;

@property(nonatomic, strong)CCHttpManager *httpManager;
@property(nonatomic, strong) NSArray *teachingClasses;

@end

@implementation NewNotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initDataSource];
    self.title = @"新建通知";
    self.tmpSelectedStr = @"请选择班级";
    self.httpManager = [[CCHttpManager alloc] init];
    self.isOpen = NO;
    [self loadData];
    [self addcancelItem];
    [self addokItem];
    [self setupTableView];
  
    
   
}

- (void)loadData {
    [self.httpManager getAppTeacherOCClass_ListWithKey:@"" IsHistroy:NO PageIndex:1 PageSize:INT_MAX finished:^(EnumServerStatus status, NSObject *object) {
        self.teachingClasses = ((ResponseObject *)object).resultArray;
        [self.tableView reloadData];
    }];
}

- (void)setupTableView {
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self setupCell];
    [self addFooter];
}

- (void)setupCell {
    [self.tableView registerNib:[UINib nibWithNibName:@"NewNotiTextViewCell" bundle:nil] forCellReuseIdentifier:@"NewNotiTextViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"NewNotiSelectCell" bundle:nil] forCellReuseIdentifier:@"NewNotiSelectCell"];
}

- (void)initDataSource {
    self.dataSource = [[NSMutableArray alloc] initWithCapacity:0];
    [self.dataSource addObject:[NSMutableArray arrayWithCapacity:0]];
    [self.dataSource addObject:[NSMutableArray arrayWithObjects:@"请输入标题", @"请输入内容", nil]];
    
    
}

- (void)addcancelItem {
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelItemAction)];
    self.navigationItem.leftBarButtonItem = leftItem;
}

- (void)addokItem {
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(okItemAction)];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)cancelItemAction {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)okItemAction {
    
    NewNotiTextViewCell *titleCell = (NewNotiTextViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:1]];
    NewNotiTextViewCell *contentCell = (NewNotiTextViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:1]];
    NSString *title = titleCell.textView.text;
    NSString *content = contentCell.textView.text;
    [self.httpManager AddAppNoticeWithTitle:title Conten:content IsTop:NO IsForMail:NO IsForSMS:NO SourceIDs:[NSArray arrayWithObjects:[NSNumber numberWithInt:16], nil] finished:^(EnumServerStatus status, NSObject *object) {
        
    }];
    self.DoBlock();
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)addFooter {
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 50)];
    footerView.backgroundColor = [UIColor whiteColor];
    NSArray *imgs = @[@"btn_camera",@"btn_photo",@"btn_transmit",@"btn_important"];
    for (int i=0; i<4; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(20 + i * (10+40), 5, 40, 40);
        [btn setImage:[UIImage imageNamed:imgs[i]] forState:UIControlStateNormal];
        [footerView addSubview:btn];
    }
    
    self.tableView.tableFooterView = footerView;
}

#pragma mark- UITableViewDelegate & UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
      return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSource[section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 40;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 44;
    }
    else {
        if (indexPath.row == 0) {
            return 44;
        }
        return 150;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        NewNotiSelectCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewNotiSelectCell"];
        cell.nameLabel.text = ((TeachingClassInfo *)self.dataSource[indexPath.section][indexPath.row]).TeachingClassName;
        return cell;
    }
    NewNotiTextViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewNotiTextViewCell"];
    cell.textView.placeholder = self.dataSource[indexPath.section][indexPath.row];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor whiteColor];
    btn.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 40);
    [btn addTarget:self action:@selector(openBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    UILabel *label = [[UILabel alloc] init];
    label.translatesAutoresizingMaskIntoConstraints = NO;
    label.text = @"发布到";
    label.font = Font_14;
    [btn addSubview:label];
    
    UILabel *rightLabel = [UILabel new];
    rightLabel.translatesAutoresizingMaskIntoConstraints = NO;
    rightLabel.text = self.tmpSelectedStr;
    rightLabel.font = Font_14;
    rightLabel.textColor = [UIColor grayColor];
    [btn addSubview:rightLabel];    
    UIImageView *imgView = [[UIImageView alloc] init];
    imgView.backgroundColor = [UIColor redColor];
    imgView.translatesAutoresizingMaskIntoConstraints = NO;
    [btn addSubview:imgView];
    
    
    NSDictionary *views = NSDictionaryOfVariableBindings(label, rightLabel,imgView);
    NSString *vflH1 = @"H:|-10-[label]";
    NSString *vflH2 = @"H:[rightLabel]-2-[imgView(20)]-10-|";
    NSString *vflV1 = @"V:|-10-[label]-10-|";
    NSString *vflV2 = @"V:|-10-[rightLabel]-10-|";
     NSString *vflV3 = @"V:|-10-[imgView(20)]";
    
    [btn addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:vflH1 options:0 metrics:nil views:views]];
    [btn addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:vflH2 options:0 metrics:nil views:views]];
    [btn addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:vflV1 options:0 metrics:nil views:views]];
    [btn addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:vflV2 options:0 metrics:nil views:views]];
     [btn addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:vflV3 options:0 metrics:nil views:views]];
    
    return btn;
}

- (void)tableView:( UITableView *)tableView didSelectRowAtIndexPath:( NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        NewNotiSelectCell *cell = (NewNotiSelectCell *)[tableView cellForRowAtIndexPath:indexPath];
        self.tmpSelectedStr = cell.nameLabel.text;
        [self controlOpen];
    }
}


- (void)openBtnAction:(id)sender {

    [self controlOpen];
}

- (void)controlOpen {
    self.isOpen = !self.isOpen;
    if (self.isOpen) {
        [self.dataSource[0] addObjectsFromArray:self.teachingClasses];
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
    }
    else {
        [self.dataSource[0] removeAllObjects];
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
