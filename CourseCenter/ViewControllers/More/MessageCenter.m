//
//  MessageCenter.m
//  CourseCenter
//
//  Created by 2345 on 15/7/13.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "MessageCenter.h"
#import "MessageCenterCell.h"
#import "ChatViewController.h"
#import "NewMessage.h"
@interface MessageCenter ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation MessageCenter

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"消息中心";
    [self setupCustomRightWithImage:[UIImage imageNamed:@"notification_add"] target:self action:@selector(addMessage)];
    [self.tableView registerNib:[UINib nibWithNibName:@"MessageCenterCell" bundle:nil] forCellReuseIdentifier:@"MessageCenterCell"];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageCenterCell *cell=[_tableView dequeueReusableCellWithIdentifier:@"MessageCenterCell"];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //点击松开后,颜色恢复
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ChatViewController *chat=[[ChatViewController alloc]init];
    [((AppDelegate *)app).nav pushViewController:chat animated:YES];
}
-(void)addMessage
{
    NewMessage *newMessage=[[NewMessage alloc]init];
    [((AppDelegate *)app).nav pushViewController:newMessage animated:YES];
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
