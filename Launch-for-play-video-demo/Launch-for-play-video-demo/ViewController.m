//
//  ViewController.m
//  demo
//
//  Created by star on 15/7/8.
//  Copyright (c) 2015年 ZB. All rights reserved.
//

#import "ViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface ViewController ()

@property (nonatomic, strong) MPMoviePlayerController *player;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self playMyVedio];
}

- (void)viewWillAppear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(myMovieFinishedCallback:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:self.player];
}

- (void)viewWillDisappear:(BOOL)animated {
    //销毁播放通知
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:MPMoviePlayerPlaybackDidFinishNotification
                                                  object:self.player];
    [self.player.view removeFromSuperview];
}

-(void)playMyVedio{
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *moviePath = [bundle pathForResource:@"donghua" ofType:@"mp4"];
    NSURL *movieURL = [NSURL fileURLWithPath:moviePath];
    self.player =[[MPMoviePlayerController alloc] initWithContentURL:movieURL];
    [self.player setControlStyle:MPMovieControlStyleNone];
    [self.player prepareToPlay];
    [self.player.view setFrame:self.view.bounds];  // player的尺寸
    [self.view addSubview: self.player.view];
    self.player.shouldAutoplay=YES;
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.backgroundColor = [UIColor yellowColor];
    button1.frame = CGRectMake(100, 500, 100, 40);
    [self.view addSubview:button1];
    [button1 addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)click {
    NSLog(@"click");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//#pragma mark -------------------视频播放结束委托--------------------
//
///*
// @method 当视频播放完毕释放对象
// */
-(void)myMovieFinishedCallback:(NSNotification*)notify
{
    //视频播放对象
    MPMoviePlayerController* theMovie = [notify object];
    //    // 释放视频对象
    [theMovie play];
}

@end
