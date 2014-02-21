//
//  VInidcator.h
//  testingstuff
//
//  Created by paul adams on 07/01/2014.
//  Copyright (c) 2014 paul adams. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VInidcator : UIView
@property (strong,nonatomic)UIColor *borderColour;
@property (strong,nonatomic)UIColor *indicatorColour;
@property (assign,nonatomic,getter = isVertical)BOOL vertical;
@property (assign,nonatomic)CGFloat indicatorLevel;
@property (assign,nonatomic)CGFloat minimumLevel;
@property (assign,nonatomic)CGFloat maximumLevel;
@property (assign,nonatomic)CGFloat borderWidth;
@end
