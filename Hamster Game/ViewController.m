//
//  ViewController.m
//  Hamster Game
//
//  Created by HZhenF on 2017/6/14.
//  Copyright © 2017年 HuangZhenFeng. All rights reserved.
//

#import "ViewController.h"

#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height

#define BtnW ScreenW/3
#define BtnH ScreenW/3

@interface ViewController ()

@property(nonatomic,strong) NSMutableArray *arrM;

@property(nonatomic,assign) int score;

@property(nonatomic,strong) UILabel *scoreLb;

@end

@implementation ViewController{
    UIImageView *advertisementImgView;
}

#pragma mark - Lazy load

-(NSMutableArray *)arrM
{
    if (!_arrM) {
        _arrM = [NSMutableArray array];
    }
    return _arrM;
}

#pragma mark - System Methods

-(BOOL)prefersStatusBarHidden
{
    return YES;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupControls];
    
    [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(hamsterAction) userInfo:nil repeats:YES];
    

    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    //广告效果
    advertisementImgView = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    advertisementImgView.image = [UIImage imageNamed:@"splash.jpg"];
    
    UIWindow *window=[[[UIApplication sharedApplication] delegate] window];
    
    [window addSubview:advertisementImgView];
    
    [self performSelector:@selector(removew) withObject:nil afterDelay:2];
    
}


#pragma mark - Custom Methods

/**
 移除广告
 */
- (void)removew{
    [UIView animateWithDuration:1 animations:^{
        advertisementImgView.alpha = 0.1;
    } completion:^(BOOL finished) {
        [advertisementImgView removeFromSuperview];
    }];
}


/**
 控件初始化
 */
-(void)setupControls
{
    for (int i = 0; i < 9; i ++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(i%3*BtnW, i/3*BtnH, BtnW, BtnH)];
        btn.layer.borderColor = [UIColor lightGrayColor].CGColor;
        btn.layer.borderWidth = 0.5;
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:@"地鼠" forState:UIControlStateSelected];
        [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        
        
        [self.arrM addObject:btn];
        [self.view addSubview:btn];
    }
    
    UILabel *countLb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
    countLb.center = CGPointMake(ScreenW*0.5, ScreenH*0.9);
    countLb.textAlignment = NSTextAlignmentCenter;
    countLb.text = [NSString stringWithFormat:@"总分:%d",self.score];
    [self.view addSubview:countLb];
    self.scoreLb = countLb;
}


/**
 按钮点击事件

 @param sender 按钮本身
 */
-(void)btnAction:(UIButton *)sender
{
    if (sender.selected) {
        NSLog(@"打到地鼠啦~");
        sender.selected = NO;
        sender.backgroundColor = [UIColor whiteColor];
        
        UILabel *showCountLb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
        showCountLb.center = sender.center;
        [UIView animateWithDuration:0.05f animations:^{
            showCountLb.text = @"+10";
            showCountLb.textColor = [UIColor lightGrayColor];
            [self.view addSubview:showCountLb];
            
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:2.0f animations:^{
                showCountLb.center = self.scoreLb.center;
            } completion:^(BOOL finished) {
                [showCountLb removeFromSuperview];
                self.score += 10;
                self.scoreLb.text = [NSString stringWithFormat:@"总分:%d",self.score];
            }];
        }];
        

    }
    else
    {
        NSLog(@"打到空白了!");
    }
}


/**
 计时器事件
 */
-(void)hamsterAction
{
    for (UIButton *btn in self.arrM) {
        btn.backgroundColor = [UIColor whiteColor];
        btn.selected = NO;
    }
    
    UIButton *hamsterBtn = self.arrM[arc4random()%self.arrM.count];
    hamsterBtn.backgroundColor = [UIColor cyanColor];
    hamsterBtn.selected = YES;
    
}



@end
