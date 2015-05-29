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
@interface NotiDetailViewController ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *bomView;
@property(nonatomic, strong) UITextView *textView;

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
    sendbtn.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 50, 10, 40, 40);
    [sendbtn setTitle:@"发送" forState:UIControlStateNormal];
    [sendbtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.bomView addSubview:sendbtn];
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(10, 10, [UIScreen mainScreen].bounds.size.width - 70, 40)];
    textView.delegate = self;
    textView.bouncesZoom = NO;
    textView.bounces = NO;
    [self.bomView addSubview:textView];
    textView.scrollEnabled = NO;
    textView.layer.borderColor = [UIColor blackColor].CGColor;
    textView.text = @"jjjj";
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

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if (textView.text) {
        CGSize size = [self getSizeWithString:textView.text font:textView.font size:CGSizeMake([UIScreen mainScreen].bounds.size.width - 70, CGFLOAT_MAX)];
        CGRect rect = textView.frame;
        rect.size.height = size.height + 20;
        self.textView.frame = rect;
        for (NSLayoutConstraint *constraint in self.bomView.constraints) {
            if (constraint.firstItem == self.bomView && constraint.firstAttribute == NSLayoutAttributeHeight) {
                constraint.constant = size.height + 20;
            }
        }
        [self.view layoutIfNeeded];
        [self.view updateConstraintsIfNeeded];
        
//        self.tableView.tableFooterView = self.bomView;
    }
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    CGSize size = [self getSizeWithString:textView.text font:textView.font size:CGSizeMake([UIScreen mainScreen].bounds.size.width - 70, CGFLOAT_MAX)];
    CGRect rect = textView.frame;
    rect.size.height = size.height + 20;
    self.textView.frame = rect;
    for (NSLayoutConstraint *constraint in self.bomView.constraints) {
        if (constraint.firstItem == self.bomView && constraint.firstAttribute == NSLayoutAttributeHeight) {
            constraint.constant = size.height + 20;
        }
    }
    [self.view layoutIfNeeded];
    [self.view updateConstraintsIfNeeded];
}

    //得到字符串的size
- (CGSize)getSizeWithString:(NSString *)string
                       font:(UIFont *)font size:(CGSize)size {
    CGSize stringSize = [string boundingRectWithSize:size options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading  attributes:@{NSFontAttributeName: font} context:nil].size;
    return stringSize;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
