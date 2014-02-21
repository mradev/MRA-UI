#import "ScaleValue.h"

@implementation ScaleValue

+(double)scaleDouble:(double)srcValue withSrc:(double)min andsrcMax:(double)max usingnewMin:(double)nMin andnewMax:(double)nMax

{
    double newValue;
    
    
    
    newValue = (((srcValue - min) * (nMax - nMin)) / (max - min)) + nMin;
    
   // return modf(newValue, &nMax);
    
    /*
    if (newValue >= nMin && newValue <= nMax) 
    {
        holdingVal = newValue;
    }
    */
    //return holdingVal;
    return newValue;
    
}





+(float)scaleFloat:(float)srcValue withSrc:(float)min andsrcMax:(float)max usingnewMin:(float)nMin andnewMax:(float)nMax {
    
    float newValue;
    
    newValue = (((srcValue - min) * (nMax - nMin)) / (max - min)) + nMin;

    return newValue;    
}

+(float)scaleFloatClipped:(float)srcValue withSrc:(float)min andsrcMax:(float)max usingnewMin:(float)nMin andnewMax:(float)nMax {
    
    float newValue;
    newValue = (((srcValue - min) * (nMax - nMin)) / (max - min)) + nMin;
     return modff(newValue, &nMax);
}




-(double)scaleDouble:(double)srcValue withSrc:(double)min andsrcMax:(double)max usingnewMin:(double)nMin andnewMax:(double)nMax

{
    double newValue;
    newValue = (((srcValue - min) * (nMax - nMin)) / (max - min)) + nMin;
     //return modf(newValue, &nMax);
    
    return newValue;
    
}

-(float)scaleFloat:(float)srcValue withSrc:(float)min andsrcMax:(float)max usingnewMin:(float)nMin andnewMax:(float)nMax {
    float newValue;
    newValue = (((srcValue - min) * (nMax - nMin)) / (max - min)) + nMin;
    return modff(newValue, &nMax);
    
    
}

double biasedRandomno(double min,double max,double minfract,double maxfract) {
    
    //get random number between zero and one
    float randomno = randzeroone();
    //lower fractions nearer to max value
    float randbias =  pow(randomno, log(minfract) / log(maxfract));
    
    return (float)(max - min) * randbias + min;
}

static inline double randzeroone() {
    return (double)rand() / (double)RAND_MAX;
}



@end