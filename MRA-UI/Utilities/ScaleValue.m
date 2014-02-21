#import "ScaleValue.h"

@implementation ScaleValue

+(double)scaleDouble:(double)srcValue
             withSrc:(double)min
           andsrcMax:(double)max
         usingnewMin:(double)nMin
           andnewMax:(double)nMax
{
     double newValue = (((srcValue - min) * (nMax - nMin)) / (max - min)) + nMin;
    return newValue;
}





+(float)scaleFloat:(float)srcValue
           withSrc:(float)min
         andsrcMax:(float)max
       usingnewMin:(float)nMin
         andnewMax:(float)nMax {
    
     float newValue = (((srcValue - min) * (nMax - nMin)) / (max - min)) + nMin;
    return newValue;    
}




@end