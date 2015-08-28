//
//  ViewController.m
//  CourseCenter
//
//  Created by renxiaojian on 15/5/26.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "ViewController.h"
#import "SchoolInfo.h"
@interface ViewController ()
{
    UISearchBar *mySearchBar;
    UISearchDisplayController *searchDC;
    NSInteger selectNumber;
    BOOL isTableView;

}
@property(nonatomic, strong) CCHttpManager * httpManager;
@property(nonatomic, strong) ResponseObject *reob;
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,strong)NSMutableArray *dataResult;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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
