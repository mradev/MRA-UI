//
//  UIFillButton.m
//  soundgarden
//
//  Created by paul adams on 06/01/2014.
//  Copyright (c) 2014 dnbapp. All rights reserved.
//
// Custom UIButton Class which has a fill indicator to show progress status



//custom layer for drawing the buttons fill


#import "UIFillButton.h"
#import "UIView+additions.h"
#import  <QuartzCore/QuartzCore.h>
#import "ScaleValue.h"

@interface UIFillButton ()
@property (strong,nonatomic)CALayer *fillLayer;
@property (nonatomic, strong) CALayer *maskLayer;
@property (assign,nonatomic,getter = isFilled)BOOL buttonFilled;
@property (assign,nonatomic)float fillStatus;
@end


@implementation UIFillButton {
    CGRect _layerFrame;
    CALayer *_maskLayer;
}

#pragma mark Button Draw Methods
- (CALayer *)fillLayer {
    if (!_fillLayer) {
            _fillLayer = [CALayer layer];
    }
    return _fillLayer;
}

- (void)setBackgroundFill:(UIColor *)backgroundFill {
    _backgroundFill = backgroundFill;
    [self setNeedsDisplay];
}

- (void)setForeGroundFill:(UIColor *)foreGroundFill {
    _foreGroundFill = foreGroundFill;
    [self configureForegroundLayer];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        [self initDefaults];
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initDefaults];
    }
    return self;
}

- (void)initDefaults {
    
    self.backgroundColor = [UIColor clearColor];
    self.opaque = NO;
    //set min and max value for status
    _minimumValue = 0;
    _maximumValue = 1.0f;
    
    //button not filled by default
    _buttonFilled = NO;
    
    //button is selectable by default;
    _selectHold = YES;
    _selectable = YES;
    
    //set default colour for layer
    self.fillLayer.backgroundColor = [UIColor grayColor].CGColor;
    self.fillLayer.opacity = 0.3f;
    //ensure layer is scaled for retina
    self.fillLayer.contentsScale = [UIScreen mainScreen].scale;
    _layerFrame = self.bounds;
    _layerFrame.size.width = 0;
    
    //create mask for square fill
    _maskLayer = [CALayer layer];
    _maskLayer.frame = self.bounds;
    _maskLayer.cornerRadius = [self cornerRadius];
    _maskLayer.backgroundColor = [UIColor blackColor].CGColor;
    self.layer.mask = _maskLayer;
    //add fill layer, which is resizeable
    [self.layer addSublayer:self.fillLayer];
    
}

- (void)configureForegroundLayer {
    self.fillLayer.backgroundColor = self.foreGroundFill.CGColor;
    [self.fillLayer setNeedsDisplay];
}

- (void)fillButtonWithValue:(CGFloat)value {
    if (value <= self.maximumValue) {
        self.fillStatus = value;
        CGFloat width = [ScaleValue scaleFloat:value
                                       withSrc:self.minimumValue
                                     andsrcMax:self.maximumValue
                                   usingnewMin:CGRectGetMinX(self.bounds)
                                     andnewMax:CGRectGetMaxX(self.bounds)];
        _layerFrame.size.width = width;
        self.fillLayer.frame = _layerFrame;
    }else {
        self.buttonFilled = YES;
    }
}

- (void)resetButtonToEmpty{
    //set fill layer to 0
    _layerFrame.size.width = 0;
    self.fillLayer.frame = _layerFrame;
    self.buttonFilled = NO;
    self.fillStatus = 0;
}

- (CGFloat)cornerRadius {
    return (CGRectGetMaxY(self.bounds) * 0.25);
}

- (void)drawRect:(CGRect)rect {
    //draw button background
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    UIBezierPath *uiPath = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:0];
    CGContextSaveGState(ctx);
    if (!self.backgroundFill) {
        [[UIColor colorWithRed:1.0f green:0.0f blue:0.0f alpha:0.1f]setFill];
    }else {
         [[UIColor colorWithRed:1.0f green:0.0f blue:0.0f alpha:0.1f]setFill];
        [self.backgroundFill setFill];
    }
    [uiPath fill];
    CGContextRestoreGState(ctx);
}

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    
    if (!self.isSelectHeld) {
        if (highlighted && self.isSelectable) {
            self.fillLayer.opacity = 1.0f;
        } else {
            self.fillLayer.opacity = 0.4f;
        }
    }
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    if (selected && self.isSelectable) {
      
        self.fillLayer.opacity = 1.0f;
    }else {
       // NSLog(@"not selected");
        self.fillLayer.opacity = 0.4f;
    }

}

#pragma mark UIControl Methods
- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    if (CGRectContainsPoint(self.bounds,[touch locationInView: self])) {
        if (self.isSelectHeld) {
            self.selected = !self.selected;
        }else {
        
        self.selected = YES;
        }
    }
[self sendActionsForControlEvents:UIControlEventValueChanged];
return [super beginTrackingWithTouch:touch withEvent:event];
}

- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    
    if (CGRectContainsPoint(self.bounds,[touch locationInView: self])) {
        //[self cancelTrackingWithEvent:event];
        [self sendActionsForControlEvents:UIControlEventTouchDragInside];
    }else  {
         [self sendActionsForControlEvents:UIControlEventTouchDragOutside];
    }
    return  [super continueTrackingWithTouch:touch withEvent:event];
}

- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    [super endTrackingWithTouch:touch withEvent:event];
   // if (CGRectContainsPoint(self.bounds,[touch locationInView: self]))
    //{
        if (self.isSelectHeld) {
             //self.selected = !self.selected;
        }else {
            self.selected = NO;
        }
        [self sendActionsForControlEvents:UIControlEventValueChanged];
   // }
}

- (void)cancelTrackingWithEvent:(UIEvent *)event {
    
    [super cancelTrackingWithEvent:event];
    if (self.isSelectHeld) {
        // self.selected = !self.selected;
    }else {
        self.selected = NO;
    }    
      [self sendActionsForControlEvents:UIControlEventValueChanged];
}



@end
