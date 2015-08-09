    //
    //  BBsDetailViewController.m
    //  CourseCenter
    //
    //  Created by jian on 15/8/3.
    //  Copyright © 2015年 line0.com. All rights reserved.
    //

#import "BBsDetailViewController.h"
#import "BBsDetailCell.h"
#import "BBSResponeCell.h"
#import "TopicSetView.h"
#import "ShareToViewController.h"
@interface BBsDetailViewController ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *bomView;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@property(nonatomic, strong) TopicSetView *topSetView;

@property(nonatomic, assign) long parentID;

@property(nonatomic, strong) CCHttpManager *manager;

@property(nonatomic, strong) NSArray *respones;

@end

@implementation BBsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"帖子正文";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.parentID = 0;
    [self addnavItem];
    [self setBomView];
    [self setCell];
    [self initManager];
    [self loadData];
    
}

- (void)viewDidDisappear:(BOOL)animated {
    [self.topSetView hide];
}

- (void)setBomView {
    self.textView.layer.cornerRadius = 3;
    self.textView.layer.masksToBounds = YES;
    self.textView.layer.borderColor = [UIColor blackColor].CGColor;
    self.textView.layer.borderWidth = 0.5f;
}

- (void)addnavItem {
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"topic_set"] style:UIBarButtonItemStylePlain target:self action:@selector(topicSet)];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)topicSet {
    if (!self.topSetView) {
        TopicSetView *topicSetView = [[TopicSetView alloc] initWithFrame:self.view.frame];
        topicSetView.bgview = self.view;
        __weak typeof(topicSetView) wtop = topicSetView;
        topicSetView.ClickBlock = ^(NSInteger index) {
            switch (index) {
                case 1:
                {
                    [self topicSetIsTop];
                
                
                }
                    break;
                case 2:
                {
                    [self topicSetIsEssence];
                
                }
                    break;
                case 3:
                {
                    [self topicTopicType];
                
                }
                    break;
                case 4:
                {
                    [self topicDelete];
                
                }
                    break;
                    
                default:
                    break;
            }
            [wtop hide];
        };
        self.topSetView = topicSetView;
    }
    [self.topSetView show];
}

    //置顶
- (void)topicSetIsTop {
    __weak typeof(self) wself = self;
    [self.manager setAppForumTopicIsTopWithTopicID:self.topic.TopicID finished:^(EnumServerStatus status, NSObject *object) {
        if (status == Enum_SUCCESS) {
            [MBProgressHUD showSuccess: ((ResponseObject *)object).message];
            wself.topicSetBlcok();
            [wself.navigationController popViewControllerAnimated:YES];
        }
    }];
}
    //加精
- (void)topicSetIsEssence {
    __weak typeof(self) wself = self;
    [self.manager setAppForumTopicIsEssenceWithTopicID:self.topic.TopicID finished:^(EnumServerStatus status, NSObject *object) {
        if (status == Enum_SUCCESS) {
            [MBProgressHUD showSuccess: ((ResponseObject *)object).message];
            wself.topicSetBlcok();
            [wself.navigationController popViewControllerAnimated:YES];
        }
    }];
}

    //删除该帖子
- (void)topicDelete {
    __weak typeof(self) wself = self;
    [self.manager deleteForumTopicwithTopicID:self.topic.TopicID finished:^(EnumServerStatus status, NSObject *object) {
        if (status == Enum_SUCCESS) {
            [MBProgressHUD showSuccess: ((ResponseObject *)object).message];
            wself.topicSetBlcok();
            [wself.navigationController popViewControllerAnimated:YES];
        }
    }];
}

- (void)topicTopicType {
     __weak typeof(self) wself = self;
    ShareToViewController *shareToVC = [ShareToViewController new];
    shareToVC.doneBlock = ^(NSArray *forums) {
        [self.manager addAppForumTopicTypeWithTopicID:self.topic.TopicID finished:^(EnumServerStatus status, NSObject *object) {
            if (status == Enum_SUCCESS) {
                [MBProgressHUD showSuccess: ((ResponseObject *)object).message];
                wself.topicSetBlcok();
                [wself.navigationController popViewControllerAnimated:YES];
            }
        }];
    };
    shareToVC.OCID = self.OCID;
    [self.navigationController pushViewController:shareToVC animated:YES];
    
}

- (void)initManager {
    self.manager = [CCHttpManager new];
}

- (void)loadData {
    [self.manager getAppForumResponseInfoListWithTopicID:self.topic.TopicID finished:^(EnumServerStatus status, NSObject *object) {
        self.respones = ((ResponseObject *)object).resultArray;
        [self.tableView reloadData];
    }];
}

- (void) reloadData {
    [self.manager getAppForumResponseInfoListWithTopicID:self.topic.TopicID finished:^(EnumServerStatus status, NSObject *object) {
        self.respones = ((ResponseObject *)object).resultArray;
        [self.tableView reloadData];
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForItem:self.respones.count inSection:0] atScrollPosition:UITableViewScrollPositionNone animated:NO];
        
    }];
}

- (void)setCell {
    [self.tableView registerNib:[UINib nibWithNibName:@"BBsDetailCell" bundle:nil] forCellReuseIdentifier:@"BBsDetailCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"BBSResponeCell" bundle:nil] forCellReuseIdentifier:@"BBSResponeCell"];
}

- (CGFloat)tableView:( UITableView *)tableView heightForRowAtIndexPath:( NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        BBsDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BBsDetailCell"];
        cell.topic = self.topic;
        CGSize size = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
        return size.height + 1;
    }
    else {
        BBSResponeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BBSResponeCell"];
        cell.response = self.respones[indexPath.row - 1];
        CGSize size = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
        return size.height + 1;
    }
}

- (NSInteger)numberOfSectionsInTableView:( UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:( UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.respones.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        BBsDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BBsDetailCell"];
        cell.topic = self.topic;
        cell.agreeBlock = ^ {
            [self.manager updateForumMyIsGoodWithTopicID:self.OCID ResponseID:0 finished:^(EnumServerStatus status, NSObject *object) {
                 [self reloadData];
                [MBProgressHUD showSuccess:((ResponseObject *)object).message];
            }];
           
        };
        return cell;
    }
    else {
        BBSResponeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BBSResponeCell"];
        cell.response = self.respones[indexPath.row - 1];
        cell.agreeBlcok = ^{
            [self.manager updateForumMyIsGoodWithTopicID:self.OCID ResponseID:((TopicResponseInfo *)self.respones[indexPath.row - 1]).ResponseID finished:^(EnumServerStatus status, NSObject *object) {
                [self reloadData];
                [MBProgressHUD showSuccess:((ResponseObject *)object).message];
            }];
        };
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row > 0) {
        self.parentID = ((TopicResponseInfo *)self.respones[indexPath.row - 1]).ParentID;
        [self.textView becomeFirstResponder];
        self.textView.text = @"";
    }
}

#pragma mark- UITextViewDelegate

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    self.textView.text = @"";
    return YES;
}
- (IBAction)sendClick:(id)sender {
    __weak typeof(self) wself = self;
    [self.manager addForumResponseWithTopicID:self.topic.TopicID ParentID:self.parentID Conten:self.textView.text finished:^(EnumServerStatus status, NSObject *object) {
        [MBProgressHUD showSuccess:@"回复成功"];
        [wself reloadData];
        wself.textView.text = @"发表评论（限250字以内";
        [wself.textView endEditing:YES];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
