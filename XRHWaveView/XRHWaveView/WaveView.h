//
//  WaveView.h
//  XRHWaveView
//
//  Created by xiangronghua on 2017/5/10.
//  Copyright © 2017年 xiangronghua. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    Heart = 0,
    Circle = 1
    
}WaveStyle;

@interface WaveView : UIView

//可选属性,有默认值

@property(nonatomic,assign)NSInteger duration;//持续时间,默认1秒
@property(nonatomic,assign)NSInteger maxR;//最大半径,默认50
@property(nonatomic,assign)NSInteger waveCount;//wave层数,默认5
@property(nonatomic,assign)NSInteger waveDelta;//wave间距,默认10
@property(nonatomic,assign)CGFloat boundaryAlpha;//边界透明度(基于wave)
@property(nonatomic,assign)CGFloat maxAlpha;//wave起始透明度,默认1
@property(nonatomic,assign)CGFloat minAlpha;//wave末尾透明度,默认0
@property(nonatomic,assign)CGFloat degree;//清晰度,默认0.05
@property(nonatomic,strong)UIColor *mainColor;//主要颜色,默认红色
@property(nonatomic,assign)NSInteger maxHearts;//wave的最大数量
@property(nonatomic,assign)WaveStyle waveStyle;//wave类型


-(instancetype)initWithPoint:(CGPoint)point;

@end
