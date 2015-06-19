//
//  UIView+InteractionOnSubviews.h
//  OnePasse
//
//  Created by Darlene on 13-9-20.
//  Copyright (c) 2013年 Elite. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (InteractionOnSubviews)

- (void)setAllowsInteractionOnSubviews:(BOOL)allowsInteractionOnSubviews; // default is YES
- (void)setAllowsInteractionOnSubviewsOutside:(BOOL)allowsInteractionOnSubviewsOutside; // defaults is NO

@end
