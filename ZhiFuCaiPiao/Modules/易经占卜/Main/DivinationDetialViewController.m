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

@property (weak, nonatomic) IBOutlet UIImageView *guikeImageView;

@end

@implementation DivinationDetialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (IBAction)tapAction:(id)sender
{
    CABasicAnimation *shakeAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    shakeAnimation.fromValue = [NSNumber numberWithFloat:+0.1];
    shakeAnimation.toValue = [NSNumber numberWithFloat:-0.1];
    shakeAnimation.duration = 0.1;
    shakeAnimation.autoreverses = YES; //是否重复
    shakeAnimation.repeatCount = 2;
    shakeAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [self.guikeImageView.layer addAnimation:shakeAnimation forKey:@"shake"];
    
    NSString *urlPath = [[NSBundle mainBundle] pathForResource:@"zyyc_yao_sound" ofType:@"mp3"];
    
    NSURL *url = [NSURL fileURLWithPath:urlPath];
    
    SystemSoundID soundId;
    
    AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &soundId);
    
    AudioServicesPlaySystemSound(soundId);
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
