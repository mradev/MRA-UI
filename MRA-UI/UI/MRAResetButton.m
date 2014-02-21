//
//  ACGResetButton.m
//  testingstuff
//
//  Created by paul adams on 09/01/2014.
//  Copyright (c) 2014 paul adams. All rights reserved.
//

#import "ACGResetButton.h"
#import <QuartzCore/QuartzCore.h>

@implementation ACGResetButton {
    UIColor *_fromColor;
    UIColor *_toColor;
}



- (CALayer *)buttonLayer {
    if (!_buttonLayer) {
        _buttonLayer = [CALayer layer];
    }
    return _buttonLayer;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self configureLayerDefaults];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self){
        [self configureLayerDefaults];
    }
    
    return self;
    
}

- (void)configureLayerDefaults {
    
    self.buttonLayer.borderWidth = 4.0f;
    self.buttonLayer.borderColor = [UIColor blackColor].CGColor;
    self.buttonLayer.backgroundColor = [UIColor redColor].CGColor;
    self.buttonLayer.cornerRadius = CGRectGetMaxY(self.bounds) * 0.5;
    self.buttonLayer.frame = self.bounds;
    [self.layer addSublayer:self.buttonLayer];
}

- (CABasicAnimation *)animateForKeyPath:(NSString *)keyPath
                             fromValue:(id)fromValue
                               toValue:(id)toValue {
    CAMediaTimingFunction *timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:keyPath];
    animation.fromValue = fromValue;
    animation.toValue = toValue;
    animation.timingFunction = timingFunction;
    return animation;
}

//simulate reset flash
- (void)animateButton {
    
    //get animation colors
    [self colorsFromCGColor];
    CABasicAnimation *testAnim = [self animateForKeyPath:@"backgroundColor"
                                               fromValue:(id)_fromColor.CGColor
                                                 toValue:(id)_toColor.CGColor];
    [self.buttonLayer addAnimation:testAnim
                            forKey:@"backgroundColor"];
    testAnim.beginTime = 0;

    [self.buttonLayer addAnimation:testAnim forKey:@"opacity"];
    testAnim.beginTime = 0;
     }

//helper method for color set
- (void)colorsFromCGColor {
   //  if (CGColorGetNumberOfComponents(color.CGColor) < 4) {
     if (self.buttonLayer.backgroundColor) {
        const CGFloat *components = CGColorGetComponents(self.buttonLayer.backgroundColor);
        //color set by property
        _toColor = [UIColor colorWithRed:components[0] green:components[1] blue:components[2] alpha:components[3]];
        //reset temp color
        _fromColor = [UIColor colorWithRed:components[0] green:components[1] blue:components[2] alpha:0.3];
    }
    /*
    if (CGColorSpaceGetModel(CGColorGetColorSpace(color.CGColor)) != kCGColorSpaceModelRGB) {
        NSLog(@"no rgb colorspace");
    }
     const CGFloat *components = CGColorGetComponents(_toColor.CGColor);
     NSString *colorAsString = [NSString stringWithFormat:@"%f,%f,%f,%f", components[0], components[1], components[2], components[3]];
     NSLog(@"Color set for b layer %@",colorAsString);
     */
}

#pragma mark UIControl Methods
- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    [super endTrackingWithTouch:touch withEvent:event];
    if (CGRectContainsPoint(self.bounds,[touch locationInView: self]))
    {
        [self animateButton];
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    }
}



@end
