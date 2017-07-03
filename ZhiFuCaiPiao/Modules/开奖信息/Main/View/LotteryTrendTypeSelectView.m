//
//  LotteryTrendTypeSelectView.m
//  ZhiFuCaiPiao
//
//  Created by 张诗健 on 2017/6/26.
//  Copyright © 2017年 张诗健. All rights reserved.
//

#import "LotteryTrendTypeSelectView.h"


@interface LotteryItemCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *iconImageView;

@end

@implementation LotteryItemCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        self.iconImageView = [[UIImageView alloc] init];
        self.iconImageView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:self.iconImageView];
        NSLayoutConstraint *widthCons_img = [NSLayoutConstraint constraintWithItem:self.iconImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:60.0];
        NSLayoutConstraint *heightCons_img = [NSLayoutConstraint constraintWithItem:self.iconImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:60.0];
        NSLayoutConstraint *centerXCons_img = [NSLayoutConstraint constraintWithItem:self.iconImageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];
        NSLayoutConstraint *centerYCons_img = [NSLayoutConstraint constraintWithItem:self.iconImageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0];
        [self.contentView addConstraints:@[widthCons_img,heightCons_img,centerXCons_img,centerYCons_img]];
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    
    [UIView animateWithDuration:0.2 animations:^{
        
        self.backgroundColor = highlighted ? [UIColor colorWithHexString:@"f0f0f0"] : [UIColor whiteColor];
    }];
}

@end



@interface LotteryTrendTypeSelectView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UIView *customView;

@property (nonatomic, strong) UIControl *background;

@property (nonatomic, weak) UIView *superView;

@property (nonatomic, copy) DidSelectedBlock block;

@end

@implementation LotteryTrendTypeSelectView

+ (instancetype)showInView:(UIView *)view didSelectedBlock:(DidSelectedBlock)block
{
    UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc] init];
    UICollectionView *contentView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 160*(kScreenWidth/375.0)+10.0) collectionViewLayout:flowlayout];
    contentView.backgroundColor = [UIColor whiteColor];
    
    LotteryTrendTypeSelectView *typeView = [[LotteryTrendTypeSelectView alloc] initWithCustomView:contentView superView:view didSelectedBlock:block];
    
    contentView.dataSource = typeView;
    contentView.delegate   = typeView;
    
    [contentView registerClass:[LotteryItemCell class] forCellWithReuseIdentifier:@"LotteryItemCell"];
    
    [typeView show];
    
    return typeView;
}



- (instancetype)initWithCustomView:(UIView *)customView superView:(UIView *)view didSelectedBlock:(DidSelectedBlock)block
{
    self = [super init];
    
    if (self)
    {
        self.block = block;
        self.isShow = NO;
        self.superView = view;
        self.frame = CGRectMake(0, 64, view.width, view.height-64);
        self.background  = [[UIControl alloc]initWithFrame:self.bounds];
        self.background.backgroundColor = [UIColor colorWithHexString:@"#000000" alpha:0.6];
        self.background.alpha = 0.0;
        [self.background addTarget:self action:@selector(onBackgroundTouch) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.background];
        
        self.customView  = customView;
        customView.frame = CGRectMake(0, -customView.height, customView.width, customView.height);
        [self addSubview:customView];
    }
    return self;
}

#pragma mark- UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 6;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LotteryItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LotteryItemCell" forIndexPath:indexPath];
    switch (indexPath.row)
    {
        case 0:
            cell.iconImageView.image = [UIImage imageNamed:@"shuangseqiu"];
            break;
        case 1:
            cell.iconImageView.image = [UIImage imageNamed:@"daletou"];
            break;
        case 2:
            cell.iconImageView.image = [UIImage imageNamed:@"7lecai"];
            break;
        case 3:
            cell.iconImageView.image = [UIImage imageNamed:@"7cai"];
            break;
        case 4:
            cell.iconImageView.image = [UIImage imageNamed:@"pailiesan"];
            break;
        case 5:
            cell.iconImageView.image = [UIImage imageNamed:@"paliewu"];
            break;
        default:
            break;
    }
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(kScreenWidth/3.0, 80.0*(kScreenWidth/375.0));
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.0;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10.0, 0.0, 0.0, 0.0);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self hide];
    
    if (self.block)
    {
        self.block(indexPath.row);
    }
}



- (void)onBackgroundTouch
{
    [self hide];
}


- (void)show
{
    [self.superView addSubview:self];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.customView.transform = CGAffineTransformMakeTranslation(0, self.customView.frame.size.height);
        self.background.alpha = 1.0;
    }];
    
    self.isShow = YES;
}

- (void)hide
{
    [UIView animateWithDuration:0.3 animations:^{
        
        self.customView.transform = CGAffineTransformIdentity;
        self.background.alpha = 0.0;
    } completion:^(BOOL finished) {
        
        if (finished)
        {
            [self removeFromSuperview];
        }
    }];
    
    self.isShow = NO;
}


@end
