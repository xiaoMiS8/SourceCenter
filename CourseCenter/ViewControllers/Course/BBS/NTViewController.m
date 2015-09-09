//
//  NTViewController.m
//  CourseCenter
//
//  Created by 任晓健 on 15/8/9.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "NTViewController.h"
#import "TextViewCell.h"
#import "NTCell1.h"
#import "imgsCell.h"
#import "QBImagePickerController.h"
#import "SelectSViewController.h"
#import "GTMBase64.h"

@interface NTViewController ()<UITextViewDelegate,QBImagePickerControllerDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic, strong) NSMutableArray *datas;
@property(nonatomic, strong) NSString *updatedStr;
@property (weak, nonatomic) IBOutlet UIView *bomView;
@property (weak, nonatomic) IBOutlet UIButton *photoBtn;
@property (weak, nonatomic) IBOutlet UIButton *imgBtn;
@property(nonatomic, strong) ForumTypeInfo *forumType;

@property(nonatomic, strong) CCHttpManager *manager;

@property(nonatomic, strong) NSMutableArray *imgs;
@property(nonatomic, assign) long topicId;

@end

@implementation NTViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"新建话题";
    [self initManager];
    [self.tableView registerNib:[UINib nibWithNibName:@"NTCell1" bundle:nil] forCellReuseIdentifier:@"NTCell1"];
    [self.tableView registerNib:[UINib nibWithNibName:@"TextViewCell" bundle:nil] forCellReuseIdentifier:@"TextViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"imgsCell" bundle:nil] forCellReuseIdentifier:@"imgsCell"];
    self.datas = [[NSMutableArray alloc] initWithArray:@[@"点击选择板块",@"请输入标题，50字以内！",@"请输入话题内容"]];
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
    titleLabel.text = @"新建话题";
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
    if ([self.datas[0] isEqualToString:@"点击选择板块"]) {
        [MBProgressHUD showError:@"请先选择板块"];
        return;
    }
    if ([self.datas[1] isEqualToString:@"请输入标题，50字以内！"]) {
        [MBProgressHUD showError:@"请输入标题"];
        return;
    }
    if ([self.datas[1] length] >= 50) {
        [MBProgressHUD showError:@"标题过长"];
        return;
    }
    if ([self.datas[2] isEqualToString:@"请输入话题内容"]) {
        [MBProgressHUD showError:@"请输入内容"];
        return;
    }
    [self addTopic];
    self.doBlock();
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)addTopic {
    __weak typeof(self) wself = self;
    [self.manager addForumTopicWithOCID:self.OCID CourseID:0 ForumTypeID:self.forumType.ForumTypeID GroupTaskID:0 Title:self.datas[1] Conten:self.datas[2] TopicType:3 Tags:nil ChapterID:0 Source:@"" SourceID:0 finished:^(EnumServerStatus status, NSObject *object) {
        if (status == Enum_SUCCESS) {
            if ([((ResponseObject *)object).errrorCode isEqualToString:@"0"]) {
                wself.topicId = [((ResponseObject *)object).errorMessage integerValue];
                [wself upLoadImgs];
            }
        }
    }];
}

- (void)upLoadImgs {
    if (self.imgs.count > 0) {
        for (int i=0; i<self.imgs.count; i++) {
            UIImage * image = self.imgs[i];
            NSData *data = UIImageJPEGRepresentation(image,0.1);
            data=[GTMBase64 encodeData:data];
            NSString *img_base64=[@"data:image/jpg;base64," stringByAppendingString:[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]];
            [MBProgressHUD showMessage:@"图片上传中..."];
            [self.manager uploadPictureWithSourceID:self.topicId
                                                 Source:@"ForumTopic" FileName:@"123.jpg" imgBytesIn:img_base64
                                               finished:^(EnumServerStatus status, NSObject *object) {
                                                   [MBProgressHUD hideHUD];
                                                   if (status==0) {
                                                       if ([((ResponseObject *)object).errrorCode isEqualToString:@"0"]) {
                                                           if (i == self.imgs.count - 1) {
//                                                               if (self.DoBlock) {
//                                                                   self.DoBlock();
//                                                               }
                                                           }
                                                           [MBProgressHUD hideHUD];
                                                           
                                                       }
                                                   }
                                               }];
        }
        
    } else {
//        if (self.DoBlock) {
//            self.DoBlock();
//        }
    }
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row > 0) {
        if (indexPath.row > 2) {
            imgsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"imgsCell"];
            cell.imgs = self.imgs;
            CGSize size = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
            return size.height + 1;
        }
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
        if (indexPath.row > 2) {
            imgsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"imgsCell"];
            cell.imgs = self.imgs;
            cell.DeleteBlock = ^(NSInteger index) {
                [self.imgs removeObjectAtIndex:index];
                [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            };
            return cell;
        }
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
        SelectSViewController *selecteSVC = [[SelectSViewController alloc] init];
        selecteSVC.OCID = self.OCID;
        selecteSVC.selectedBlcok = ^(ForumTypeInfo *forumType) {
            self.forumType = forumType;
            NTCell1 *cell = (NTCell1 *)[tableView cellForRowAtIndexPath:indexPath];
            cell.desLabel.text = forumType.Title;
            [self.datas replaceObjectAtIndex:indexPath.row withObject:forumType.Title];
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
- (IBAction)bomBtnClick:(id)sender {
    UIButton *btn = (UIButton *)sender;
    switch (btn.tag) {
        case 1:
        {
            [self openCamera];
        
        }
            break;
        case 2:
        {
            [self openPhotoLibrary];
        
        }
            break;
            
        default:
            break;
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

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo {

    [self.imgs addObject:image];
    imgsCell *cell = (imgsCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    cell.imgs = self.imgs;
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:3 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    [self dismissImagePickerController];
}

- (void)imagePickerController:(QBImagePickerController *)imagePickerController didSelectAssets:(NSArray *)assets {
    NSLog(@"*** imagePickerController:didSelectAssets:");
    NSLog(@"%@", assets);
    NSMutableArray *imgs = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i=0; i<assets.count; i++) {
        UIImage *img = [UIImage imageWithCGImage:[assets[i] aspectRatioThumbnail]];
        [imgs addObject:img];
    }
    [self.imgs addObjectsFromArray:imgs];
    imgsCell *cell = (imgsCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    cell.imgs = self.imgs;
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:3 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
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
