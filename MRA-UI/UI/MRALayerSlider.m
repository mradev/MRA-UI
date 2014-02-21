//
//  MRALayerSlider.m
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



#import "MRALayerSlider.h"
#import "ScaleValue.h"

@interface MRALayerSlider()
@property (strong,nonatomic)CALayer *cursorLayer;
@property (strong,nonatomic)CALayer *borderLayer;
@property(strong,nonatomic)NSNumber *outValue;
@property(assign,nonatomic,getter = isMoving)BOOL moving;
@property (assign,nonatomic)BOOL viewPadding;
@end

//output defaults
static const float MINOUTVALUE = 0;
static const float MAXOUTVALUE = 1.0f;

//cursor
static const CGFloat CURSOR_PERCENT_BOUNDS = 0.90f;
static const CGFloat THUMB_PADDING = 12.0f;

//slider Curve
static const CGFloat DEF_CURVE_PERCENTAGE = 0.25f;
static const CGFloat CIRCULAR_CURVE = 0.5f;

//border width
static const CGFloat DEF_iPAD_BORDER_WIDTH = 3.0f;
static const CGFloat DEF_iPHONE_BORDER_WIDTH = 2.0f;



@implementation MRALayerSlider {
    
    CGFloat _cursorDiameter;
    CGFloat _cursorPercentOfBounds;
    CGFloat _cursorBorderWidth;
    CGRect _cursorFrame;
    CGRect _railFrame;
    CGRect _thumbPad;
    CGFloat _newX;
    CGFloat _newY;
    CGFloat _maxPoint;

}


#pragma mark setters

- (void)setCursorStrokeColour:(UIColor *)cursorStrokeColour {
    _cursorStrokeColour = cursorStrokeColour;
    [self configureCursorStrokeColour];
}
- (void)setCursorColour:(UIColor *)cursorColour {
    _cursorColour = cursorColour;
    [self configureCursorColour];
}

- (void)setBorderColour:(UIColor *)borderColour {
    _borderColour = borderColour;
    [self configureBorderColour];
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    _borderWidth = borderWidth;
    [self configureLayers];
}

- (void)setVertical:(BOOL)vertical {
    _vertical = vertical;
    [self configureLayers];
}

-(void)setOutValue:(NSNumber *)outValue {
    _outValue = outValue;
    self.accessibilityValue = [outValue stringValue];
}

- (void)setCircular:(BOOL)circular {
    _circular = circular;
    _curvePercent = CIRCULAR_CURVE;
    [self configureLayers];
}

- (void)setCurvePercent:(CGFloat)curvePercent {
    _curvePercent = curvePercent;
    
    if (!_circular) {
        _curvePercent = curvePercent;
    }
    [self configureLayers];
}

#pragma mark getters

- (CALayer *)cursorLayer {
    if (!_cursorLayer) {
        _cursorLayer = [CALayer layer];
    }
    return _cursorLayer;
}

- (CALayer *)borderLayer {
    if (!_borderLayer) {
        _borderLayer = [CALayer layer];
    }
    return _borderLayer;
}

- (CGFloat)cornerRadiusWithMaxDiameter:(CGFloat )diameter {
    return diameter * _curvePercent;
}

- (CGFloat)cursorCenterPoint {
    CGFloat center;
    if (self.isVertical) {
        center = CGRectGetMidX(self.bounds) - (_cursorDiameter * 0.5);
    } else {
        center = CGRectGetMidY(self.bounds) - (_cursorDiameter * 0.5);
    }
    return center;
}

- (CGFloat)maxCursorDiameterWithRect:(CGRect)drect {
    
    CGFloat diameter;
    if (self.isVertical) {
         diameter = CGRectGetMaxX(drect) * _cursorPercentOfBounds;
    } else {
         diameter = CGRectGetMaxY(drect) * _cursorPercentOfBounds;
    }
    return diameter;
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initDefaultSettings];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        
        [self initDefaultSettings];
    }
    
    return self;
}

- (void)initDefaultSettings {
    
    [self setBackgroundColor:[UIColor clearColor]];
    self.opaque = NO;
    
    //cursor defaults
    _cursorPercentOfBounds = CURSOR_PERCENT_BOUNDS;
    //border defaults
    
    
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        self.borderWidth = DEF_iPAD_BORDER_WIDTH;
    }else {
        self.borderWidth = DEF_iPHONE_BORDER_WIDTH;
    }
    
    //percent to curve on corner radius
    _curvePercent = DEF_CURVE_PERCENTAGE;
    
    //cursor border set same as border layer, could change this
    _cursorBorderWidth = _borderWidth;
    
    //input/output value defaults
    _minimumValue = MINOUTVALUE;
    _maximumValue = MAXOUTVALUE;
    
    //set layer frames
    [self configureLayers];
    
    //setup the borderlayer view defaults
    self.borderLayer.backgroundColor = [UIColor clearColor].CGColor;
    
    //retina set
    self.borderLayer.contentsScale = [UIScreen mainScreen].scale;
    
    [self.layer addSublayer:self.borderLayer];
    
    //setup the cursorlayer view defaults
    self.borderLayer.borderColor = [UIColor blackColor].CGColor;
    self.cursorLayer.borderColor = [UIColor blackColor].CGColor;
    self.cursorLayer.backgroundColor = [UIColor clearColor].CGColor;
    
    //retina set
    self.cursorLayer.contentsScale = [UIScreen mainScreen].scale;
    
    [self.layer addSublayer:self.cursorLayer];
}

