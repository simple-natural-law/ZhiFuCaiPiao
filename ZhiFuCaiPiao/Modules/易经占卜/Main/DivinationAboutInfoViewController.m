//
//  DivinationAboutInfoViewController.m
//  ZhiFuCaiPiao
//
//  Created by 张诗健 on 2017/7/13.
//  Copyright © 2017年 张诗健. All rights reserved.
//

#import "DivinationAboutInfoViewController.h"

@interface DivinationAboutInfoViewController ()

@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labelHeightCons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labelWidthCons;

@end

@implementation DivinationAboutInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.labelWidthCons.constant = kScreenWidth - 20.0;
    
    NSString *str = @"六爻八卦预测，是起源于周朝时期。六爻就是预测人将三枚铜钱放于手中，双手紧扣，思其所测之事，让所测信息融贯于铜钱之中，合掌摇晃后放入卦盘中，掷六次而成卦。配以卦爻，及动变以后。结合易经的爻辞，以及时间的干支。而判断事物的发展过程和结果。六爻是民间流传最广的预测方法之一，其变化有梅花易数，观音神课，以及文王六十四卦的断法。相对于正宗的六爻断法又要简单许多。\r\n\r\n爻的本义是“交”、“效”，综横之交、阴阳之交，“效”则是通过“交”所产生的“效用”，可以通过全局计算来衡量，依不同方法、体系、定位立极，有相应不同解释。\r\n\r\n爻（国音姚，yao2; 粤音肴，?au），《易经》八卦的两个符号，一个是“—”，另一个是“--”。在《易经》中并没有“阴阳”二字，数百年后的《易传》才把“—”叫阳爻，把“--”叫阴爻。八卦是以阴阳符号反映客观现象。二爻的本义是什么，有多种看法。有人认为，“爻”，皎也。一指日光，二指月光，三指交会（日月交会投射）。“爻”代表着阴阳气化，由于“爻”之动而有卦之变，故“爻”是气化的始祖。“—”性刚属阳，“--”性柔属阴。万物的性能即由这阴阳二气演化而来。有人认为，“—”代表男性生殖器，“--”代表女性生殖器。钱玄同，郭沫若，潘国静即持此说。\r\n\r\n六爻，既可以指从下向上排列的六个阴阳符号的组合，也泛指借用这种组合进行占卜的方法。在最下面的符号称为“初爻”，最上面的符号称为“上爻”，其间从下向上依次为二三四五爻。阳爻‘―’（一长横）又称‘九’，阴爻‘--’（两短横，中间有空格）又称‘六’，如果初爻是阳爻，那么初爻也可以说成“初九”；如果“上爻”是阴爻，那么“上爻”也可以说成“上六”。\r\n\r\n初爻加二三爻成一个“卦”，称为“内卦”，也称为“下卦”；四五爻加六爻成另一个“卦”，称为“外卦”，也称为“上卦”。\r\n\r\n六爻预测，包括纳甲法和梅花易数两种不同方法，纳甲将六个爻结合天干地支五行六亲世应及神煞等众多因素来预测，而梅花易数比较简便，主要依据内外卦、体用卦、互变卦及爻辞等来预测。";
    
    CGFloat height = [str boundingRectWithSize:CGSizeMake(kScreenWidth-24.0, 0.0) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17.0]} context:nil].size.height+20.0;
    
    self.labelHeightCons.constant = height - 10;
    
    self.label.text = str;
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
