//
//  SendMsgViewController.m
//  CourseCenter
//
//  Created by rxj on 15/9/14.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "SendMsgViewController.h"
#import "TextViewCell.h"
#import "NewMsgCell1.h"
#import "imgsCell.h"
#import "QBImagePickerController.h"
#import "SelectSViewController.h"
#import "GTMBase64.h"
@interface SendMsgViewController ()<UITextViewDelegate,QBImagePickerControllerDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property(nonatomic, strong) NSMutableArray *datas;
@property(nonatomic, strong) NSString *updatedStr;
@property(nonatomic, strong) ForumTypeInfo *forumType;

@property(nonatomic, strong) CCHttpManager *manager;

@property(nonatomic, strong) NSMutableArray *imgs;
@property(nonatomic, assign) long topicId;
@property(nonatomic, strong) NSMutableArray *placeholds;
@property(nonatomic,strong)NSMutableArray *tags;
@property (strong,nonatomic)ResponseObject *reob;

@end

@implementation SendMsgViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"新建消息";
    _tags=[[NSMutableArray alloc]init];
    [self.tableView registerNib:[UINib nibWithNibName:@"NewMsgCell1" bundle:nil] forCellReuseIdentifier:@"NewMsgCell1"];
    [self.tableView registerNib:[UINib nibWithNibName:@"TextViewCell" bundle:nil] forCellReuseIdentifier:@"TextViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"imgsCell" bundle:nil] forCellReuseIdentifier:@"imgsCell"];
    self.datas = [[NSMutableArray alloc] initWithArray:@[@"",@"",@""]];
    self.placeholds = [[NSMutableArray alloc] initWithArray:@[@"",@"请输入标题(可不填)",@"请输入内容(必填)"]];
    self.imgs = [[NSMutableArray alloc] initWithCapacity:0];
    [self addNavItem];
    [self initManager];
   
}

-(NSMutableArray *)returnSelectArray
{
    NSMutableArray *mArray=[[NSMutableArray alloc]init];
    for (int i=0; i<((AppDelegate *)app).dicData.count; i++) {
        NSArray *array=[((AppDelegate *)app).dicData objectForKey:[NSString stringWithFormat:@"%d",i]];
        for (int j=0; j<array.count; j++) {
            if ([array[j]isEqualToString:@"SEL"]) {
                [mArray addObject:[((NSArray *)[_array objectAtIndex:i])objectAtIndex:j]];
            }
        }
    }
    return mArray;
}
- (void)initManager {
    self.manager = [CCHttpManager new];
    [self loadData];
    
}

-(void)loadData
{
    NSMutableArray *muArray=[self returnSelectArray];
    for (int i=0; i<muArray.count; i++) {
        NSString *name=[muArray[i] objectForKey:@"UserName"];
        [_tags addObject:name];
    }
}

- (void)addNavItem {
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(done)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
}

- (void)done {
    if ([self.datas[1] isEqualToString:@"请输入标题(可不填)"] || [self.datas[1] isEqualToString:@""]) {
        [MBProgressHUD showError:@"请输入标题"];
        return;
    }
    if ([self.datas[1] length] >= 50) {
        [MBProgressHUD showError:@"标题过长"];
        return;
    }
    if ([self.datas[2] isEqualToString:@"请输入内容(必填)"] || [self.datas[2] isEqualToString:@""]) {
        [MBProgressHUD showError:@"请输入内容"];
        return;
    }
    [self sureMessage];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)sureMessage
{
    [MBProgressHUD showMessage:nil];
    __weak typeof(self) wself = self;
    __weak typeof(_messageCenter) wmsg = _messageCenter;
    [self.manager addAppMessageWithTitle:self.datas[1] Conten:self.datas[2] ReceiveUserIDs:[self getArrayId] finished:^(EnumServerStatus status, NSObject *object) {
        [MBProgressHUD hideHUD];
        if (status==0) {
            wself.reob=(ResponseObject *)object;
            if ([wself.reob.errrorCode isEqualToString:@"0"]) {
                [MBProgressHUD showSuccess:wself.reob.errorMessage];
                [wself.navigationController popToViewController:wmsg animated:YES];
                if (wself.imgs.count > 0) {
                    [wself upLoadImgs];
                }
            }
        }
        [MBProgressHUD showError:LOGINMESSAGE_F];
    }];
}

-(NSString *)getArrayId
{
    NewMsgCell1 *cell = (NewMsgCell1 *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    
    NSString *arrayIds=@"";
    NSString *string=nil;
    for (int i=0; i<cell.editingTagControl.data.count; i++) {
        string=[NSString stringWithFormat:@"%@,",[[cell.editingTagControl.data[i] objectForKey:@"UserID"]stringValue]];
        arrayIds=[arrayIds stringByAppendingString:string];
    }
    return arrayIds;
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
                                                           if (self.doBlock) {
                                                               self.doBlock();
                                                           }
                                                           
                                                       }
                                                       [MBProgressHUD hideHUD];
                                                       
                                                   }
                                               }
                                           }];
        }
        
    } else {
        if (self.doBlock) {
            self.doBlock();
        }
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
        cell.pleholdLabel.text = self.placeholds[indexPath.row];
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
        cell.pleholdLabel.text = self.placeholds[indexPath.row];
        cell.textView.text = self.datas[indexPath.row];
        return cell;
    }
    NewMsgCell1 *cell = [tableView dequeueReusableCellWithIdentifier:@"NewMsgCell1"];
    cell.tags = self.tags;
    cell.datas  = [self returnSelectArray];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        SelectSViewController *selecteSVC = [[SelectSViewController alloc] init];
        selecteSVC.OCID = self.OCID;
        selecteSVC.selectedBlcok = ^(ForumTypeInfo *forumType) {
            self.forumType = forumType;
//            NTCell1 *cell = (NTCell1 *)[tableView cellForRowAtIndexPath:indexPath];
//            cell.desLabel.text = forumType.Title;
//            [self.datas replaceObjectAtIndex:indexPath.row withObject:forumType.Title];
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
    textView.textColor = [UIColor blackColor];
    self.updatedStr = textView.text;
    TextViewCell *cell = (TextViewCell *)[[textView superview] superview];
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    [self.placeholds replaceObjectAtIndex:indexPath.row withObject:@""];
    cell.pleholdLabel.text = self.placeholds[indexPath.row];
    [self.datas replaceObjectAtIndex:indexPath.row withObject:self.updatedStr];
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
}

- (void)textViewDidChange:(UITextView *)textView {
    self.updatedStr = textView.text;
    TextViewCell *cell = (TextViewCell *)[[textView superview] superview];
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        //    if (indexPath.row == 1) {
        //        if (textView.text == nil || [textView.text isEqualToString:@""]) {
        //            [self.placeholds replaceObjectAtIndex:indexPath.row withObject:@"请输入标题，50字以内！"];
        //        } else {
        //            [self.placeholds replaceObjectAtIndex:indexPath.row withObject:@"请输入话题内容"];
        //        }
        //    }
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
        UIImage *img = [UIImage imageWithCGImage:[[assets[i] defaultRepresentation] fullResolutionImage]];
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
