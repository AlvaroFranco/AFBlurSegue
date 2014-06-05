//
//  ViewController.h
//  AFBlurSegue-Demo
//
//  Created by Alvaro Franco on 6/5/14.
//  Copyright (c) 2014 AlvaroFranco. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (nonatomic, strong) IBOutlet UIButton *button;
@property (nonatomic, strong) IBOutlet UISwitch *blurSwitch;
@property (nonatomic, strong) IBOutlet UISegmentedControl *transitionSegmentedControl;

-(void)showModalViewController;
-(void)switchChanged;

@end
