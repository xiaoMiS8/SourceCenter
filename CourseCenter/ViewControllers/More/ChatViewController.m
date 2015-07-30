//
//  ChatViewController.m
//  CourseCenter
//
//  Created by 2345 on 15/7/13.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//
#import "ChatViewController.h"
#import "MessageModel.h"
#import "CellFrameModel.h"
#import "MessageCell.h"
#import "IQKeyboardManager.h"
#import "MsgInfo.h"
#define kToolBarH 44
#define kTextFieldH 30

@interface ChatViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
{
    NSMutableArray *_cellFrameDatas;
    UITableView *_chatView;
    UIImageView *_toolBar;
    
}
@property(nonatomic, strong)CCHttpManager *httpManager;
@property (strong,nonatomic)ResponseObject *reob;
@property (nonatomic,strong)NSMutableArray *myDataArray;
@end

@implementation ChatViewController
-(void)viewWillAppear:(BOOL)animated
{
    IQKeyboardManager *iqM=[IQKeyboardManager sharedManager];
    iqM.enable=NO;
}
-(void)viewWillDisappear:(BOOL)animated
{
    IQKeyboardManager *iqM=[IQKeyboardManager sharedManager];
    iqM.enable=YES;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"林媚";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    self.httpManager = [[CCHttpManager alloc]init];
    self.myDataArray=[[NSMutableArray alloc]init];
    [self initMsg];
    //1.tableView
    [self addChatView];
    //2.工具栏
    [self addToolBar];
}
-(void)initMsg
{
    [MBProgressHUD showMessage:nil];
    [self.httpManager getAppMessageWithUserID:183 finished:^(EnumServerStatus status, NSObject *object) {
        [MBProgressHUD hideHUD];
        if (status==0) {
            self.reob=(ResponseObject *)object;
            if ([self.reob.errrorCode isEqualToString:@"0"]) {
                self.myDataArray=self.reob.resultArray;
                [self readDataForPlistWithArray:self.reob.resultArray];
                //0.加载数据
                [self loadData];
                [_chatView reloadData];
                return ;
            }
        }
        [MBProgressHUD showError:LOGINMESSAGE_F];
    }];
}
-(void)readDataForPlistWithArray:(NSMutableArray *)array
{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"messages" ofType:@"plist"];
    NSMutableArray *data = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
    [data removeAllObjects];
    [data writeToFile:plistPath atomically:YES];
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    for (int i=0; i<array.count;i++) {
        [dic setObject:((MsgInfo *)array[i]).Conten forKey:@"text"];
        [dic setObject:((MsgInfo *)array[i]).CreateTime forKey:@"time"];
        [dic setObject:((MsgInfo *)array[i]).SendOrReceive forKey:@"type"];
        [data addObject:dic];
    }
    [data writeToFile:plistPath atomically:YES];

}
/**
 *  记载数据
 */
- (void)loadData
{
    _cellFrameDatas =[NSMutableArray array];
    NSURL *dataUrl = [[NSBundle mainBundle] URLForResource:@"messages.plist" withExtension:nil];
    NSArray *dataArray = [NSArray arrayWithContentsOfURL:dataUrl];
    for (NSDictionary *dict in dataArray) {
        MessageModel *message = [MessageModel messageModelWithDict:dict];
        CellFrameModel *lastFrame = [_cellFrameDatas lastObject];
        CellFrameModel *cellFrame = [[CellFrameModel alloc] init];
        message.showTime = ![message.time isEqualToString:lastFrame.message.time];
        cellFrame.message = message;
        [_cellFrameDatas addObject:cellFrame];
    }
}
/**
 *  添加TableView
 */
- (void)addChatView
{
    self.view.backgroundColor = [UIColor colorWithRed:235.0/255 green:235.0/255 blue:235.0/255 alpha:1.0];
    UITableView *chatView = [[UITableView alloc] init];
    chatView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - kToolBarH-44);
    chatView.backgroundColor = [UIColor colorWithRed:235.0/255 green:235.0/255 blue:235.0/255 alpha:1.0];
    chatView.delegate = self;
    chatView.dataSource = self;
    chatView.separatorStyle = UITableViewCellSeparatorStyleNone;
    chatView.allowsSelection = NO;
    [chatView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endEdit)]];
    _chatView = chatView;
    
    [self.view addSubview:chatView];
}
/**
 *  添加工具栏
 */
