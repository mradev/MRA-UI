//
//  AUIAccessibilityElement.m
//  aslicer
//
//  Created by mra on 28/06/2013.
//  Copyright (c) 2013 mra. All rights reserved.
//

#import "AUIAccessibilityElement.h"

@implementation AUIAccessibilityElement


-(void)accessibilityIncrement {
    
    [self.delegate incrementWithIdentifier:self.accessibilityIdentifier];
}

-(void)accessibilityDecrement {
    [self.delegate decrementWithIdentifier:self.accessibilityIdentifier];
}


@end
