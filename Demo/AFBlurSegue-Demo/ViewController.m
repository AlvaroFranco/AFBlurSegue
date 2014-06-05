//
//  ViewController.m
//  AFBlurSegue-Demo
//
//  Created by Alvaro Franco on 6/5/14.
//  Copyright (c) 2014 AlvaroFranco. All rights reserved.
//

#import "ViewController.h"
#import "AFBlurSegue.h"

@interface ViewController ()

@property (nonatomic) BOOL blur;
@property (nonatomic) int transitionStyle;

@end

@implementation ViewController

-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

-(void)viewDidLoad {
    [super viewDidLoad];

    _blur = YES;
    
    [_button addTarget:self action:@selector(showModalViewController) forControlEvents:UIControlEventTouchUpInside];
    [_blurSwitch addTarget:self action:@selector(switchChanged) forControlEvents:UIControlEventValueChanged];
}

-(void)showModalViewController {
    
    [self performSegueWithIdentifier:_blur ? @"blurSegue" : @"noBlurSegue" sender:self];
}

-(void)switchChanged {
    
    if ([_blurSwitch isOn]) {
        _blur = YES;
    } else {
        _blur = NO;
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
        
    UIViewController *destination = segue.destinationViewController;
    
    switch (_transitionSegmentedControl.selectedSegmentIndex) {
        case 0:
            destination.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
            break;
            
        case 1:
            destination.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            break;
            
        case 2:
            destination.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
            break;
            
        case 3:
            destination.modalTransitionStyle = UIModalTransitionStylePartialCurl;
            break;
            
        default:
            break;
    }
}

@end
