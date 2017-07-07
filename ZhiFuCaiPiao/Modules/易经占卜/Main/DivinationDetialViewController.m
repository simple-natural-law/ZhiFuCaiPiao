//
//  DivinationDetialViewController.m
//  ZhiFuCaiPiao
//
//  Created by 张诗健 on 2017/7/6.
//  Copyright © 2017年 张诗健. All rights reserved.
//

#import "DivinationDetialViewController.h"
#import <AudioToolbox/AudioToolbox.h>


@interface DivinationDetialViewController ()<CAAnimationDelegate>
{
    SystemSoundID _soundId;
}

@property (weak, nonatomic) IBOutlet UIImageView *guikeImageView;

@property (weak, nonatomic) IBOutlet UIImageView *qianbiIcon1;

@property (weak, nonatomic) IBOutlet UIImageView *qianbiIcon2;

@property (weak, nonatomic) IBOutlet UIImageView *qianbiIcon3;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *centerXCons1;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *centerXCons3;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomCons;

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
    self.centerXCons1.constant = 0.0;
    self.centerXCons3.constant = 0.0;
    self.bottomCons.constant   = -5.0;
    [self.view layoutIfNeeded];
    
    [self startShakeAnimation];
    
    [self playSound];
}

#pragma mark- methods
- (void)startShakeAnimation
{
    [self.guikeImageView.layer removeAnimationForKey:@"shake"];
    
    CABasicAnimation *shakeAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    shakeAnimation.delegate  = self;
    shakeAnimation.fromValue = [NSNumber numberWithFloat:+0.1];
    shakeAnimation.toValue   = [NSNumber numberWithFloat:-0.1];
    shakeAnimation.duration  = 0.1;
    shakeAnimation.autoreverses = YES; //是否重复
    shakeAnimation.repeatCount  = 2;
    shakeAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [self.guikeImageView.layer addAnimation:shakeAnimation forKey:@"shake"];
}

- (void)startGuaXiangAnimationWithGuaXiangArr:(NSArray *)array
{
    [self setImageWithGuaXiangArr:array];
    
    self.centerXCons1.constant = -80.0;
    self.centerXCons3.constant = 80.0;
    self.bottomCons.constant   = 120.0;
    
    [UIView animateWithDuration:1.0 animations:^{
        
        [self.view layoutIfNeeded];
        
    } completion:^(BOOL finished) {
        
        if (finished)
        {
            
        }
    }];
    
    [UIView animateWithDuration:0.2 delay:0.4 options:0 animations:^{
        
        CATransform3D transform3D = CATransform3DRotate(self.qianbiIcon1.layer.transform, M_PI*3, 1, 0, 0);
        self.qianbiIcon1.layer.transform = transform3D;
        self.qianbiIcon2.layer.transform = transform3D;
        self.qianbiIcon3.layer.transform = transform3D;
        
    } completion:^(BOOL finished) {
        
        if (finished)
        {
            [UIView animateWithDuration:0.4 animations:^{
                
                CATransform3D transform3D = CATransform3DRotate(self.qianbiIcon1.layer.transform, M_PI*3, 1, 0, 0);
                self.qianbiIcon1.layer.transform = transform3D;
                self.qianbiIcon2.layer.transform = transform3D;
                self.qianbiIcon3.layer.transform = transform3D;
            }];
        }
    }];
}

// 0-正面 1-反面
- (void)setImageWithGuaXiangArr:(NSArray *)array
{
    self.qianbiIcon1.image = [array[0] integerValue] == 0 ? [UIImage imageNamed:@"qiugua_qianbi_zi"] : [UIImage imageNamed:@"qiugua_qianbi_hua"];
    
    self.qianbiIcon2.image = [array[1] integerValue] == 0 ? [UIImage imageNamed:@"qiugua_qianbi_zi"] : [UIImage imageNamed:@"qiugua_qianbi_hua"];
    
    self.qianbiIcon3.image = [array[2] integerValue] == 0 ? [UIImage imageNamed:@"qiugua_qianbi_zi"] : [UIImage imageNamed:@"qiugua_qianbi_hua"];
}

// 播放摇动声音
- (void)playSound
{
    AudioServicesPlaySystemSound(_soundId);
}

#pragma mark- CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (flag)
    {
        [self startGuaXiangAnimationWithGuaXiangArr:@[@(0),@(1),@(0)]];
    }
}


#pragma mark- ShakeToEdit
// 开始摇动
- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (motion == UIEventSubtypeMotionShake)
    {
        self.centerXCons1.constant = 0.0;
        self.centerXCons3.constant = 0.0;
        self.bottomCons.constant   = -5.0;
        [self.view layoutIfNeeded];
        
        [self startShakeAnimation];
        
        [self playSound];
    }
}

// 摇动结束
- (void)motionEnded:(UIEventSubtype)motion withEvent:(nullable UIEvent *)event
{
    if (motion == UIEventSubtypeMotionShake)
    {
        [self startGuaXiangAnimationWithGuaXiangArr:@[@(0),@(1),@(0)]];
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
