//
//  MRAIndicator.m
//  MRA-UI
//
//  Created by paul adams on 07/01/2014.
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

#import "MRAIndicator.h"
#import "ScaleValue.h"

//output defaults
static const float MINOUTVALUE = 0;
static const float MAXOUTVALUE = 1.0f;
static const float INDICATOR_OPACITY = 0.8f;
static const float INDICATOR_SCALEFACTOR = 0.40f;

//border width
static const CGFloat DEF_iPAD_BORDER_WIDTH = 3.0f;
static const CGFloat DEF_iPHONE_BORDER_WIDTH = 2.0f;


@implementation MRAIndicator {
    CALayer *_indicatorLayer;
    CALayer *_borderLayer;
    CGFloat _maxHeight;
    CGFloat _maxWidth;
    CGRect _indicatorFrame;
    CGFloat _currentLevel;
}

#pragma mark setters

- (void)setVertical:(BOOL)vertical {
    _vertical = vertical;
    [self calculateFrames];
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    _borderWidth = borderWidth;
    [self calculateFrames];
}

- (void)setBorderColour:(UIColor *)borderColour {
    _borderColour = borderColour;
    _borderLayer.borderColor = _borderColour.CGColor;
    [_borderLayer setNeedsDisplay];
}

#pragma mark drawing helper methods
- (CGFloat)cornerRadiusWithMaxDim:(CGFloat)maxdim {
    return (maxdim * 0.50);
}

- (CGRect)calculateIndicatorFrame {
    
    CGRect returnRect;
    CGFloat inset;
    if (self.isVertical) {
  
        inset = CGRectGetMaxX(self.bounds)*INDICATOR_SCALEFACTOR;
        CGRect insetRect = CGRectInset(self.bounds,inset,inset);
        CGFloat newOriginY = CGRectGetMaxY(insetRect);
        insetRect.origin.y = newOriginY;
        returnRect = insetRect;

    }else {
        inset = CGRectGetMaxY(self.bounds)*INDICATOR_SCALEFACTOR;
        returnRect = CGRectInset(self.bounds, inset, inset);
    }
    
    return returnRect;
}


- (void)calculateFrames {
    _indicatorFrame = [self calculateIndicatorFrame];
    
    _maxWidth = _indicatorFrame.size.width;
    _maxHeight = _indicatorFrame.size.height;
    
    CGFloat borderCornerRadius;
    
    if (self.isVertical) {
        borderCornerRadius = [self cornerRadiusWithMaxDim:CGRectGetMaxX(self.bounds)];
    }else {
        borderCornerRadius = [self cornerRadiusWithMaxDim:CGRectGetMaxY(self.bounds)];
    }
    _borderLayer.borderWidth = self.borderWidth;
    _borderLayer.cornerRadius = borderCornerRadius;
    
    //reset level to new boundaries
    self.indicatorLevel = _currentLevel;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initDefaults];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initDefaults];
    }
    return self;
}


- (void)initDefaults {
    
    self.opaque = NO;
    [self setBackgroundColor:[UIColor clearColor]];
   
    //set border defaults
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        self.borderWidth = DEF_iPAD_BORDER_WIDTH;
    }else {
        self.borderWidth = DEF_iPHONE_BORDER_WIDTH;
    }

    _borderColour = [UIColor blackColor];
    _indicatorColour = [UIColor redColor];
        
    //default min max level
    _minimumLevel = MINOUTVALUE;
    _maximumLevel = MAXOUTVALUE;
    
    //setup borderlayer
    _borderLayer = [CALayer layer];
    _borderLayer.frame = self.bounds;
    
    _indicatorFrame = CGRectZero;

    _borderLayer.contentsScale = [UIScreen mainScreen].scale;
    _borderLayer.backgroundColor = [UIColor clearColor].CGColor;
    _borderLayer.borderColor = self.borderColour.CGColor;
    _borderLayer.borderWidth = self.borderWidth;
    [self.layer addSublayer:_borderLayer];
    
    //setup indicator layer
    _indicatorLayer = [CALayer layer];
    _indicatorLayer.backgroundColor = self.indicatorColour.CGColor;
    _indicatorLayer.opacity = INDICATOR_OPACITY;
    //ensure layer is scaled for retina
    _indicatorLayer.contentsScale = [UIScreen mainScreen].scale;
    _indicatorLayer.frame = _indicatorFrame;
  
    [self.layer addSublayer:_indicatorLayer];
    
    //set initial level
    self.indicatorLevel = 0;
    
    //calculate frame sizes for border and indicator
    [self calculateFrames];
    
    
}
#pragma mark draw indicator methods

- (void)setIndicatorLevel:(CGFloat)indicatorLevel {
    if (indicatorLevel <= self.maximumLevel && indicatorLevel >= self.minimumLevel) {
        CGFloat scaledIndicatorSize = 0.0;
        _currentLevel = indicatorLevel;
        if (self.isVertical) {
            scaledIndicatorSize = [ScaleValue scaleFloat:indicatorLevel
                                                 withSrc:self.minimumLevel
                                               andsrcMax:self.maximumLevel
                                             usingnewMin:0
                                               andnewMax:_maxHeight];
            _indicatorFrame.size.height = -scaledIndicatorSize;
            _indicatorLayer.frame = _indicatorFrame;
        } else {
            scaledIndicatorSize = [ScaleValue scaleFloat:indicatorLevel
                                                 withSrc:self.minimumLevel
                                               andsrcMax:self.maximumLevel
                                             usingnewMin:0
                                               andnewMax:_maxWidth];
            _indicatorFrame.size.width = scaledIndicatorSize;
            _indicatorLayer.frame = _indicatorFrame;
        }
    }
}



@end
