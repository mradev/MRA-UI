//
//  UIView+additions.m
//  aslicer
//
//  Created by mra on 10/08/2013.
//  Copyright (c) 2013 mra. All rights reserved.
//

#import "UIView+additions.h"
#import <objc/runtime.h>

NSString * const kUITagKey = @"kUITagKey";
NSString * const kGroupTagKey = @"kGroupTagKey";
NSString * const kXShadowKey = @"kXShadowKey";
NSString * const kYShadowKey = @"kYShadowKey";

@implementation UIView(extras)

- (void)setUiTag:(NSString *)uiTag
{
	objc_setAssociatedObject(self, (__bridge const void *)(kUITagKey), uiTag, OBJC_ASSOCIATION_COPY);
}

- (NSString*)uiTag
{
	return objc_getAssociatedObject(self, (__bridge const void *)(kUITagKey));
}

- (NSString *)groupTag{
    
    return  objc_getAssociatedObject(self, (__bridge const void *)(kGroupTagKey));
}

- (void)setGroupTag:(NSString *)groupTag {
    
    objc_setAssociatedObject(self, (__bridge const void *)(kGroupTagKey), groupTag, OBJC_ASSOCIATION_COPY);
    
}


-(void)setXShadow:(CGFloat)xShadow {
    
    objc_setAssociatedObject(self,(__bridge const void *)(kXShadowKey),[NSNumber numberWithFloat:xShadow], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(CGFloat)xShadow {
    return [objc_getAssociatedObject(self,(__bridge const void *)kXShadowKey)floatValue];
}

-(void)setYShadow:(CGFloat)yShadow {
    
    objc_setAssociatedObject(self,(__bridge const void *)(kYShadowKey),[NSNumber numberWithFloat:yShadow], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(CGFloat)yShadow {
    return [objc_getAssociatedObject(self,(__bridge const void *)kXShadowKey)floatValue];
}




@end
