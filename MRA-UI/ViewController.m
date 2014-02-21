//
//  ViewController.m
//  MRA-UI
//
//  Created by paul adams on 20/02/2014.
//  Copyright (c) 2014 dnbapp. All rights reserved.
//

#import "ViewController.h"
#import "MRAFillButton.h"
#import "MRAIndicator.h"
#import "MRAViewSlider.h"
#import "MRALayerSlider.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet MRAIndicator *horizontalLevel;
@property (weak, nonatomic) IBOutlet MRAIndicator *verticalLevel;
@property (weak, nonatomic) IBOutlet MRAFillButton *fillButton;

@end

@implementation ViewController


#pragma mark setters

- (void)setFillButton:(MRAFillButton *)fillButton {
    _fillButton = fillButton;
    [_fillButton fillButtonWithValue:0.5];
    _fillButton.selectHold = NO;
    
}

- (void)setHorizontalLevel:(MRAIndicator *)horizontalLevel {
    _horizontalLevel = horizontalLevel;
    _horizontalLevel.indicatorLevel = 0.4f;
}

- (void)setVerticalLevel:(MRAIndicator *)verticalLevel {
    
    _verticalLevel = verticalLevel;
    _verticalLevel.indicatorLevel = 0.4f;
}




- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
