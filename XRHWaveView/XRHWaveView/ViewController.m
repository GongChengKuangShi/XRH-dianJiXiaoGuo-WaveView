//
//  ViewController.m
//  XRHWaveView
//
//  Created by xiangronghua on 2017/5/10.
//  Copyright © 2017年 xiangronghua. All rights reserved.
//

#import "ViewController.h"
#import "WaveView.h"

@interface ViewController ()

@property (weak, nonatomic) WaveView *waveView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    UITouch *t = touches.anyObject;
    CGPoint p = [t locationInView:self.view];
    
    WaveView *waveView = [[WaveView alloc]initWithPoint:p];
//    waveView.maxR=50;
//    waveView.duration=2;
//    waveView.waveDelta=10;
//    waveView.waveCount=1;
//    waveView.maxAlpha=1;
//    waveView.minAlpha=0;
    waveView.waveStyle = Heart;
//    waveView.waveStyle = Heart;
    waveView.mainColor = [UIColor colorWithRed:0 green:0.7 blue:1 alpha:1];
//    waveView.boundaryAlpha = 0.8;
    
    [self.view addSubview:waveView];
}

@end
