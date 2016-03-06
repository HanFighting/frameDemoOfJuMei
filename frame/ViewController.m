//
//  ViewController.m
//  frame
//
//  Created by 韩 on 16/3/5.
//  Copyright © 2016年 bigeyehanting@163.com All rights reserved.
//

#import "ViewController.h"

//点的类型
typedef enum{
    PointLocationTopLeft,
    PointLocationLowRight
}PointLocationType;

@interface ViewController ()
//每个小方块的属性
//宽
@property (nonatomic,assign)NSInteger width;
//高
@property (nonatomic,assign)NSInteger height;
//间距
@property (nonatomic,assign)NSInteger margin;
//一行的个数
@property (nonatomic,assign)NSInteger numOfT;
//(背景)一列的个数
@property (nonatomic,assign)NSInteger numOfR;
//用户输入的坐标
@property (weak, nonatomic) IBOutlet UITextField *T;
@property (weak, nonatomic) IBOutlet UITextField *C;
@property (weak, nonatomic) IBOutlet UITextField *W;
@property (weak, nonatomic) IBOutlet UITextField *H;

@property (strong, nonatomic) UIView *userView;

@end

@implementation ViewController


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //设置小方格属性
    self.width = 80;
    self.margin = 10;
    self.height = self.width;
    self.numOfT = 4;
    self.numOfR = 2;
    
    //绘制背景
    UIView *backgroundView = [[UIView alloc]init];
    backgroundView.frame = [self frameOfCoordinateT:1 andC:1 andW:self.numOfT andH:self.numOfR];
    backgroundView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:backgroundView];
    //背景上的边距 便于观察
    //这里可以写活,更具有扩展性
    UIView *marginView1 = [[UIView alloc]init];
    marginView1.frame = CGRectMake(80, 0, 10, 170);
    marginView1.backgroundColor = [UIColor redColor];
    [self.view addSubview:marginView1];
    UIView *marginView2 = [[UIView alloc]init];
    marginView2.frame = CGRectMake(170, 0, 10, 170);
    marginView2.backgroundColor = [UIColor redColor];
    [self.view addSubview:marginView2];
    UIView *marginView3 = [[UIView alloc]init];
    marginView3.frame = CGRectMake(260, 0, 10, 170);
    marginView3.backgroundColor = [UIColor redColor];
    [self.view addSubview:marginView3];
    UIView *marginView4 = [[UIView alloc]init];
    marginView4.frame = CGRectMake(0, 80, 350, 10);
    marginView4.backgroundColor = [UIColor redColor];
    [self.view addSubview:marginView4];
    
    
    //默认输入坐标(1 1 1 1)
    UIView *userView = [[UIView alloc]init];
    userView.frame = [self frameOfCoordinateT:1 andC:1 andW:1 andH:1];
    userView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:userView];
    self.userView = userView;

}
//点击确认按钮
- (IBAction)okButtonClick:(id)sender {
    //获取用户输入的坐标
    NSInteger userT = self.T.text.intValue;
    NSInteger userC = self.C.text.intValue;
    NSInteger userW = self.W.text.intValue;
    NSInteger userH = self.H.text.intValue;
    //获得坐标对应的frame
    self.userView.frame = [self frameOfCoordinateT:userT andC:userC andW:userW andH:userH];

    [self.view layoutSubviews];
}

//返回坐标对应的frame
- (CGRect)frameOfCoordinateT:(NSInteger)t andC:(NSInteger)c andW:(NSInteger)w andH:(NSInteger)h{
    //左上角方块序号
    NSInteger topLeftDiamondsNum = self.numOfT * (t - 1) + c;
    //左上角point
    CGPoint topLeftPoint = [self PointOf:topLeftDiamondsNum ofIts:PointLocationTopLeft];
    
    //右下角方块序号
    NSInteger lowRightDiamondsNum = ( t + h - 2) * self.numOfT + c + w - 1;
    //右下角point
    CGPoint lowRightPoint = [self PointOf:lowRightDiamondsNum ofIts:PointLocationLowRight];

    //计算坐标对应的frame
    CGFloat frameW = (lowRightPoint.x - topLeftPoint.x);
    CGFloat frameH = (lowRightPoint.y - topLeftPoint.y);
    CGRect frameOfCoordinate = CGRectMake(topLeftPoint.x, topLeftPoint.y,frameW,frameH);
    
    return frameOfCoordinate;
}

//返回具体的点 参数:小方块的编号 点的位置
- (CGPoint)PointOf:(NSInteger)diamondsNum ofIts:(PointLocationType)pointLocation{
    //计算出小方块的位置
    NSInteger tOfNum = diamondsNum / ( self.numOfT + 1) + 1;//第diamondsNum个方块的行
    NSInteger rOfNum = diamondsNum - self.numOfT * (tOfNum - 1);//第diamondsNum个方块的列
    //根据位置需求计算出相应的点
    CGFloat xOfNum = 0.0;
    CGFloat yOfNum = 0.0;
    if (pointLocation == PointLocationTopLeft) {//左上角
        xOfNum = (rOfNum - 1) * (self.width + self.margin);
        yOfNum = (tOfNum - 1) * (self.height +self.margin);
    }else if (pointLocation == PointLocationLowRight){//右下角
        xOfNum = (rOfNum - 1) * (self.width + self.margin) + self.width;
        yOfNum = (tOfNum - 1) * (self.height + self.margin) + self.height;
    }
    CGPoint locationPoint = CGPointMake(xOfNum, yOfNum);
    //返回点
    return locationPoint;
}

- (BOOL)prefersStatusBarHidden{
    return YES;
}
@end