#pragma mark draw Methods

- (void)configureBorderColour {
    self.borderLayer.borderColor = self.borderColour.CGColor;
    [self.borderLayer setNeedsDisplay];
}

- (void)configureCursorStrokeColour {
    self.cursorLayer.borderColor = self.cursorStrokeColour.CGColor;
    [self.cursorLayer setNeedsDisplay];
}
- (void)configureCursorColour {
    self.cursorLayer.backgroundColor = self.cursorColour.CGColor;
    [self.cursorLayer setNeedsDisplay];
}

- (void)configureLayers {
    CGFloat radius;
    if (self.isVertical) {
        radius = [self cornerRadiusWithMaxDiameter:CGRectGetMaxX(self.bounds)];
    }else {
        radius = [self cornerRadiusWithMaxDiameter:CGRectGetMaxY(self.bounds)];
    }
    self.borderLayer.cornerRadius = radius;
    self.borderLayer.borderWidth = _borderWidth;
    //set border frame
    self.borderLayer.frame = self.bounds;
    
    //rect in which the cursor inhabits
    _railFrame = CGRectInset(self.bounds, _borderWidth * 2, _borderWidth * 2);
    
    //set up the cursor layer defaults
    CGFloat maxDiameter = [self maxCursorDiameterWithRect:_railFrame];
    
    //get max diameter of cursor
    _cursorDiameter = maxDiameter;
    radius = [self cornerRadiusWithMaxDiameter:_cursorDiameter];
    self.cursorLayer.cornerRadius = radius;
    
    
    //set cursor border
    self.cursorLayer.borderWidth = _borderWidth;
    CGFloat cursorCenter = [self cursorCenterPoint];
    
    //set cursor frame vertical and horizontal
    if (self.isVertical) {
        _cursorFrame = CGRectMake(cursorCenter,
                                  CGRectGetMaxY(_railFrame) - _cursorDiameter,
                                  _cursorDiameter,_cursorDiameter);
    }else {
        _cursorFrame = CGRectMake(CGRectGetMinX(_railFrame),
                                  cursorCenter,
                                  _cursorDiameter,_cursorDiameter);
    }
    self.cursorLayer.frame = _cursorFrame;
}


-(CGRect)thumbArea {
    CGRect paddedRect;
    paddedRect = CGRectMake(CGRectGetMinX(_cursorFrame) - (THUMB_PADDING),
                            CGRectGetMinY(_cursorFrame) - (THUMB_PADDING),
                            _cursorFrame.size.width + (THUMB_PADDING * 2),
                            _cursorFrame.size.height + (THUMB_PADDING * 2));
    return paddedRect;
}



#pragma mark UIAccessibility delegate
-(UIAccessibilityTraits)accessibilityTraits {
    return [super accessibilityTraits] | UIAccessibilityTraitAdjustable;
}

-(void)accessibilityIncrement {
    float finalVal = [self.outValue floatValue];
    finalVal  = finalVal +0.05;
    if (finalVal > self.maximumValue) {
        finalVal = self.maximumValue;
    }
    self.outValue = @(finalVal);
    [self cursorPosition:[self.outValue floatValue]];
    
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

-(void)accessibilityDecrement {
    float finalVal = [self.outValue floatValue];
    finalVal  = finalVal -0.05;
    if (finalVal < 0) {
        finalVal = 0;
    }
    self.outValue = @(finalVal);
    [self cursorPosition:[self.outValue floatValue]];
    
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

#pragma mark UIControl Methods


- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    self.moving = YES;
    CGPoint touchPoint = [touch locationInView:self];
    _thumbPad = [self thumbArea];
    if(CGRectContainsPoint(_thumbPad, touchPoint)) {
        _newX =  touchPoint.x -  _cursorFrame.size.width * 0.5;
        _newY =  touchPoint.y - _cursorFrame.size.height * 0.5;
        [self updateCursorPosition];
    }
    [self sendActionsForControlEvents:UIControlEventValueChanged];
    return [super beginTrackingWithTouch:touch withEvent:event];
}


- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    self.moving = YES;
    CGPoint touchPoint = [touch locationInView:self];
     _thumbPad = [self thumbArea];
    
    //view padding region
    if (self.viewPadding) {
        [self setNeedsDisplay];
    }
      if(CGRectContainsPoint(_thumbPad, touchPoint)) {
          _newX =  touchPoint.x -  _cursorFrame.size.width * 0.5;
          _newY =  touchPoint.y - _cursorFrame.size.height * 0.5;
          [self updateCursorPosition];
      }
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    return [super continueTrackingWithTouch:touch withEvent:event];
}

