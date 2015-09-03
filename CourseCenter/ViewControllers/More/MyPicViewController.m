//
//  MyPicViewController.m
//  CourseCenter
//
//  Created by 2345 on 15/9/3.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "MyPicViewController.h"
#import "UIImageView+WebCache.h"
@interface MyPicViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation MyPicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=self.picName;
    [_imageView sd_setImageWithURL:[NSURL URLWithString:_url]];
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
