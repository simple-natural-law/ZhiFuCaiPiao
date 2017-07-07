//
//  DivinationDetialViewController.m
//  ZhiFuCaiPiao
//
//  Created by 张诗健 on 2017/7/6.
//  Copyright © 2017年 张诗健. All rights reserved.
//

#import "DivinationDetialViewController.h"
#import <AudioToolbox/AudioToolbox.h>


@interface DivinationDetialViewController ()
{
    SystemSoundID _soundId;
}
@property (weak, nonatomic) IBOutlet UIImageView *guikeImageView;

@end

@implementation DivinationDetialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    NSString *urlPath = [[NSBundle mainBundle] pathForResource:@"zyyc_yao_sound" ofType:@"mp3"];
    
    NSURL *url = [NSURL fileURLWithPath:urlPath];
    
    AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &_soundId);
    
    [[UIApplication sharedApplication] setApplicationSupportsShakeToEdit:YES];
    
    [self becomeFirstResponder];
}



- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[UIApplication sharedApplication] setApplicationSupportsShakeToEdit:NO];
    
    [self resignFirstResponder];
    
    AudioServicesDisposeSystemSoundID(_soundId);  // 释放自定义系统声音
}



- (IBAction)tapAction:(id)sender
{
    [self startShakeAnimation];
    
    [self playSound];
}

- (void)startShakeAnimation
{
    CABasicAnimation *shakeAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    shakeAnimation.fromValue = [NSNumber numberWithFloat:+0.1];
    shakeAnimation.toValue = [NSNumber numberWithFloat:-0.1];
    shakeAnimation.duration = 0.1;
    shakeAnimation.autoreverses = YES; //是否重复
    shakeAnimation.repeatCount = 2;
    shakeAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [self.guikeImageView.layer addAnimation:shakeAnimation forKey:@"shake"];
}

- (void)playSound
{
    AudioServicesPlaySystemSound(_soundId);
}


#pragma mark- ShakeToEdit
// 开始摇动
- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (motion == UIEventSubtypeMotionShake)
    {
        [self startShakeAnimation];
    }
}

// 摇动结束
- (void)motionEnded:(UIEventSubtype)motion withEvent:(nullable UIEvent *)event
{
    if (motion == UIEventSubtypeMotionShake)
    {
        [self playSound];
    }
}

// 摇动取消
- (void)motionCancelled:(UIEventSubtype)motion withEvent:(nullable UIEvent *)event
{
    
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
