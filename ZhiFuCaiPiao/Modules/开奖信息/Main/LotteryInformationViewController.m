//
//  LotteryInformationViewController.m
//  ZhiFuCaiPiao
//
//  Created by 张诗健 on 2017/6/15.
//  Copyright © 2017年 张诗健. All rights reserved.
//

#import "LotteryInformationViewController.h"
#import "CPHttpRequest.h"
#import "LotteryInfoCell.h"


@interface LotteryInformationViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end


@implementation LotteryInformationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [CPHttpRequest POST:@"http://route.showapi.com/44-3" parameters:@{@"showapi_appid":@"40668",@"showapi_sign":@"11b78d3201e244168488b95fd4c16af4",@"showapi_timestamp":[[NSDate date] toDateString],@"showapi_sign_method":@"md5",@"showapi_res_gzip":@"0",@"code":@"ssq"} target:self callBack:@selector(lotteryInfoCallBack:)];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
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
}


// 开奖信息查询
- (void)lotteryInfoCallBack:(NSDictionary *)result
{
    NSLog(@"------ %@",result);
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
