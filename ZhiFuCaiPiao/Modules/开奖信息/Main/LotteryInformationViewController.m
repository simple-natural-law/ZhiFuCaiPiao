//
//  LotteryInformationViewController.m
//  ZhiFuCaiPiao
//
//  Created by 张诗健 on 2017/6/15.
//  Copyright © 2017年 张诗健. All rights reserved.
//

#import "LotteryInformationViewController.h"
#import "LotteryInfoCell.h"


@interface LotteryInformationViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (strong, nonatomic) NSMutableArray *dataArr;

@end


@implementation LotteryInformationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArr.count+1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BannerCell" forIndexPath:indexPath];
        return cell;
    }else
    {
        LotteryInfoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LotteryInfoCell" forIndexPath:indexPath];
        NSDictionary *info = self.dataArr[indexPath.row - 1];
        cell.iconImageView.image   = [UIImage imageNamed:info[@"icon"]];
        cell.titleLabel.text       = info[@"title"];
        cell.descriptionLabel.text = info[@"description"];
        return cell;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        return CGSizeMake(kScreenWidth, kScreenWidth*0.59);
    }else
    {
        return CGSizeMake(kScreenWidth/2.0, 90.0);
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.0;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0)
    {
        
    }else
    {
        [self pushViewControllerKey:@"LotteryHistoryViewController" param:@{@"id":self.dataArr[indexPath.row-1][@"caipiaoid"],@"title":self.dataArr[indexPath.row-1][@"title"]} animated:YES];
    }
}

- (NSMutableArray *)dataArr
{
    if (_dataArr == nil)
    {
        _dataArr = [[NSMutableArray alloc] initWithObjects:@{@"title":@"双色球",@"description":@"每周二 四 日的21:15开奖",@"icon":@"shuangseqiu",@"caipiaoid":@(11)}, @{@"title":@"超级大乐透",@"description":@"每周一 三 六的20:30开奖",@"icon":@"daletou",@"caipiaoid":@(14)},@{@"title":@"福彩3D",@"description":@"每天的21:20开奖",@"icon":@"fucai3d",@"caipiaoid":@(12)},@{@"title":@"排列3",@"description":@"每天的20:30开奖",@"icon":@"pailiesan",@"caipiaoid":@(16)},@{@"title":@"排列5",@"description":@"每天的20:30开奖",@"icon":@"paliewu",@"caipiaoid":@(17)},@{@"title":@"七乐彩",@"description":@"每周一 三 五的21:15开奖",@"icon":@"7lecai",@"caipiaoid":@(13)},@{@"title":@"七星彩",@"description":@"每周二 五 日的20:30开奖",@"icon":@"7cai",@"caipiaoid":@(15)},@{@"title":@"新疆时时彩",@"description":@"每天96期,10:10起每10分钟一期",@"icon":@"xjssc",@"caipiaoid":@(90)},@{@"title":@"快3-湖北",@"description":@"每天78期,09:10起每10分钟一期",@"icon":@"k3",@"caipiaoid":@(80)},@{@"title":@"11选5-广东",@"description":@"每天84期,09:10起每10分钟一期",@"icon":@"gd11x5",@"caipiaoid":@(71)},nil];
    }
    return _dataArr;
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
