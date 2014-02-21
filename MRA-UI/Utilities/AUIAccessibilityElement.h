//
//  AUIAccessibilityElement.h
//  aslicer
//
//  Created by mra on 28/06/2013.
//  Copyright (c) 2013 mra. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AUIAccessibilityDelegate <NSObject>
@optional
-(void)incrementWithIdentifier:(NSString*)identifier;
-(void)decrementWithIdentifier:(NSString*)identifier;
@end

@interface AUIAccessibilityElement : UIAccessibilityElement
@property (weak)id<AUIAccessibilityDelegate>delegate;

@end
