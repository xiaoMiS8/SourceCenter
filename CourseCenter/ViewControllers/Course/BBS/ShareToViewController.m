//
//  ShareToViewController.m
//  CourseCenter
//
//  Created by 任晓健 on 15/8/9.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "ShareToViewController.h"
#import "NewNotiSelectCell.h"

@interface ShareToViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic, strong)CCHttpManager *manager;

@property(nonatomic, strong) NSArray *forums;
@property(nonatomic, strong) NSMutableArray *selecteds;
@property(nonatomic, strong) NSMutableArray *selectedforums;

@end

@implementation ShareToViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"分享至";
    [self addNavItem];
    self.selecteds = [[NSMutableArray alloc] initWithCapacity:0];
    [self initManager];
    [self setCell];
    [self loadData];
    
}

- (void)addNavItem {
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(done)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
}

- (void)done {
    self.selectedforums = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i=0; i<self.selecteds.count; i++) {
        ForumTypeInfo *forum = self.forums[[self.selecteds[i] integerValue]];
        [self.selectedforums addObject:forum];
    }
    self.doneBlock(self.selectedforums);
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)initManager {
    self.manager = [CCHttpManager new];
}

- (void)loadData {
    [self.manager getForumTypeListwithOCID:self.OCID finished:^(EnumServerStatus status, NSObject *object) {
        self.forums = ((ResponseObject *)object).resultArray;
        [self.tableView reloadData];
    }];
}

- (void)setCell {
    [self.tableView registerNib:[UINib nibWithNibName:@"NewNotiSelectCell" bundle:nil] forCellReuseIdentifier:@"NewNotiSelectCell"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.forums.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NewNotiSelectCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewNotiSelectCell"];
    if ([self isExistwithIndex:indexPath.row]) {
        cell.imgView.image = [UIImage imageNamed:@"btn_confirm_hover"];
    } else {
        cell.imgView.image = [UIImage imageNamed:@"btn_confirm"];
    }
    cell.nameLabel.text = ((ForumTypeInfo *)(self.forums[indexPath.row])).Title;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (![self isExistwithIndex:indexPath.row]) {
        [self.selecteds addObject:@(indexPath.row)];
        
    } else {
        [self.selecteds removeObject:@(indexPath.row)];
    }
    [self.tableView reloadData];
}

- (BOOL)isExistwithIndex:(NSInteger)index {
    for (int i=0; i<self.selecteds.count; i++) {
        if (index == [self.selecteds[i] integerValue]) {
            return YES;
        }
    }
    return NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
  
}



@end
