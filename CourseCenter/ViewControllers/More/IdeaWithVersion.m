//
//  IdeaWithVersion.m
//  CourseCenter
//
//  Created by 2345 on 15/7/13.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "IdeaWithVersion.h"
#import "IQKeyboardManager.h"
@interface IdeaWithVersion ()
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *pLable;

@end

@implementation IdeaWithVersion

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if ([_isIdea isEqualToString:@"YES"]) {
        self.title=@"新版吐槽";
        [self setupCustomRightWithtitle:@"保存" target:self action:@selector(sendIdea)];
        self.textView.text=@"";
    }else
    {
        self.title=@"更新日志";
        [self setupCustomRightWithtitle:nil target:nil action:nil];
    }
}

-(void)sendIdea
{
    
}
- (void)textViewDidChange:(UITextView *)textView
{
    
    if (textView.text.length>0)
    {
        _pLable.hidden = YES;
        
    }else if(textView.text.length==0)
    {
        _pLable.hidden = NO;
        
    }else if (textView.text.length>0)
    {
        _pLable.hidden=YES;
        
    }else if (textView.text.length==0)
    {
        _pLable.hidden=NO;
    }
    
    
}
-(void)viewDidAppear:(BOOL)animated
{
    IQKeyboardManager *iqKey=[IQKeyboardManager sharedManager];
    iqKey.enable=NO;
}
-(void)viewDidDisappear:(BOOL)animated
{
    IQKeyboardManager *iqKey=[IQKeyboardManager sharedManager];
    iqKey.enable=YES;
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
