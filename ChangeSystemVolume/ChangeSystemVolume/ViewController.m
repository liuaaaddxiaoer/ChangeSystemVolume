//
//  ViewController.m
//  ChangeSystemVolume
//
//  Created by 刘小二 on 2018/10/19.
//  Copyright © 2018 刘小二. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UISlider *slider;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    MPVolumeView *v = [[MPVolumeView alloc] initWithFrame:CGRectMake(-100, -100, 50, 50)];
    [self.view addSubview:v];
    
    // 这个通知可以监听系统音量的改变 但是注意必须初始化MPVolumeView否则无法监听到通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(volumeDidChangeNotification) name:@"AVSystemController_SystemVolumeDidChangeNotification" object:nil];
    
    // 设置active
    [[AVAudioSession sharedInstance] setActive:YES error:NULL];
    // 设置kvo监听系统音量的改变
    [[AVAudioSession sharedInstance] addObserver:self forKeyPath:@"outputVolume" options:NSKeyValueObservingOptionNew context:NULL];
    
    // init slider value
    self.slider.value = [AVAudioSession sharedInstance].outputVolume;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    self.slider.value = [change[NSKeyValueChangeNewKey] floatValue];
}

- (void)volumeDidChangeNotification {
    NSLog(@"----");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)changeVolume:(UISlider *)sender {
    [MPMusicPlayerController systemMusicPlayer].volume = sender.value;
}


@end
