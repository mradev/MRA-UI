//
//  MRAFillButton.h
//
//  Created by paul adams on 06/01/2014.
//  Copyright (c) 2014 dnbapp. All rights reserved.
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
//
// Custom Button Class which has a fill indicator to show progress status
//
#import <UIKit/UIKit.h>

@interface MRAFillButton :UIControl

//output values min and max
@property(assign,nonatomic)CGFloat minimumValue;
@property(assign,nonatomic)CGFloat maximumValue;

//fill color background
@property(strong,nonatomic)UIColor *backgroundFill;

//button fill layer foregorund used as the indicator
@property(strong,nonatomic)UIColor *foreGroundFill;

//button curve, default is 0.25
@property(assign,nonatomic)CGFloat buttonCornerRadius;

// whether button stays selected when touched
@property(assign,nonatomic,getter = isSelectHeld)BOOL selectHold;

// button selectable state
@property(assign,nonatomic,getter = isSelectable)BOOL selectable;

//button fill information
@property(readonly,getter = isFilled)BOOL buttonFilled;
@property (readonly,nonatomic)float fillStatus;


//fill layer progress
-(void)fillButtonWithValue:(CGFloat)value;

//set the fill layer to zero
-(void)resetButtonToEmpty;


@end
