//
//  EmitterViewController.m
//  iOS
//
//  Created by aStudyer on 2019/9/29.
//  Copyright © 2019 com.aStudyer. All rights reserved.
//

#import "EmitterViewController.h"

@interface EmitterViewController ()

@end

@implementation EmitterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    // 1.创建发射器
    CAEmitterLayer *emitter = [[CAEmitterLayer alloc] init];
    // 2.设置发射器的位置
    emitter.position = CGPointMake(ScreenW * 0.5, 20);
    // 3.开启三维效果
    emitter.preservesDepth = YES;
    // 4.创建粒子，设置粒子相关属性
    // 4.1 创建粒子
    CAEmitterCell *cell = [CAEmitterCell new];
    // 4.2 设置粒子速度
    cell.velocity = 150;
    // 速度波动范围
    cell.emissionRange = 100;
    // 4.3 设置粒子的大小
    cell.scale = 0.7;
    cell.scaleRange = 0.3;
    // 4.4 设置粒子方向
    cell.emissionLongitude = M_PI_2;
    cell.emissionRange = M_PI_2 / 2;
    // 4.5 设置粒子的存活时间
    cell.lifetime = 6;
    cell.lifetimeRange = 1.5;
    // 4.6 设置粒子每秒弹出的个数
    cell.birthRate = 20;
    // 4.7 设置粒子展示的图片
    cell.contents = (id)[UIImage imageNamed:@"bear"].CGImage;
    // 4.8 设置粒子旋转
    cell.spin = M_PI_2;
    cell.spinRange = M_PI_2 / 2;
    // 5. 将粒子放到发射器中
    emitter.emitterCells = @[cell];
    // 6. 将发射器的layer添加到父layer中
    [self.view.layer addSublayer:emitter];
}

@end
