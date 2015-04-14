//
//  SGViewController.m
//  touchDemo
//
//  Created by qingyun on 15-3-9.
//  Copyright (c) 2015年 ShaoGe. All rights reserved.
//

#import "SGViewController.h"

#define kCyanViewFrame  CGRectMake(44, 44, 100, 100)
#define kYellowViewFrame  CGRectMake(110, 200, 100, 100)
#define kMagentaViewFrame  CGRectMake(150, 350, 100, 100)

@interface SGViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *cyanView;
@property (weak, nonatomic) IBOutlet UIImageView *magentaView;
@property (weak, nonatomic) IBOutlet UIImageView *yellowView;

@end

@implementation SGViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (BOOL)isTouchPointInViews:(CGPoint)location
{
    if (CGRectContainsPoint(_cyanView.frame, location)
        || CGRectContainsPoint(_yellowView.frame, location)
        || CGRectContainsPoint(_magentaView.frame, location)) {
        return YES;
    }
    return NO;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:self.view];
    //isTouchPointInViews  判断点击的当前View
    if ([self isTouchPointInViews:location]) {
        //animateView 放大view
        [self animateView:touch.view];
    } else{
        if (touch.tapCount == 2) {
            [self resetFrames];
        }
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:self.view];
    
    if (CGRectContainsPoint(_cyanView.frame, location)) {
        _cyanView.center = location;
    }
    
    if (CGRectContainsPoint(_yellowView.frame, location)) {
        _yellowView.center = location;
    }
    
    if (CGRectContainsPoint(_magentaView.frame, location)) {
        _magentaView.center = location;
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    
    // 恢复触摸开始时放大的图片
    [UIView animateWithDuration:0.3 animations:^{
        touch.view.transform = CGAffineTransformIdentity;
    }];

}

// 触摸开始时，放大图片视图的动画
- (void)animateView:(UIView *)view
{
    [UIView animateWithDuration:0.3 animations:^{
        view.transform = CGAffineTransformScale(view.transform, 1.2, 1.2);
    }];
}
- (void)resetFrames
{
    [UIView animateWithDuration:0.5 animations:^{
    
        _magentaView.frame = kMagentaViewFrame;
        _yellowView.frame = kYellowViewFrame;
        _cyanView.frame = kCyanViewFrame;
    
    }];
}

@end
