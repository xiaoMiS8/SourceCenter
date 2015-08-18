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
#import "NewNotimgCell.h"
#import "CCHttpManager.h"
#import "ResponseObject.h"
#import "TeachingClassInfo.h"
#import "QBImagePickerController.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface NewNotificationViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate,QBImagePickerControllerDelegate>

@property(nonatomic, strong) NSMutableArray *dataSource;
@property(nonatomic, assign) BOOL isOpen;
@property(nonatomic, strong) NSString *tmpSelectedStr;
@property(nonatomic, strong)CCHttpManager *httpManager;
@property(nonatomic, strong) NSMutableArray *teachingClasses;
@property(nonatomic, strong) NSMutableArray *isSelecteds;
@property(nonatomic, strong) NSMutableArray *isSendSelecteds;

@end

@implementation NewNotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initDataSource];
    self.title = @"新建通知";
    self.tmpSelectedStr = @"请选择班级";
    self.teachingClasses = [[NSMutableArray alloc] initWithCapacity:0];
    self.httpManager = [[CCHttpManager alloc] init];
    self.isSelecteds = [[NSMutableArray alloc] initWithCapacity:0];
    self.isSendSelecteds = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithBool:NO],[NSNumber numberWithBool:NO], nil];
    self.isOpen = NO;
    [self loadData];
    [self addcancelItem];
    [self addokItem];
    [self setupTableView];
  
    
   
}

