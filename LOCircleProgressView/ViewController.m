//
//  ViewController.m
//  LOCircleProgressView
//
//  Created by ShihKuo-Hsun on 2015/2/26.
//  Copyright (c) 2015年 LO. All rights reserved.
//

#import "ViewController.h"
#import "LOCircleProgressView.h"
@interface ViewController ()<LOCircleProgressViewDelegate>{
    IBOutlet LOCircleProgressView *progress;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    progress.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnPressed:(UIButton *)sender {
    [progress setProgressValue:fabs(progress.progressValue-1) withAnimate:YES];
}

#pragma mark - delegate

-(void)LOCircleProgressViewDidEndAnimate{
//    [progress setProgressValue:1 withAnimate:YES];
    NSLog(@"done ");
}


@end
