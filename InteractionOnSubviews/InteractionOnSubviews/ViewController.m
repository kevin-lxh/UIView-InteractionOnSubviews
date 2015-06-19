//
//  ViewController.m
//  InteractionOnSubviews
//
//  Created by Tina on 15/6/19.
//  Copyright (c) 2015年 Tina. All rights reserved.
//

#import "ViewController.h"
#import "UIView+InteractionOnSubviews.h"

@interface ViewController () {
    __weak IBOutlet UIButton *_button;
    __weak IBOutlet UIView *_viewA;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _button.titleLabel.numberOfLines = 3;
    _button.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [_viewA setAllowsInteractionOnSubviewsOutside:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Handler
- (IBAction)buttonHandler:(id)sender {
    NSLog(@"%s Tap", __func__);
}


@end