- (void)loadData {
    [self.httpManager getAppTeacherOCClass_ListWithKey:@"" IsHistroy:NO PageIndex:1 PageSize:INT_MAX finished:^(EnumServerStatus status, NSObject *object) {
        TeachingClassInfo *teachingclass = [TeachingClassInfo new];
        teachingclass.TeachingClassName = @"全选";
        [self.teachingClasses addObject:teachingclass];
        [self.teachingClasses addObjectsFromArray:((ResponseObject *)object).resultArray];
        for (int i=0; i< self.teachingClasses.count; i++) {
            [self.isSelecteds addObject:[NSNumber numberWithBool:NO]];
        }
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
    [self.tableView registerNib:[UINib nibWithNibName:@"NewNotimgCell" bundle:nil] forCellReuseIdentifier:@"NewNotimgCell"];
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
    if (title == nil || [title isEqualToString:@""]) {
        [MBProgressHUD showError:@"请输入标题"];
        return;
    }
    if (content == nil || [content isEqualToString:@""]) {
        [MBProgressHUD showError:@"请输入通知内容"];
        return;
    }
    NSMutableArray *IDs = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i=1; i<self.isSelecteds.count; i++) {
        if ([self.isSelecteds[i] boolValue]) {
            TeachingClassInfo *teachIngClass = self.teachingClasses[i -1];
            [IDs addObject:[NSNumber numberWithLong:teachIngClass.TeachingClassID]];
        }
    }
    if (IDs.count < 1) {
        [MBProgressHUD showError:@"请选择班级"];
        return;
    }
    BOOL IsForMail = [self.isSendSelecteds[0] boolValue];
    BOOL IsForSMS = [self.isSendSelecteds[1] boolValue];
    [self.httpManager AddAppNoticeWithTitle:title Conten:content IsTop:NO IsForMail:IsForMail IsForSMS:IsForSMS SourceIDs:IDs finished:^(EnumServerStatus status, NSObject *object) {
        
    }];
    self.DoBlock();
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)addFooter {
    UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 0.5)];
    lineLabel.backgroundColor = [UIColor blackColor];
    [self.footView addSubview:lineLabel];
    NSArray *imgs = @[@"btn_camera",@"btn_photo",@"btn_transmit",@"btn_important"];
    for (int i=0; i<4; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = 10 + i;
        btn.frame = CGRectMake(20 + i * (10+40), 5, 40, 40);
        [btn setImage:[UIImage imageNamed:imgs[i]] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(fourBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.footView addSubview:btn];
    }
    UILabel *lineLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 55, [UIScreen mainScreen].bounds.size.width, 0.5)];
    lineLabel2.backgroundColor = [UIColor blackColor];
    [self.footView addSubview:lineLabel2];
    
    UIView *dowview = [UIView new];
    dowview.backgroundColor = [Tool colorWithHexString:@"#d7d7d7"];
    dowview.frame = CGRectMake(0, 55, [UIScreen mainScreen].bounds.size.width, 200 - 55);
    [self.footView addSubview:dowview];
    
    UIButton *oneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    oneBtn.tag = 1;
    oneBtn.frame = CGRectMake(0, 20,[UIScreen mainScreen].bounds.size.width , 44);
    [dowview addSubview:oneBtn];
    
    UIImageView *oneImg = [[UIImageView alloc] initWithFrame:CGRectMake(30, 10, 20, 20)];
    [oneBtn addTarget:self action:@selector(oneBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    oneImg.image = [UIImage imageNamed:@"btn_confirm"];
    [oneBtn addSubview:oneImg];
    
    UILabel *oneLabel = [UILabel new];
    oneLabel.textColor = [UIColor blackColor];
    oneLabel.frame = CGRectMake(CGRectGetMaxX(oneImg.frame) + 2, 0, 100, 40);
    oneLabel.text = @"发送邮件";
    [oneBtn addSubview:oneLabel];
    
    UIButton *twoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    twoBtn.tag = 2;
    twoBtn.frame = CGRectMake(0, CGRectGetMaxY(oneBtn.frame),[UIScreen mainScreen].bounds.size.width , 44);
    [twoBtn addTarget:self action:@selector(oneBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [dowview addSubview:twoBtn];
    
    UIImageView *twoImg = [[UIImageView alloc] initWithFrame:CGRectMake(30, 10, 20, 20)];
    twoImg.image = [UIImage imageNamed:@"btn_confirm"];
    [twoBtn addSubview:twoImg];
    
    UILabel *twoLabel = [UILabel new];
    twoLabel.textColor = [UIColor blackColor];
    twoLabel.frame = CGRectMake(CGRectGetMaxX(oneImg.frame) + 2, 0, 100, 40);
    twoLabel.text = @"发送短信";
    [twoBtn addSubview:twoLabel];
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
    } else if (indexPath.section == 2) {
        return 120;
    }
    else {
        if (indexPath.row == 0) {
            return 44;
        }
        return 180;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        NewNotiSelectCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewNotiSelectCell"];
        cell.nameLabel.text = ((TeachingClassInfo *)self.dataSource[indexPath.section][indexPath.row]).TeachingClassName;
        if ([self.isSelecteds[indexPath.row] boolValue]) {
            cell.imgView.image = [UIImage imageNamed:@"btn_confirm_hover"];
        } else {
            cell.imgView.image = [UIImage imageNamed:@"btn_confirm"];
        }
        return cell;
    }
    if (indexPath.section == 2) {
        NewNotimgCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewNotimgCell"];
        cell.imgs = self.dataSource[indexPath.section][indexPath.row];
        cell.deleteBlock = ^(UIButton *btn) {
            DLog(@"tag---%ld",btn.tag);
            NewNotimgCell *imgCell = (NewNotimgCell *)[[[btn superview] superview] superview];
            NSIndexPath *tmpIndexpath = [tableView indexPathForCell:imgCell];
            NSMutableArray *Array = self.dataSource.lastObject[tmpIndexpath.row];
            [Array removeObjectAtIndex:btn.tag - 1];
            NSMutableArray *bigArray = self.dataSource.lastObject;
            for (int i=0; i<bigArray.count; i++) {
                if ([bigArray[i] count] == 0) {
                    [bigArray removeObjectAtIndex:i];
                }
            }
            [self.tableView reloadData];
        };
        return cell;
    } else {
        NewNotiTextViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewNotiTextViewCell"];
        cell.textView.placeholder = self.dataSource[indexPath.section][indexPath.row];
        if (indexPath.row == 1) {
            cell.lineLabel.hidden = YES;
        } else {
            cell.lineLabel.hidden = NO;
        }
        return cell;
    }
 
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
    imgView.image = [UIImage imageNamed:@"arrow_down"];
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
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        if ([self.isSelecteds[0] boolValue]) {
            for (int i=0; i<self.isSelecteds.count; i++) {
                [self.isSelecteds replaceObjectAtIndex:i withObject: [NSNumber numberWithBool:NO]];
            }
        } else {
            for (int i=0; i<self.isSelecteds.count; i++) {
                [self.isSelecteds replaceObjectAtIndex:i withObject: [NSNumber numberWithBool:YES]];
            }
        }
    }  else {
           [self.isSelecteds replaceObjectAtIndex:indexPath.row withObject:[NSNumber numberWithBool:![self.isSelecteds[indexPath.row] boolValue]]];
    }
    [self .tableView reloadData];
}

- (void)fourBtnAction:(UIButton *)btn {
    UIButton *fourBtn =(UIButton *)[self.footView viewWithTag:13];
    switch (btn.tag - 10) {
        case 0:
        {
            [fourBtn setImage:[UIImage imageNamed:@"btn_important"] forState:UIControlStateNormal];
            [self changeToolviewHeight:50];
            [self openCamera];
        }
            break;
        case 1:
        {
            [fourBtn setImage:[UIImage imageNamed:@"btn_important"] forState:UIControlStateNormal];
             [self changeToolviewHeight:50];
            [self openPhotoLibrary];
        }
            break;
        case 2:
        {
            [fourBtn setImage:[UIImage imageNamed:@"btn_important"] forState:UIControlStateNormal];
            [self changeToolviewHeight:50];
        }
            break;
        case 3:
        {
            [fourBtn setImage:[UIImage imageNamed:@"btn_important_push"] forState:UIControlStateNormal];
            [self changeToolviewHeight:200];
            
        }
            break;
            
        default:
            break;
    }
}

- (void)changeToolviewHeight:(CGFloat)height {
    
    for (NSLayoutConstraint *constraint in self.footView.constraints) {
        if (constraint.firstItem == self.footView && constraint.firstAttribute == NSLayoutAttributeHeight) {
            constraint.constant = height;
        }
    }
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
        [self.view updateConstraintsIfNeeded];
    }];
}

