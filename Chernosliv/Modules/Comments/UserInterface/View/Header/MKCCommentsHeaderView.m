//
//  MKCCommentsHeaderView.m
//  Chernosliv
//
//  Created by Vyacheslav Zavertanny on 31/08/15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import "MKCCommentsHeaderView.h"

@interface MKCCommentsHeaderView ()

@end

@implementation MKCCommentsHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.clipsToBounds = YES;
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
//    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGFloat colors [] = {
        0.0, 0.0, 0.0, 0.8,
        0.0, 0.0, 0.0, 0.0
    };
    
    CGFloat locations [] = {
        0.0, 1.0
    };

    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, colors, locations, 2);
    
    CGPoint startPoint = CGPointMake(0, 0);
    CGPoint endPoint = CGPointMake(0, self.bounds.size.height);
    
//    [self.someImage drawInRect:self.bounds];
    
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
}



@end
