
//
//  ActivityFlowLayout.m
//  IOSProjectDemo
//
//  Created by Donald on 17/4/25.
//  Copyright © 2017年 Susu. All rights reserved.
//

#import "ActivityFlowLayout.h"

@implementation ActivityModel

@synthesize itemframe;


@end

@implementation ActivityFlowLayout
{
    NSArray * _modelArray;
    NSMutableArray * _layoutAttributesArray;
    CGFloat _lineSpaceing;
    CGFloat _itemSpaceing;
    CGFloat _maxHeight;
    
    
}

- (instancetype)init
{
    self = [super init];
    if(self)
    {
        _modelArray = [NSArray new];
        _layoutAttributesArray = [NSMutableArray new];
    }
    return self;
}



- (void)prepareLayout
{
    if([self.delegate respondsToSelector:@selector(modelLayoutArr)])
    {
        _modelArray = [self.delegate modelLayoutArr];
        
    }
    for (NSInteger i = _layoutAttributesArray.count; i < _modelArray.count; i++)
    {
     
        ActivityModel * model = _modelArray[i];
        NSIndexPath * indexpath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes * attributes = [self layoutAttributesForItemAtIndexPath:indexpath];
        attributes.frame = model.itemframe;
        [_layoutAttributesArray addObject:attributes];
        
    }
    
    
}
- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
   
    
    return _layoutAttributesArray;
    
}
- (nullable UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes * attributes = [super layoutAttributesForItemAtIndexPath:indexPath];
    
    ActivityModel * model = _modelArray[indexPath.row];
    if(model==nil)
    {
        NSLog(@"%s",__FUNCTION__);
        return  attributes;
    }
    attributes.frame = model.itemframe;
    _maxHeight = MAX(_maxHeight,CGRectGetMaxY(model.itemframe));
    return attributes;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
    
}
- (CGSize)collectionViewContentSize
{
    
    return CGSizeMake(SCREEN_WIDTH,_maxHeight);
    
}
@end
