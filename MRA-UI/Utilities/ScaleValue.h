//
//  ScaleValue.h
//  Aslicer
//
//  Created by mra on 13/04/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScaleValue : NSObject

+(double)scaleDouble:(double)srcValue
             withSrc:(double)min
           andsrcMax:(double)max
         usingnewMin:(double)nMin
           andnewMax:(double)nMax;

+(float)scaleFloat:(float)srcValue
           withSrc:(float)min
         andsrcMax:(float)max
       usingnewMin:(float)nMin
         andnewMax:(float)nMax;






@end
