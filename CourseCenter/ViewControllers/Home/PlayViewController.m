//
//  PlayViewController.m
//  CourseCenter
//
//  Created by 2345_muzhenhua on 15/6/28.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "PlayViewController.h"
#import <MediaPlayer/MediaPlayer.h>
static BOOL isFirst;
@interface PlayViewController ()
{
    MPMoviePlayerController *movie;
    NSTimer *timer10;
    NSTimer *timer60;
    NSTimer *timer;
}
@property(nonatomic, strong)CCHttpManager *httpManager;
@property (strong,nonatomic)ResponseObject *reob;
@end
@implementation PlayViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    isFirst=YES;
    self.httpManager = [[CCHttpManager alloc]init];
    if (_isNSBundle) {
     movie =[[MPMoviePlayerController alloc]initWithContentURL:[NSURL fileURLWithPath:self.playUrl]];
    }else{
     movie =[[MPMoviePlayerController alloc]initWithContentURL:[NSURL URLWithString:self.playUrl]];
    }
    [movie prepareToPlay];
    [movie.view setFrame:self.view.bounds];
    [movie setControlStyle:MPMovieControlStyleFullscreen];
    [movie setShouldAutoplay:YES];
    [self.view addSubview:movie.view];
    // 注册一个播放结束的通知
    [[NSNotificationCenter defaultCenter] addObserver:self
    selector:@selector(myMovieFinishedCallback:)name:MPMoviePlayerPlaybackDidFinishNotification
    object:movie];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(mediaPlayerPlaybackStateChange:) name:MPMoviePlayerPlaybackStateDidChangeNotification object:movie];
    [MBProgressHUD showMessage:@"视频加载中..."];
}
-(void)mediaPlayerPlaybackStateChange:(NSNotification *)notification{
    switch (movie.playbackState) {
        case MPMoviePlaybackStatePlaying:
            [MBProgressHUD hideHUD];
            if (isFirst&&_isRecord) {
                if (!(_ChapterID==0&&_FileID==0)) {
                    timer10=[NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(send10S) userInfo:nil repeats:YES];
                    timer60=[NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(send60S) userInfo:nil repeats:YES];
                    timer=[NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(send) userInfo:nil repeats:YES];
                }
                if (self.Seconds!=0) {
                    movie.currentPlaybackTime=+self.Seconds;
                }
                isFirst=NO;
            }
            if (_isRecord) {
                [self PlayOrPauseWith:1];
            }
    
            NSLog(@"正在播放...");
            break;
        case MPMoviePlaybackStatePaused:
            if (_isRecord) {
              [self PlayOrPauseWith:2];
            }
            NSLog(@"暂停播放...");
            break;
        case MPMoviePlaybackStateStopped:
            NSLog(@"停止播放...");
            break;
        default:
            NSLog(@"播放状态:%li",(long)movie.playbackState);
            break;
    }
}
-(void)myMovieFinishedCallback:(NSNotification*)notification
{
    //销毁播放通知
    [[NSNotificationCenter defaultCenter] removeObserver:self
     name:MPMoviePlayerPlaybackDidFinishNotification
     object:movie];
    [timer10 invalidate];
    timer10=nil;
    [timer60 invalidate];
    timer60=nil;
    [timer invalidate];
    timer=nil;
    [self dismissViewControllerAnimated:YES completion:^{
        [_tutorVC loadData];
    }];
}
-(void)send10S
{
    __block typeof(self) myself =self;
    [self.httpManager  addOCMoocStuFileTimeCountwithChapterID:_ChapterID FileID:_FileID TimeCount:10 finished:^(EnumServerStatus status, NSObject *object) {
        if (status==0) {
            myself.reob=(ResponseObject *)object;
            if ([myself.reob.errrorCode isEqualToString:@"0"]) {
                NSLog(@"10$-------%@",[NSDate date]);
                return ;
            }
        }
        [MBProgressHUD showError:LOGINMESSAGE_F];
    }];

}
-(void)send60S
{
    __block typeof(self) myself =self;
    [self.httpManager  addOCMoocStuFileStudyTimeswithChapterID:_OCID FileID:_FileID StudyTimes:60 finished:^(EnumServerStatus status, NSObject *object) {
        if (status==0) {
            myself.reob=(ResponseObject *)object;
            if ([myself.reob.errrorCode isEqualToString:@"0"]) {
                NSLog(@"60$-------%@",[NSDate date]);
                return ;
            }
        }
        [MBProgressHUD showError:LOGINMESSAGE_F];
    }];
}
-(void)send
{
    __block typeof(self) myself =self;
    [self.httpManager  addOCMoocStuFileSecondswithChapterID:_ChapterID FileID:_FileID Seconds:movie.currentPlaybackTime finished:^(EnumServerStatus status, NSObject *object) {
        if (status==0) {
            myself.reob=(ResponseObject *)object;
            if ([myself.reob.errrorCode isEqualToString:@"0"]) {
                return ;
            }
        }
        [MBProgressHUD showError:LOGINMESSAGE_F];
    }];
}
-(void)PlayOrPauseWith:(int)type
{
    __block typeof(self) myself =self;
    [self.httpManager  OCMoocStuFilePlayPausewithChapterID:_ChapterID
      FileID:_FileID PlayOrPause:type finished:^(EnumServerStatus status, NSObject *object) {
        if (status==0) {
            myself.reob=(ResponseObject *)object;
            if ([myself.reob.errrorCode isEqualToString:@"0"]) {
                return ;
            }
        }
        [MBProgressHUD showError:LOGINMESSAGE_F];
    }];
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
