//
//  LOCircleProgressView.h
//  quickSelection
//
//  Created by ShihKuo-Hsun on 2015/2/21.
//  Copyright (c) 2015年 LO. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LOCircleProgressViewDelegate;
IB_DESIGNABLE
@interface LOCircleProgressView : UIView

@property (weak,nonatomic) id<LOCircleProgressViewDelegate> delegate;

@property (assign,nonatomic) IBInspectable BOOL reverse;
@property (assign,nonatomic) IBInspectable CGFloat startAngle;
@property (assign,nonatomic) IBInspectable CGFloat progressValue;
@property (assign,nonatomic) IBInspectable CGFloat width;
@property (assign,nonatomic) IBInspectable CGFloat bgWidth;
@property (strong,nonatomic) IBInspectable UIColor *color;
@property (strong,nonatomic) IBInspectable UIColor *bgColor;

-(void)setProgressValue:(CGFloat)progressValue withAnimate:(BOOL)needAnimate;
@end



@protocol LOCircleProgressViewDelegate <NSObject>
@optional
-(void)LOCircleProgressViewDidEndAnimate;
@end