//
//  MRAResetButton.m
//  MRA-UI
//
//  Created by paul adams on 09/01/2014.
//  Copyright (c) 2014 paul adams. All rights reserved.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "MRAResetButton.h"
#import <QuartzCore/QuartzCore.h>

static const CGFloat CIRCULAR_CURVE = 0.5f;

//border width
static const CGFloat DEF_iPAD_BORDER_WIDTH = 3.0f;
static const CGFloat DEF_iPHONE_BORDER_WIDTH = 2.0f;


@implementation MRAResetButton {
    UIColor *_fromColor;
    UIColor *_toColor;
}
- (CALayer *)button {
    if (!_button) {
        _button = [CALayer layer];
    }
    return _button;
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
    
    //border defaults
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        self.button.borderWidth = DEF_iPAD_BORDER_WIDTH;
    }else {
        self.button.borderWidth = DEF_iPHONE_BORDER_WIDTH;
    }
    self.button.borderColor = [UIColor blackColor].CGColor;
    self.button.backgroundColor = [UIColor redColor].CGColor;
    self.button.cornerRadius = CGRectGetMaxY(self.bounds) * CIRCULAR_CURVE;
    self.button.frame = self.bounds;
    self.backgroundColor = [UIColor clearColor];
    self.opaque = NO;
    [self.layer addSublayer:self.button];
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
    [self.button addAnimation:testAnim
                            forKey:@"backgroundColor"];
    testAnim.beginTime = 0;

    [self.button addAnimation:testAnim forKey:@"opacity"];
    testAnim.beginTime = 0;
     }

//helper method for color set
- (void)colorsFromCGColor {
   //  if (CGColorGetNumberOfComponents(color.CGColor) < 4) {
     if (self.button.backgroundColor) {
        const CGFloat *components = CGColorGetComponents(self.button.backgroundColor);
        //color set by property
        _toColor = [UIColor colorWithRed:components[0] green:components[1] blue:components[2] alpha:components[3]];
        //reset temp color
        _fromColor = [UIColor colorWithRed:components[0] green:components[1] blue:components[2] alpha:0.3];
    }
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
