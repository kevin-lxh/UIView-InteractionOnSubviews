//
//  UIView+InteractionOnSubviews.h
//  OnePasse
//
//  Created by Darlene on 13-9-20.
//  Copyright (c) 2013年 Elite. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (InteractionOnSubviews)

- (void)setAllowsInteractionOnSubviewsOutside:(BOOL)allowsInteractionOnSubviewsOutside; // defaults is NO
- (void)setAllowsInteractionOnSubviews:(BOOL)allowsInteractionOnSubviews; // default is YES

@end
