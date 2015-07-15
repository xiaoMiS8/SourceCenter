//
//  MyInfo.m
//  CourseCenter
//
//  Created by 2345 on 15/7/12.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "MyInfo.h"
#import "MyInfoCell.h"
@interface MyInfo ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation MyInfo

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"我的信息";
    [self setupCustomRightWithtitle:@"保存" target:self action:@selector(saveInfo)];
    [self.tableView registerNib:[UINib nibWithNibName:@"MyInfoCell" bundle:nil] forCellReuseIdentifier:@"MyInfoCell"];
}
-(void)saveInfo
{
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            return 100;
        case 4:
            return 150;
        default:
            return 50;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyInfoCell *cell=[_tableView dequeueReusableCellWithIdentifier:@"MyInfoCell"];
    cell.indexPath=indexPath;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        UIActionSheet *actionSheet=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从手机相册选择", nil];
        [actionSheet showInView:self.view];
    }
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            [self openCaremaAndPicLibraryWithIndex:buttonIndex];
            break;
        case 1:
            [self openCaremaAndPicLibraryWithIndex:buttonIndex];
            break;
        default:
            break;
    }
}
//打开相机
-(void)openCaremaAndPicLibraryWithIndex:(NSInteger)index
{
    BOOL isOK=(index==0)?[UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]:[UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary];
        if (isOK) {
            UIImagePickerController * picker = [[UIImagePickerController alloc]init];
            picker.delegate = self;
            picker.allowsEditing = YES;  //是否可编辑
            if (index==0) {
                //摄像头
                picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            }else
            {
                //打开相册选择照片
                picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            }
            [self presentViewController:picker animated:YES completion:nil];
        }else
        {
            //如果没有提示用户
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"打开摄像头或相册失败!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
        }
}
//拍摄完成后要执行的方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //得到图片
    UIImage * image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end