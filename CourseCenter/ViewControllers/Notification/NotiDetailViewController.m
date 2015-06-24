//
//  NotiDetailViewController.m
//  CourseCenter
//
//  Created by renxiaojian on 15/5/29.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "NotiDetailViewController.h"
#import "NotificationListCell.h"
#import "NotiDetailCell.h"
#import "MyTextView.h"
@interface NotiDetailViewController ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *bomView;
@property(nonatomic, strong) MyTextView *textView;
@property(nonatomic, strong) UIButton *sendBtn;

@end

@implementation NotiDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"通知详情";
    [self setupTable];
    [self addFooterView];
    
    
    
}

- (void)addFooterView {
    UIButton *sendbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sendbtn.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 50, 0, 40, 40);
    [sendbtn setTitle:@"发送" forState:UIControlStateNormal];
    sendbtn.titleLabel.font = Font_16;
    [sendbtn addTarget:self action:@selector(sendAction:) forControlEvents:UIControlEventTouchUpInside];
    [sendbtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.bomView addSubview:sendbtn];
    self.sendBtn = sendbtn;
    MyTextView *textView = [[MyTextView alloc] initWithFrame:CGRectMake(10, 5, [UIScreen mainScreen].bounds.size.width - 70, 30)];
    textView.delegate = self;
    textView.font = Font_16;
    textView.placeholder = @"发表评论（限250字以内）";
    [self.bomView addSubview:textView];
    textView.layer.borderColor = [UIColor blackColor].CGColor;
    textView.layer.borderWidth = 0.5;
    textView.layer.cornerRadius = 3;
    self.textView = textView;
//    footerView.bounds = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, textView.frame.size.height + 10);
//    self.footerView = footerView;
}

- (void)setupTable {
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self setupCell];
}

- (void)setupCell {
    [self.tableView registerClass:[NotificationListCell class] forCellReuseIdentifier:@"NotificationListCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"NotiDetailCell" bundle:nil] forCellReuseIdentifier:@"NotiDetailCell"];
    
}

#pragma mark- UITableViewDataSource && UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        NotificationListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NotificationListCell"];
        cell.notification = self.notification;
        return cell.cellHeight;
    }
    else {
        NotiDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NotiDetailCell"];
        CGSize size = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
        return size.height + 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        NotificationListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NotificationListCell"];
        cell.notification = self.notification;
        return cell;
    }
    else {
        NotiDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NotiDetailCell"];
        return cell;
    }
}

- (void)textViewDidChange:(UITextView *)textView {
    if (textView.text) {
        CGRect tempRect = textView.frame;
        tempRect.size.height = self.textView.contentSize.height;
        textView.frame = tempRect;
        for (NSLayoutConstraint *constraint in self.bomView.constraints) {
            if (constraint.firstItem == self.bomView && constraint.firstAttribute == NSLayoutAttributeHeight) {
                constraint.constant = tempRect.size.height + 10;
            }
        }
        self.sendBtn.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 50, tempRect.size.height + 10 - 40, 40, 40);
        [self.view layoutIfNeeded];
        [self.view updateConstraintsIfNeeded];
    }

}


    //得到字符串的size
- (CGSize)getSizeWithString:(NSString *)string
                       font:(UIFont *)font size:(CGSize)size {
    CGSize stringSize = [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: font} context:nil].size;
    return stringSize;
}

- (void)sendAction:(id)sender {
    self.textView.text = @"";
        for (NSLayoutConstraint *constraint in self.bomView.constraints) {
            if (constraint.firstItem == self.bomView && constraint.firstAttribute == NSLayoutAttributeHeight) {
                constraint.constant = 40;
            }
        }
    [self.view layoutIfNeeded];
    [self.view updateConstraintsIfNeeded];
    self.sendBtn.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 50, 0, 40, 40);
    [self.textView endEditing:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
