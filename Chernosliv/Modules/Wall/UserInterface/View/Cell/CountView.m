//
//  CountView.m
//  Chernosliv
//
//  Created by Vacheslav Zavertanny on 26.07.15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import "CountView.h"

@interface CountView ()

@property (nonatomic, strong) UIVisualEffectView *blurEffectView;
@property (nonatomic, strong) UILabel *countLabel;

@end

@implementation CountView

//- (instancetype)init {
//    self = [super init];
//    if (self) {
//        NSLog(@"Hello!!!");
//    }
//    return self;
//}

- (void)awakeFromNib {

    // add blur effect
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    _blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    _blurEffectView.frame = self.bounds;
    [self addSubview:_blurEffectView];
    
    // add vibrancy effect
    UIVibrancyEffect *vibrancyEffect = [UIVibrancyEffect effectForBlurEffect:blurEffect];
    UIVisualEffectView *vibrancyEffectView = [[UIVisualEffectView alloc] initWithEffect:vibrancyEffect];
    [vibrancyEffectView setFrame:_blurEffectView.bounds];
    
    _countLabel = [[UILabel alloc] initWithFrame:_blurEffectView.bounds];
    [_countLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:18]];
    _countLabel.textAlignment = NSTextAlignmentCenter;
    
    [vibrancyEffectView.contentView addSubview:_countLabel];
    [_blurEffectView.contentView addSubview:vibrancyEffectView];
    
    
//    
//    NSMutableString *str = [NSMutableString stringWithCapacity:1000];
//    for (NSString *familyName in [UIFont familyNames]) {
//        [str appendFormat:@"%@\n", familyName];
//        for (NSString *fontName in [UIFont fontNamesForFamilyName:familyName]) {
//            [str appendFormat:@"    %@\n", fontName];
//        }
//        [str appendString:@"\n"];
//    }
//    NSLog(@"%@", str);
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    // Drawing code
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:rect];
    layer.path = path.CGPath;
//    [self.fillColor setFill];
//    [path fill];
    self.blurEffectView.layer.mask = layer;
}

- (void)setCount:(NSUInteger)count {
    NSString *countText = [NSString stringWithFormat:@"%lu", count];
    _countLabel.text = countText;
//    [self setNeedsDisplay];
}



@end
