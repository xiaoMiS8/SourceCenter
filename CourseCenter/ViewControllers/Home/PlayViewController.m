//
//  PlayViewController.m
//  CourseCenter
//
//  Created by 2345_muzhenhua on 15/6/28.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "PlayViewController.h"
#import <MediaPlayer/MediaPlayer.h>
@interface PlayViewController ()
{
    MPMoviePlayerController *movie;
}
@end
@implementation PlayViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     movie =[[MPMoviePlayerController alloc]initWithContentURL:[NSURL URLWithString:self.playUrl]];
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
            NSLog(@"正在播放...");
            break;
        case MPMoviePlaybackStatePaused:
            NSLog(@"暂停播放.");
            break;
        case MPMoviePlaybackStateStopped:
            NSLog(@"停止播放.");
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
