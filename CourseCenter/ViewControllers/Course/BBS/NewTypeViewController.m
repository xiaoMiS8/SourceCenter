//
//  NewTypeViewController.m
//  CourseCenter
//
//  Created by 任晓健 on 15/8/19.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "NewTypeViewController.h"
#import "TextViewCell.h"
#import "NTCell1.h"
#import "SelectClassViewController.h"
@interface NewTypeViewController ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic, strong) NSMutableArray *datas;
@property(nonatomic, strong) NSString *updatedStr;
@property(nonatomic, strong) OCClassInfo *occlass;
@property(nonatomic, strong) CCHttpManager *manager;

@property(nonatomic, strong) NSMutableArray *imgs;


@end

@implementation NewTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"新建话题";
    [self initManager];
    [self.tableView registerNib:[UINib nibWithNibName:@"NTCell1" bundle:nil] forCellReuseIdentifier:@"NTCell1"];
    [self.tableView registerNib:[UINib nibWithNibName:@"TextViewCell" bundle:nil] forCellReuseIdentifier:@"TextViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"imgsCell" bundle:nil] forCellReuseIdentifier:@"imgsCell"];
    self.datas = [[NSMutableArray alloc] initWithArray:@[@"点击选择班级",@"请输入板块名称，15字以内！",@"请输入板块说明"]];
    self.imgs = [[NSMutableArray alloc] initWithCapacity:0];
    [self addNavItem];
}

- (void)initManager {
    self.manager = [CCHttpManager new];
}

- (void)addNavItem {
    
    UIView *titleView = [[UIView alloc] init];
    titleView.bounds = CGRectMake(0, 0, 190, 50);
    self.navigationItem.titleView = titleView;
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, titleView.frame.size.width, titleView.frame.size.height/2)];
    titleLabel.text = @"新建讨论板块";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    [titleView addSubview:titleLabel];
    UILabel *desLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(titleLabel.frame), titleView.frame.size.width, titleView.frame.size.height/2 -10)];
    desLabel.text = @"*取一个好的标题常常能引起大家更多活跃的讨论";
    desLabel.textAlignment = NSTextAlignmentCenter;
    desLabel.textColor = [UIColor whiteColor];
    desLabel.font = [UIFont systemFontOfSize:8];
    [titleView addSubview:desLabel];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(done)];
    self.navigationItem.leftBarButtonItem = leftItem;
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)cancel {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)done {
    [self addType];
     [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)addType {
    TextViewCell *titleCell = (TextViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    TextViewCell *briefCell = (TextViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    NSString *title = titleCell.textView.text;
    NSString *brief = briefCell.textView.text;
    if ([title isEqualToString:@""] || [title isEqualToString:@"请输入板块名称，15字以内！"]) {
        [MBProgressHUD showError:@"标题不能为空"];
        return;
    }
    if ([brief isEqualToString:@""] || [brief isEqualToString:@"请输入板块说明"]) {
        [MBProgressHUD showError:@"简介不能为空"];
        return;
    }
    __weak  typeof(self) wself = self;
    [self.manager addForumTypeWithOCID:self.OCID CourseID:0 Title:title IsEssence:NO IsPublic:YES Brief:brief TeachingClassID:self.occlass.TeachingClassID IsSys:NO finished:^(EnumServerStatus status, NSObject *object) {
        if ([((ResponseObject *)object).errrorCode isEqualToString:@"0"]) {
            [MBProgressHUD showSuccess:((ResponseObject *)object).errorMessage];
            wself.AddBlock();
        } else {
            [MBProgressHUD showSuccess:((ResponseObject *)object).errorMessage];
        }
    }];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row > 0) {
        TextViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TextViewCell"];
        cell.textView.text = self.datas[indexPath.row];
        CGSize size =  [cell.textView sizeThatFits:CGSizeMake(cell.textView.frame.size.width -16 , FLT_MAX)];
        CGFloat textHeight = size.height + 20;
        CGFloat defaultHeight = cell.contentView.frame.size.height;
        CGFloat height = textHeight >= defaultHeight ? textHeight : defaultHeight;
        return 1  + height;
    }
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row > 0) {
        TextViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TextViewCell"];
        cell.textView.delegate = self;
        cell.textView.text = self.datas[indexPath.row];
        return cell;
    }
    NTCell1 *cell = [tableView dequeueReusableCellWithIdentifier:@"NTCell1"];
    cell.desLabel.text = self.datas[indexPath.row];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        SelectClassViewController *selecteSVC = [[SelectClassViewController alloc] init];
        selecteSVC.OCID = self.OCID;
        selecteSVC.selectedBlcok = ^(OCClassInfo *occlass) {
            self.occlass = occlass;
            NTCell1 *cell = (NTCell1 *)[tableView cellForRowAtIndexPath:indexPath];
            cell.desLabel.text = occlass.TeachingClassName;
        };
        [self.navigationController pushViewController:selecteSVC animated:YES];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        NSLog(@"h=%f", textView.contentSize.height);
    }
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    textView.text = @"";
    textView.textColor = [UIColor blackColor];
    self.updatedStr = textView.text;
    TextViewCell *cell = (TextViewCell *)[[textView superview] superview];
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    [self.datas replaceObjectAtIndex:indexPath.row withObject:self.updatedStr];
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
}

- (void)textViewDidChange:(UITextView *)textView {
    self.updatedStr = textView.text;
    TextViewCell *cell = (TextViewCell *)[[textView superview] superview];
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    [self.datas replaceObjectAtIndex:indexPath.row withObject:self.updatedStr];
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
