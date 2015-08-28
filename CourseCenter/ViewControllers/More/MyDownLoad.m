//
//  MyDownLoad.m
//  CourseCenter
//
//  Created by muzhenhua on 15/8/28.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "MyDownLoad.h"
#import "FileModel.h"

@interface MyDownLoad ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic)NSMutableArray *arrayData;
@end

@implementation MyDownLoad

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"我的下载";
    self.tableView.tableFooterView=[[UIView alloc]init];
    [self loadFinishedfiles];
}
-(void)loadFinishedfiles
{
    _arrayData=[[NSMutableArray alloc]init];
    NSString *document = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *plistPath = [[document stringByAppendingPathComponent:BASEPATH]stringByAppendingPathComponent:@"finishPlist.plist"];
    if ([[NSFileManager defaultManager]fileExistsAtPath:plistPath]) {
        NSMutableArray *finishArr = [[NSMutableArray alloc]initWithContentsOfFile:plistPath];
        for (NSDictionary *dic in finishArr) {
            FileModel *file = [[FileModel alloc]init];
            file.fileID=[dic objectForKey:@"fileid"];
            file.ChapterID=[[dic objectForKey:@"chapterid"]intValue];
            file.fileName = [dic objectForKey:@"filename"];
            file.fileType = [dic objectForKey:@"filetype"];
            file.fileSize = [dic objectForKey:@"filesize"];
            file.targetPath = [dic objectForKey:@"filepath"];
            file.time = [dic objectForKey:@"time"];
            file.fileimage = [UIImage imageWithData:[dic objectForKey:@"fileimage"]];
            [_arrayData addObject:file];
        
        }
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _arrayData.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIndentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    FileModel *_fileModel= (FileModel *)[_arrayData objectAtIndex:indexPath.row];
    UIImage *image;
    if ([_fileModel.fileType integerValue]==1) {
        image=[UIImage imageNamed:@"icon_video2"];
    }else if([_fileModel.fileType integerValue]==2)
    {
        image=[UIImage imageNamed:@"word"];
    }else if([_fileModel.fileType integerValue]==3)
    {
        image=[UIImage imageNamed:@"excel"];
    }else if([_fileModel.fileType integerValue]==4)
    {
        image=[UIImage imageNamed:@"ppt"];
    }else if([_fileModel.fileType integerValue]==5)
    {
        image=[UIImage imageNamed:@"pdf"];
    }else if([_fileModel.fileType integerValue]==6)
    {
        image=[UIImage imageNamed:@"icon_photo"];
    }else if([_fileModel.fileType integerValue]==7)
    {
        image=[UIImage imageNamed:@"other"];
    }else if([_fileModel.fileType integerValue]==8)
    {
        image=[UIImage imageNamed:@"icon_document1"];
    }else if([_fileModel.fileType integerValue]==9)
    {
        image=[UIImage imageNamed:@"other"];
    }
    cell.imageView.image=image;
    cell.textLabel.text =_fileModel.fileName;
    return cell;
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (editingStyle==UITableViewCellEditingStyleDelete) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"确定要删除该文件吗?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
         alert.tag=indexPath.row;
        [alert show];
    }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1) {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSString *fileName=((FileModel *)[_arrayData objectAtIndex:alertView.tag]).fileName;
        NSString * targetPath=[CommonHelper getTargetPathWithBasepath:BASEPATH subpath:TARGER];
        NSString * fileNamePath=[targetPath stringByAppendingPathComponent:fileName];
        if ([fileManager fileExistsAtPath:fileNamePath]){
            [fileManager removeItemAtPath:fileNamePath error:nil];
            [self deleteFileWithFileName:fileName];
            [self loadFinishedfiles];
            [_tableView reloadData];
        }
    }
}

-(void)deleteFileWithFileName:(NSString *)fileName
{
    NSString *document = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *plistPath = [[document stringByAppendingPathComponent:BASEPATH]stringByAppendingPathComponent:@"finishPlist.plist"];
    if ([[NSFileManager defaultManager]fileExistsAtPath:plistPath]) {
        NSMutableArray *finishArray = [[NSMutableArray alloc]initWithContentsOfFile:plistPath];
        NSMutableArray *writeArray=[NSMutableArray arrayWithArray:finishArray];
        for (NSDictionary *dic in finishArray) {
            if ([fileName isEqualToString:[dic objectForKey:@"filename"]]) {
                [writeArray removeObject:dic];
            }
        }
        if (![writeArray writeToFile:plistPath atomically:YES]) {
            NSLog(@"write plist fail");
        }
    }

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