- (void)addToolBar
{
    UIImageView *bgView = [[UIImageView alloc] init];
    bgView.frame = CGRectMake(0, self.view.frame.size.height - kToolBarH-44, self.view.frame.size.width, kToolBarH);
    bgView.image = [UIImage imageNamed:@"chat_bottom_bg"];
    bgView.userInteractionEnabled = YES;
    _toolBar = bgView;
    [self.view addSubview:bgView];
    
    UIButton *sendSoundBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sendSoundBtn.frame = CGRectMake(0, 0, kToolBarH, kToolBarH);
    [sendSoundBtn setImage:[UIImage imageNamed:@"chat_bottom_voice_nor"] forState:UIControlStateNormal];
    [bgView addSubview:sendSoundBtn];
    
    UIButton *addMoreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addMoreBtn.frame = CGRectMake(self.view.frame.size.width - kToolBarH, 0, kToolBarH, kToolBarH);
    [addMoreBtn setImage:[UIImage imageNamed:@"chat_bottom_up_nor"] forState:UIControlStateNormal];
    [bgView addSubview:addMoreBtn];
    
    UIButton *expressBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    expressBtn.frame = CGRectMake(self.view.frame.size.width - kToolBarH * 2, 0, kToolBarH, kToolBarH);
    [expressBtn setImage:[UIImage imageNamed:@"chat_bottom_smile_nor"] forState:UIControlStateNormal];
    [bgView addSubview:expressBtn];
    
    UITextField *textField = [[UITextField alloc] init];
    textField.returnKeyType = UIReturnKeySend;
    textField.enablesReturnKeyAutomatically = YES;
    textField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 1)];
    textField.leftViewMode = UITextFieldViewModeAlways;
    textField.frame = CGRectMake(kToolBarH, (kToolBarH - kTextFieldH) * 0.5, self.view.frame.size.width - 3 * kToolBarH, kTextFieldH);
    textField.background = [UIImage imageNamed:@"chat_bottom_textfield"];
    textField.delegate = self;
    [bgView addSubview:textField];
}

#pragma mark - tableView的数据源和代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _cellFrameDatas.count;
}

- (MessageCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    
    MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[MessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.dic=[_myDataArray objectAtIndex:indexPath.row];
    cell.cellFrame = _cellFrameDatas[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CellFrameModel *cellFrame = _cellFrameDatas[indexPath.row];
    return cellFrame.cellHeght;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

#pragma mark - UITextField的代理方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //1.获得时间
    NSDate *senddate=[NSDate date];
    NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"HH:mm"];
    NSString *locationString=[dateformatter stringFromDate:senddate];
    
    //2.创建一个MessageModel类
    MessageModel *message = [[MessageModel alloc] init];
    message.text = textField.text;
    message.time = locationString;
    message.type = 0;
    
    //3.创建一个CellFrameModel类
    CellFrameModel *cellFrame = [[CellFrameModel alloc] init];
    CellFrameModel *lastCellFrame = [_cellFrameDatas lastObject];
    message.showTime = ![lastCellFrame.message.time isEqualToString:message.time];
    cellFrame.message = message;
    
    //4.添加进去，并且刷新数据
    [_cellFrameDatas addObject:cellFrame];
    [_chatView reloadData];
    
    //5.自动滚到最后一行
    NSIndexPath *lastPath = [NSIndexPath indexPathForRow:_cellFrameDatas.count - 1 inSection:0];
    [_chatView scrollToRowAtIndexPath:lastPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    
    textField.text = @"";
    
    return YES;
}

- (void)endEdit
{
    [self.view endEditing:YES];
}

/**
 *  键盘发生改变执行
 */
- (void)keyboardWillChange:(NSNotification *)note
{
    NSLog(@"%@", note.userInfo);
    NSDictionary *userInfo = note.userInfo;
    CGFloat duration = [userInfo[@"UIKeyboardAnimationDurationUserInfoKey"] doubleValue];
    
    CGRect keyFrame = [userInfo[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
    CGFloat moveY = keyFrame.origin.y - self.view.frame.size.height-44;
    
    [UIView animateWithDuration:duration animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(0, moveY);
    }];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