- (void)cancelTrackingWithEvent:(UIEvent *)event {
     self.moving = NO;
    [super cancelTrackingWithEvent:event];
}

- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    self.moving = NO;
    [super endTrackingWithTouch:touch withEvent:event];
}

#pragma mark public methods
- (void)cursorPosition:(CGFloat)position {

    if (position >= self.minimumValue && position <= self.maximumValue) {
        
        //set current slider value to input value
        self.outValue = @(position);
        
        CGFloat maxPoint;
        CGFloat minPoint;
        
        _newX =  _cursorFrame.size.width * 0.5;
        _newY =  _cursorFrame.size.height * 0.5;
        
        if (self.isVertical) {
            maxPoint = CGRectGetMaxY(_railFrame) - _cursorFrame.size.width;
            minPoint = CGRectGetMinY(_railFrame);
        }else {
            maxPoint = CGRectGetMaxX(_railFrame) - _cursorFrame.size.width;
            minPoint = CGRectGetMinX(_railFrame);
        }
        CGFloat trackPoint;
        
        if (self.isVertical ) {
            trackPoint  = [ScaleValue scaleFloat:position
                                         withSrc:self.minimumValue
                                       andsrcMax:self.maximumValue
                                     usingnewMin:maxPoint
                                       andnewMax:minPoint];

            _cursorFrame.origin.y = trackPoint;
        }else {
            trackPoint = [ScaleValue scaleFloat:position
                                        withSrc:self.minimumValue
                                      andsrcMax:self.maximumValue
                                    usingnewMin:minPoint
                                      andnewMax:maxPoint];
    
            _cursorFrame.origin.x = trackPoint;
        }
        [self cursorUpdate];
    }
}

#pragma mark private methods
- (void)updateCursorPosition {
    
    CGFloat maxPoint;
    CGFloat minPoint;
    CGFloat locationPass;
    CGFloat finalLocation;
    CGFloat trackPoint;
    //get maximum point for fader
    if (self.isVertical)
    {
        trackPoint = _newY;
        maxPoint = CGRectGetMaxY(_railFrame) - _cursorFrame.size.width;
        minPoint = CGRectGetMinY(_railFrame);
        locationPass = MIN(_newY,maxPoint);
        finalLocation = MAX(minPoint, locationPass);
        _cursorFrame.origin.y = finalLocation;
    } else {
        trackPoint = _newX;
        maxPoint = CGRectGetMaxX(_railFrame) - _cursorFrame.size.width;
        minPoint = CGRectGetMinX(_railFrame);
        locationPass = MIN(_newX,maxPoint);
        finalLocation = MAX(minPoint, locationPass);
        _cursorFrame.origin.x = finalLocation;
    }
    
    //refresh rect pos
    [self cursorUpdate];
    
     //output values on fader when moved set min and max points
    if (trackPoint <= minPoint)trackPoint = minPoint;
    if (trackPoint >= maxPoint) trackPoint = floorf(maxPoint);
    
    if (self.isVertical) {
         self.outValue = @([ScaleValue scaleFloat:trackPoint
                                          withSrc:abs(minPoint)
                                        andsrcMax:abs(maxPoint)
                                      usingnewMin:self.maximumValue
                                        andnewMax:self.minimumValue]);
     }else {
         self.outValue = @([ScaleValue scaleFloat:trackPoint
                                          withSrc:abs(minPoint)
                                        andsrcMax:abs(maxPoint)
                                      usingnewMin:self.minimumValue
                                        andnewMax:self.maximumValue]);
     }
}


//update layer frame - animates
- (void)cursorUpdate {
    self.cursorLayer.frame = _cursorFrame;
}

//to test thumb padding area only
/*
- (void)drawRect:(CGRect)rect
{
    //to test padding area only
    CGContextRef context = UIGraphicsGetCurrentContext();
     CGPathRef padpath = CGPathCreateWithRect(_thumbPad,nil);
     CGContextSaveGState(context); {
     CGContextSetFillColorWithColor(context,[UIColor colorWithRed:1 green:0 blue:0 alpha:0.5].CGColor);
     CGContextFillPath(context);
     CGContextAddPath(context,padpath);
     CGContextDrawPath(context, kCGPathFill);
     CGContextRestoreGState(context);
     }
     
}
*/




@end
