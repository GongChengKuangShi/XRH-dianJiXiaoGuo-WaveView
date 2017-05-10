//
//  WaveView.m
//  XRHWaveView
//
//  Created by xiangronghua on 2017/5/10.
//  Copyright © 2017年 xiangronghua. All rights reserved.
//

#import "WaveView.h"
#define kMaxX 1.138

@interface WaveView ()

@property(nonatomic,weak)NSTimer *timer;//计时器
@property(nonatomic,assign)CGFloat r;//圆的当前半径

@end

@implementation WaveView

static NSInteger heartCount = 0;//心形数量

+ (Class)layerClass {
    return [CAShapeLayer class];
}

/**
 唯一初始化方法
 */
- (instancetype)initWithPoint:(CGPoint)point {
    if (self = [super init]) {
       
        // view背景颜色设定clear，防止阴影出现
        self.backgroundColor=[UIColor clearColor];
        
        // 默认动画时间和半径
        
        self.duration = 1;
        self.maxR = 50;
        self.waveCount = 3;
        self.waveDelta = 10;
        self.boundaryAlpha = 0.2;
        self.maxAlpha = 1;
        self.minAlpha = 0;
        self.degree = 0.05;
        self.mainColor = [UIColor redColor];
        self.maxHearts = 10;
        self.waveStyle = Heart;
        // 获取当前点击的位置
        
        self.center = point;
        
    }
    return self;
}

/**
 绘图
 */
- (void)drawRect:(CGRect)rect {
    CGPoint drawPoint = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    
    for (int i = 0; i < self.waveCount; i++) {
        // 如果当前半径为负或超出边界，则不显示
        CGFloat currentR = self.r-i*self.waveDelta;
        if (currentR < 0 || currentR > self.maxR) {
            continue;
        }
        
        // 设定路径
        UIBezierPath *path;
        
        if (_waveStyle == Heart) {
            // 心形曲线的绘制
            path = [[UIBezierPath alloc] init];
            
            // 定位到初始点
            float i = -kMaxX;
            float y = [self getHeartYWithX:fabs(i) andKey:2];
            [path moveToPoint:CGPointMake(i*currentR+drawPoint.x, -y*currentR/2+drawPoint.y)];
            
            // 上半部
            for (float i = -kMaxX; i < kMaxX; i += self.degree) {
                y = [self getHeartYWithX:fabs(i) andKey:1];
                [path addLineToPoint:CGPointMake(i*currentR+drawPoint.x, -y*currentR/2+drawPoint.y)];
            }
            
            // 下半部
            for (float i = kMaxX; i > -kMaxX; i -= self.degree) {
                y = [self getHeartYWithX:fabs(i) andKey:2];
                [path addLineToPoint:CGPointMake(i*currentR+drawPoint.x, -y*currentR/2+drawPoint.y)];
            }
            
            // 封闭
            i = -kMaxX;
            y = [self getHeartYWithX:fabs(i) andKey:2];
            [path addLineToPoint:CGPointMake(i*currentR+drawPoint.x, -y*currentR/2+drawPoint.y)];
            
        } else {
            path = [UIBezierPath bezierPathWithArcCenter:drawPoint radius:currentR startAngle:0 endAngle:M_PI*2 clockwise:NO];
        }

        // 颜色和透明度设置
        [self.mainColor set];
        CGFloat currentAlpha = [self getAlphaWithIndex:currentR/(self.maxR*1.0)];
        
        // 渲染
        [path fillWithBlendMode:kCGBlendModeNormal alpha:currentAlpha];
        [path strokeWithBlendMode:kCGBlendModeNormal alpha:currentAlpha+self.boundaryAlpha];

    }
}


//添加到父控件时自动开始动画
-(void)willMoveToSuperview:(UIView *)newSuperview{
    [self fire];
}

- (void)fire {
    if (heartCount > self.maxHearts) {
        return;
    }
    heartCount += 1;
    
    //设定间隔时间     设定的总时间/半径刻度
    CGFloat time = self.duration/(self.maxR*1.0);
    self.timer = [NSTimer scheduledTimerWithTimeInterval:time target:self selector:@selector(startView:) userInfo:nil repeats:YES];
}

/*
 极坐标表达式：
 水平方向：r=a(1-cosθ)或r=a(1+cosθ) (a>0)
 或垂直方向： r=a(1-sinθ)或r=a(1+sinθ) (a>0)
 平面直角坐标表达式分别为：
 x^2+y^2+a*x=a*sqrt(x^2+y^2)和
 x^2+y^2-a*x=a*sqrt(x^2+y^2
 */
//笛卡尔心形公式
-(CGFloat)getHeartYWithX:(CGFloat)x andKey:(NSInteger)key{
    if (key==1) {
        return powf(x, 2.0/3)+powf(powf(x, 4.0/3)-4*powf(x, 2)+4, 1.0/2);
    }else{
        return powf(x, 2.0/3)-powf(powf(x, 4.0/3)-4*powf(x, 2)+4, 1.0/2);
    }
}

//获取正确的Alpha值
-(CGFloat)getAlphaWithIndex:(CGFloat)index{
    CGFloat a = self.minAlpha-self.maxAlpha;
    CGFloat b = self.maxAlpha;
    return a*index + b;
}

/**
 绘图，当到达最大半径的时候移除
 */
-(void)startView:(id)sender{
    self.r += 1;
    if (self.r-self.waveCount*self.waveDelta>self.maxR) {
        [self.timer invalidate];
        [self removeFromSuperview];
        heartCount -= 1;
    }
    [self setNeedsDisplay];
}

/**
 根据maxR，设定view的frame
 */
-(void)setMaxR:(NSInteger)maxR{
    _maxR = maxR;
    self.bounds = CGRectMake(0, 0, maxR*8, maxR*8);
}

//计算alpha  x:当前半径/最大半径
float getAlpha(float x){
    //原数据从0到1
    //返回从0.8到0.1的数
    return (0.7-x*0.7);
}


@end
