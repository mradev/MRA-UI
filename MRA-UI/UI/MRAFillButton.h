//
//  UIControl+UIFillButton.h
//  soundgarden
//
//  Created by paul adams on 06/01/2014.
//  Copyright (c) 2014 dnbapp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFillButton :UIControl

@property(assign,nonatomic)CGFloat minimumValue;
@property(assign,nonatomic)CGFloat maximumValue;
@property(strong,nonatomic)UIColor *backgroundFill;
@property(strong,nonatomic)UIColor *foreGroundFill;
@property(readonly,getter = isFilled)BOOL buttonFilled;
@property (readonly,nonatomic)float fillStatus;
@property(assign,nonatomic,getter = isSelectHeld)BOOL selectHold;
@property(assign,nonatomic,getter = isSelectable)BOOL selectable;

-(void)fillButtonWithValue:(CGFloat)value;
-(void)resetButtonToEmpty;


@end
