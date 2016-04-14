//
//  LOCircleProgressView.m
//  quickSelection
//
//  Created by ShihKuo-Hsun on 2015/2/21.
//  Copyright (c) 2015年 LO. All rights reserved.
//

#import "LOCircleProgressView.h"

@interface LOCircleProgressView (){
    NSInteger timerCounter;
    NSTimer *timer;
    CGFloat deltaProgressValue;
}

@end

@implementation LOCircleProgressView

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    [self setup];
}

-(void)prepareForInterfaceBuilder{
    [super prepareForInterfaceBuilder];
    [self setup];
}

-(void)setup{
    [self setNeedsDisplay];
    self.contentMode = UIViewContentModeRedraw;
}

#pragma mark - setter
-(void)setProgressValue:(CGFloat)progressValue{
    
    _progressValue = progressValue;
    
    if (_progressValue <= 0) {
        _progressValue = 0;
    }
    
    [self setNeedsDisplay];
}

#define animateTimeInterval 0.5
#define animateTimes 50.0

-(void)setProgressValue:(CGFloat)progressValue withAnimate:(BOOL)needAnimate{
    
    if (fabs(progressValue - _progressValue) < 0.000001) {
        return;
    }
    
    if (needAnimate) {
        timerCounter = 0;
        deltaProgressValue = (progressValue - _progressValue) / animateTimes ;
        
        if (!timer) {
            CGFloat timeInerval = animateTimeInterval/animateTimes;
            
            timer = [NSTimer scheduledTimerWithTimeInterval:timeInerval
                                                     target:self
                                                   selector:@selector(progressValueWithAnimate)
                                                   userInfo:nil
                                                    repeats:YES];
        }

    }else{
        [self setProgressValue:progressValue];
    }
}

-(void)progressValueWithAnimate{
    
    [self setProgressValue:deltaProgressValue + self.progressValue];
    [self setNeedsDisplay];
    timerCounter ++;
    
    if (timerCounter > animateTimes - 1 ) {
        [timer invalidate];
        timer = nil;
        
        if ([self.delegate respondsToSelector:@selector(LOCircleProgressViewDidEndAnimate)]) {
            [self.delegate LOCircleProgressViewDidEndAnimate];
        }
    }
}


-(void)drawRect:(CGRect)rect{
    
    CGFloat sideLong        = self.frame.size.width > self.frame.size.height ? self.frame.size.height : self.frame.size.width;
    CGFloat wireWidth       = self.width ? self.width : 1 ;
    CGFloat bgWireWidth     = self.bgWidth? self.bgWidth :1;

    //背景線
    UIColor* bgColor        = self.bgColor ? self.bgColor : [UIColor lightGrayColor];
    UIBezierPath* oval2Path = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(bgWireWidth/2, bgWireWidth/2, sideLong - bgWireWidth , sideLong - bgWireWidth)];
    [bgColor setStroke];
    oval2Path.lineWidth     = bgWireWidth;
    [oval2Path stroke];


    //前景線
    UIColor* color          = self.color ? self.color : [UIColor redColor];
    CGRect ovalRect         = CGRectMake(wireWidth/2, wireWidth/2, sideLong - wireWidth , sideLong - wireWidth);
    UIBezierPath* ovalPath  = UIBezierPath.bezierPath;
    CGFloat startAngle      = self.startAngle * M_PI/180;
    CGFloat stopAngle       = (self.progressValue * 360 + self.startAngle) * M_PI/180;

    if (self.reverse) {
        stopAngle           = M_PI - stopAngle;
    }

    [ovalPath addArcWithCenter: CGPointMake(CGRectGetMidX(ovalRect), CGRectGetMidY(ovalRect)) radius: CGRectGetWidth(ovalRect) / 2 startAngle: startAngle endAngle: stopAngle clockwise: !self.reverse];

    [color setStroke];
    ovalPath.lineWidth      = wireWidth;
    [ovalPath stroke];
}

@end