- (void)oneBtnAction:(UIButton *)btn {
    [self.isSendSelecteds replaceObjectAtIndex:btn.tag - 1 withObject:[NSNumber numberWithBool: ![self.isSendSelecteds[btn.tag -1] boolValue]]];
    NSArray *subviews = btn.subviews;
    for (int i=0; i<subviews.count; i++) {
        id sub1 = subviews[i];
        if ([sub1 isKindOfClass:[UIImageView class]]) {
            if ([self.isSendSelecteds[btn.tag - 1] boolValue]) {
                ((UIImageView *)sub1).image = [UIImage imageNamed:@"btn_confirm_hover"];
            } else {
                 ((UIImageView *)sub1).image = [UIImage imageNamed:@"btn_confirm"];
            }
           
        } else if ([sub1 isKindOfClass:[UILabel class]]) {
            if ([self.isSendSelecteds[btn.tag - 1] boolValue]) {
                ((UILabel *)sub1).textColor = [Tool colorWithHexString:@"#01aef0"];
            } else {
                ((UILabel *)sub1).textColor = [UIColor blackColor];
            }
        }
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

- (void)openCamera {
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.sourceType = sourceType;
        picker.allowsEditing = YES;
        [self presentViewController:picker animated:YES completion:^{
            
        }];
    }
}

- (void)openPhotoLibrary {
    QBImagePickerController *imagePickerController = [[QBImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.allowsMultipleSelection = YES;
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:imagePickerController];
    [self presentViewController:navigationController animated:YES completion:NULL];
    
    
}

- (void)imagePickerController:(QBImagePickerController *)imagePickerController didSelectAssets:(NSArray *)assets
{
    NSLog(@"*** imagePickerController:didSelectAssets:");
    NSLog(@"%@", assets);
    NSMutableArray *imgs = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i=0; i<assets.count; i++) {
        UIImage *img = [UIImage imageWithCGImage:[assets[i] aspectRatioThumbnail]];
        [imgs addObject:img];
    }
    
    NSMutableArray *bigArray = nil;
    
    if (self.dataSource.count < 3) {
        bigArray = [[NSMutableArray alloc] initWithCapacity:0];
        int row = (int)imgs.count/3;
        int lon = imgs.count % 3;
        for (int i=0; i<row; i++) {
            NSMutableArray *array = [[NSMutableArray alloc] init];
            for (int j=i * 3; j<i *3 + 3; j++) {
                [array addObject:imgs[j]];
            }
            [bigArray addObject:array];
        }
        if (lon > 0) {
             NSMutableArray *array = [[NSMutableArray alloc] init];
            for (int k= (int)imgs.count - lon; k<imgs.count; k++) {
                [array addObject:imgs[k]];
            }
            [bigArray addObject:array];
        }
        [self.dataSource addObject:bigArray];
        
    } else {
        bigArray = [self.dataSource lastObject];
        NSMutableArray *array = bigArray.lastObject;
        NSMutableArray *tmpArray = [[NSMutableArray alloc] initWithCapacity:0];
        NSMutableArray *delArray = [[NSMutableArray alloc] initWithCapacity:0];
        if (array.count < 3) {
            for (int i=0; i<3-array.count; i++) {
                if (i<imgs.count) {
                    [tmpArray addObject:imgs[i]];
                    [delArray addObject:imgs[i]];
                }
            }
            [imgs removeObjectsInArray:delArray];
            [array addObjectsFromArray:tmpArray];
            int row = (int)imgs.count/3;
            int lon = imgs.count % 3;
            for (int i=0; i<row; i++) {
                NSMutableArray *array = [[NSMutableArray alloc] init];
                for (int j=i * 3; j<i *3 + 3; j++) {
                    [array addObject:imgs[j]];
                }
                [bigArray addObject:array];
            }
            if (lon > 0) {
                 NSMutableArray *array2 = [[NSMutableArray alloc] init];
                for (int k= (int)imgs.count - lon; k<imgs.count; k++) {
                    [array2 addObject:imgs[k]];
                }
                [bigArray addObject:array2];
            }
            
            
        } else {
            int row = (int)imgs.count/3;
            int lon = imgs.count % 3;
            for (int i=0; i<row; i++) {
                NSMutableArray *array = [[NSMutableArray alloc] init];
                for (int j=i * 3; j<i *3 + 3; j++) {
                    [array addObject:imgs[j]];
                }
                [bigArray addObject:array];
            }
            
            if (lon > 0) {
                NSMutableArray *array = [[NSMutableArray alloc] init];
                for (int k= (int)imgs.count - lon; k<imgs.count; k++) {
                    [array addObject:imgs[k]];
                } [bigArray addObject:array];
            }
           
        }
    }
    [self.tableView reloadData];
    [self dismissImagePickerController];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo {
    NSMutableArray *bigArray = [[NSMutableArray alloc] initWithCapacity:0];
    if (self.dataSource.count < 3) {
        NSMutableArray *imgs = [[NSMutableArray alloc] initWithCapacity:0];
        [imgs addObject:image];
        [bigArray addObject:imgs];
        [self.dataSource addObject:bigArray];
    } else {
        NSMutableArray *bigArray = [self.dataSource lastObject];
        NSMutableArray *array = [bigArray lastObject];
        if (array.count < 3) {
            [array addObject:image];
        }
        else {
            NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
            [array addObject:image];
            [bigArray addObject:array];
        }
    }
    [self.tableView reloadData];
    [self dismissImagePickerController];
}


- (void)imagePickerControllerDidCancel:(QBImagePickerController *)imagePickerController
{
    NSLog(@"*** imagePickerControllerDidCancel:");
    
    [self dismissImagePickerController];
}

- (void)dismissImagePickerController
{
    if (self.presentedViewController) {
        [self dismissViewControllerAnimated:YES completion:NULL];
    } else {
        [self.navigationController popToViewController:self animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
