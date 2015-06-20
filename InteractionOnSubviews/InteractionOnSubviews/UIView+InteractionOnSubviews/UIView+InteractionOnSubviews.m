//
//  UIView+InteractionOnSubviews.m
//  OnePasse
//
//  Created by Darlene on 13-9-20.
//  Copyright (c) 2013年 Elite. All rights reserved.
//

#import "UIView+InteractionOnSubviews.h"
#import <objc/runtime.h>

#define kPropertyAllowsInteractionOnSubviews @"allowsInteractionOnSubviews"
#define kPropertyAllowsInteractionOnSubviewsOutside @"allowsInteractionOnSubviewsOutside"

static NSDictionary * propertyDefaultValues;

@implementation UIView (InteractionOnSubviews)

+ (void)load {
    Method originMethod;
    Method customMethod;
    
    originMethod = class_getInstanceMethod(self, @selector(hitTest:withEvent:));
    customMethod = class_getInstanceMethod(self, @selector(customHitTest:withEvent:));
    method_exchangeImplementations(originMethod, customMethod);
    
    originMethod = class_getInstanceMethod(self, @selector(pointInside:withEvent:));
    customMethod = class_getInstanceMethod(self, @selector(customPointInside:withEvent:));
    method_exchangeImplementations(originMethod, customMethod);
    
    propertyDefaultValues = @{
          kPropertyAllowsInteractionOnSubviews: @YES,
          kPropertyAllowsInteractionOnSubviewsOutside: @NO
          };
}

- (UIView*)customHitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *view = [self customHitTest:point withEvent:event]; //will invoke original hitTest:withEvent:
    
    if (view && [self allowsInteractionOnSubviews] == NO) {
        view = self;
    }
    
    return view;
}

- (BOOL)customPointInside:(CGPoint)point withEvent:(UIEvent *)event {
    BOOL inside = NO;
    
    if ([self allowsInteractionOnSubviewsOutside] == NO) {
        inside = [self customPointInside:point withEvent:event]; //will invoke original pointInside:withEvent:
    }
    else {
        if (CGRectContainsPoint(self.frame, point)) {
            inside = YES;
        }
        else {
            for (UIView *subview in self.subviews) {
                CGPoint pointToSubview = [self convertPoint:point toView:subview];
                if ([subview pointInside:pointToSubview withEvent:event]) { // will invoke customPointInside:withEvent:
                    inside = YES;
                    break;
                }
            }
        }
    }
    
    return inside;
}

#pragma mark - Private
- (id)valueForCustomProperty:(NSString*)property {
    NSString *value = objc_getAssociatedObject(self, (__bridge const void *)(property));
    
    if (value == nil) {
        value = propertyDefaultValues[property];
    }
    
    return value;
}

#pragma mark - Public
- (void)setAllowsInteractionOnSubviewsOutside:(BOOL)allowsInteractionOnSubviewsOutside {
    objc_setAssociatedObject(self, kPropertyAllowsInteractionOnSubviewsOutside, @(allowsInteractionOnSubviewsOutside), OBJC_ASSOCIATION_RETAIN);
}

- (BOOL)allowsInteractionOnSubviewsOutside {
    return [[self valueForCustomProperty:kPropertyAllowsInteractionOnSubviewsOutside] boolValue];
}

- (void)setAllowsInteractionOnSubviews:(BOOL)allowsInteractionOnSubviews {
    objc_setAssociatedObject(self, kPropertyAllowsInteractionOnSubviews, @(allowsInteractionOnSubviews), OBJC_ASSOCIATION_RETAIN);
}

- (BOOL)allowsInteractionOnSubviews {
    return [[self valueForCustomProperty:kPropertyAllowsInteractionOnSubviews] boolValue];
}


@end
