//
//  ACGSlider.h
//  testingstuff
//
//  Created by paul adams on 07/01/2014.
//  Copyright (c) 2014 paul adams. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MRAViewSlider : UIControl

@property(strong,nonatomic)UIColor *cursorStrokeColour;
@property(strong,nonatomic)UIColor *cursorColour;
@property (strong,nonatomic)UIColor *borderColour;
@property (assign,nonatomic)CGFloat borderWidth;
@property (assign,nonatomic,getter = isVertical)BOOL vertical;
@property (assign,nonatomic,getter = isCircular)BOOL circular;
@property(assign,nonatomic)CGFloat minimumValue;
@property(assign,nonatomic)CGFloat maximumValue;
@property(readonly,nonatomic)NSNumber *outValue;
@property(readonly,nonatomic,getter = isMoving)BOOL moving;


-(void)cursorPosition:(CGFloat)position;

@end
