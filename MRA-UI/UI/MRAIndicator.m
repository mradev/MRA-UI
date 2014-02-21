//
//  VInidcator.m
//  testingstuff
//
//  Created by paul adams on 07/01/2014.
//  Copyright (c) 2014 paul adams. All rights reserved.
//

#import "VInidcator.h"
#import "ScaleValue.h"

@implementation VInidcator {
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
    if (self.isVertical) {
        returnRect = CGRectMake(CGRectGetMinX(self.bounds) + (self.borderWidth * 2),
                                CGRectGetMaxY(self.bounds) - (self.borderWidth * 2),
                                CGRectGetMaxX(self.bounds) -  (self.borderWidth * 4),
                                CGRectGetMaxY(self.bounds) -  (self.borderWidth * 4));
    }else {
        returnRect = CGRectMake(CGRectGetMinX(self.bounds) + (self.borderWidth * 2),
                                CGRectGetMinY(self.bounds) + (self.borderWidth * 2),
                                CGRectGetMaxX(self.bounds) - (self.borderWidth * 4),
                                CGRectGetMaxY(self.bounds) - (self.borderWidth * 4));
    }
    return returnRect;
}


- (void)calculateFrames {
    _indicatorFrame = [self calculateIndicatorFrame];
    
    _maxWidth = _indicatorFrame.size.width;
    _maxHeight = _indicatorFrame.size.height;
    
    CGFloat borderCornerRadius;
    CGFloat indicCornerRadius;
    
    if (self.isVertical) {
       borderCornerRadius = [self cornerRadiusWithMaxDim:CGRectGetMaxX(self.bounds)];
        indicCornerRadius = [self cornerRadiusWithMaxDim:CGRectGetMaxX(_indicatorFrame)];
    }else {
        borderCornerRadius = [self cornerRadiusWithMaxDim:CGRectGetMaxY(self.bounds)];
        indicCornerRadius = [self cornerRadiusWithMaxDim:CGRectGetMaxY(_indicatorFrame)];
    }
    _borderLayer.borderWidth = self.borderWidth;
    _borderLayer.cornerRadius = borderCornerRadius;
    _indicatorLayer.cornerRadius = indicCornerRadius;
    
    //reset level to new boundaries
    self.indicatorLevel = _currentLevel;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
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
    
    // CGFloat  cornerRadius;
    
    //set border defaults
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        self.borderWidth = 5.0f;
    }else {
        self.borderWidth = 4.0f;
    }

    _borderColour = [UIColor blackColor];
    _indicatorColour = [UIColor redColor];
    
    //indicator vertical by default
    _vertical = YES;
    
    //default min max level
    _minimumLevel = 0;
    _maximumLevel = 1;
    
    //setup borderlayer
    _borderLayer = [CALayer layer];
    _borderLayer.frame = self.bounds;
    
    //calculate frame sizes for border and indicator
    [self calculateFrames];
    /*
     if (self.isVertical) {
     cornerRadius = [self cornerRadiusWithMaxDim:CGRectGetMaxX(self.bounds)];
     }else {
     cornerRadius = [self cornerRadiusWithMaxDim:CGRectGetMaxY(self.bounds)];
     }
     */
    //_borderLayer.cornerRadius = cornerRadius;
    _borderLayer.contentsScale = [UIScreen mainScreen].scale;
    _borderLayer.backgroundColor = [UIColor clearColor].CGColor;
    _borderLayer.borderColor = self.borderColour.CGColor;
    _borderLayer.borderWidth = self.borderWidth;
    [self.layer addSublayer:_borderLayer];
    
    //set indicator default frame size
    /*
     _indicatorFrame = [self calculateIndicatorFrame];
     _maxHeight = _indicatorFrame.size.height;
     _maxWidth = _indicatorFrame.size.width;
     _indicatorFrame.size.height = 0;
     */
    //setup indicator layer
    _indicatorLayer = [CALayer layer];
    _indicatorLayer.backgroundColor = self.indicatorColour.CGColor;
    _indicatorLayer.opacity = 0.8f;
    //ensure layer is scaled for retina
    _indicatorLayer.contentsScale = [UIScreen mainScreen].scale;
    _indicatorLayer.frame = _indicatorFrame;
    /*
     if (self.isVertical) {
     cornerRadius = [self cornerRadiusWithMaxDim:CGRectGetMaxX(_indicatorFrame)];
     }else {
     cornerRadius = [self cornerRadiusWithMaxDim:CGRectGetMaxY(_indicatorFrame)];
     }
     _indicatorLayer.cornerRadius = cornerRadius;
     */
    [self.layer addSublayer:_indicatorLayer];
    
    //set initial level
    self.indicatorLevel = 0;
    
    
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
