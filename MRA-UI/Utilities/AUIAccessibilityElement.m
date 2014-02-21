//
//  AUIAccessibilityElement.m
//  aslicer
//
//  Created by mra on 28/06/2013.
//  Copyright (c) 2013 mra. All rights reserved.
//

#import "AUIAccessibilityElement.h"

@implementation AUIAccessibilityElement

- (void)accessibilityIncrement {
    if ([self.delegate respondsToSelector:@selector(incrementWithIdentifier:)]) {
        [self.delegate incrementWithIdentifier:self.accessibilityIdentifier];
    }
}

- (void)accessibilityDecrement {
    if ([self.delegate respondsToSelector:@selector(decrementWithIdentifier:)]) {
        [self.delegate decrementWithIdentifier:self.accessibilityIdentifier];
    }
}


@end
