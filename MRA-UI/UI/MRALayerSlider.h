//
//  MRALayerSlider.h
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


//A SLider UI Element which uses layer animation to move the slider cursor.

#import <UIKit/UIKit.h>

@interface MRALayerSlider : UIControl

//slider appearance
@property(strong,nonatomic)UIColor *cursorStrokeColour;
@property(strong,nonatomic)UIColor *cursorColour;
@property (strong,nonatomic)UIColor *borderColour;
@property (assign,nonatomic)CGFloat borderWidth;
@property (assign,nonatomic)CGFloat curvePercent;

//vertical style slider, horizontal by default
@property (assign,nonatomic,getter = isVertical)BOOL vertical;

//create a circular style style slider
@property (assign,nonatomic,getter = isCircular)BOOL circular;

@property(readonly,nonatomic)NSNumber *outValue;
@property(readonly,nonatomic,getter = isMoving)BOOL moving;

//output values min and max
@property(assign,nonatomic)CGFloat minimumValue;
@property(assign,nonatomic)CGFloat maximumValue;

//set cursor position
-(void)cursorPosition:(CGFloat)position;

@end
