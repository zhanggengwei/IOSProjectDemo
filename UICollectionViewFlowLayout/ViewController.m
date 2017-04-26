//
//  ViewController.m
//  UICollectionViewFlowLayout
//
//  Created by Donald on 17/4/25.
//  Copyright © 2017年 Susu. All rights reserved.
//

#import "ViewController.h"
#import "ActivityFlowLayout.h"
#import "CollectionViewCell.h"
@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,ActivityFlowLayoutDelegate>

@property (nonatomic,strong) UICollectionView * collectionView;
@property (nonatomic,strong) NSMutableArray<ActivityModelProtrol> * modelArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    ActivityModel * model1 = [ActivityModel new];
    model1.itemframe = CGRectMake(0,0,2.0/3 * SCREEN_WIDTH, 2.0/3 * SCREEN_HEIGHT);
    
    ActivityModel * model2 = [ActivityModel new];
    model2.itemframe = CGRectMake(2.0/3 * SCREEN_WIDTH,0,1.0/3 * SCREEN_WIDTH, 1.0/3 * SCREEN_HEIGHT);
    
    ActivityModel * model3 = [ActivityModel new];
    model3.itemframe = CGRectMake(2.0/3 * SCREEN_WIDTH,1.0/3 * SCREEN_HEIGHT,1.0/3 * SCREEN_WIDTH, 1.0/3 * SCREEN_HEIGHT);
    ActivityModel * model4 = [ActivityModel new];
    model4.itemframe = CGRectMake(0,2.0/3 *SCREEN_HEIGHT ,1.0/3 * SCREEN_WIDTH, 1.0/3 * SCREEN_HEIGHT);
    ActivityModel * model5 = [ActivityModel new];
    model5.itemframe = CGRectMake(1.0/3 * SCREEN_WIDTH,2.0/3 *SCREEN_HEIGHT,1.0/3 * SCREEN_WIDTH, 2.0/3 * SCREEN_HEIGHT);
    ActivityModel * model6 = [ActivityModel new];
    model6.itemframe = CGRectMake(2.0/3 * SCREEN_WIDTH,2.0/3 *SCREEN_HEIGHT,1.0/3 * SCREEN_WIDTH, 1.0/3 * SCREEN_HEIGHT);
    self.modelArray = [NSMutableArray<ActivityModelProtrol> new];
    [self.modelArray addObject:model1];
     [self.modelArray addObject:model2];
     [self.modelArray addObject:model3];
    [self.modelArray addObject:model4];
     [self.modelArray addObject:model5];
     [self.modelArray addObject:model6];
    
    ActivityFlowLayout * layout = [[ActivityFlowLayout alloc]init];
    layout.delegate = self;
    
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
    [self.view addSubview:self.collectionView];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    [self.collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([CollectionViewCell class])];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSLog(@" %s",__func__);
    return 6;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@" %s",__func__);
    CollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([CollectionViewCell class]) forIndexPath:indexPath];
    cell.backgroundColor= [UIColor redColor];
    NSLog(@"cell == %@",cell);
    cell.layer.borderWidth = 4;
    
    return cell;
    
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
     NSLog(@" %s",__func__);
     return 1;
    
}
- (NSArray<ActivityModelProtrol> *)modelLayoutArr
{
    return self.modelArray;
}


@end
