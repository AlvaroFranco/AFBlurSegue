//
//  AFBlurSegue.m
//  AFBlurSegue-Demo
//
//  Created by Alvaro Franco on 6/5/14.
//  Copyright (c) 2014 AlvaroFranco. All rights reserved.
//

#import "AFBlurSegue.h"
#import "UIImage+ImageEffects.h"

@implementation AFBlurSegue

-(id)initWithIdentifier:(NSString *)identifier source:(UIViewController *)source destination:(UIViewController *)destination {
    
    self = [super initWithIdentifier:identifier source:source destination:destination];
    
    if (self) {
        _blurRadius = 20;
        _tintColor = [UIColor clearColor];
        _saturationDeltaFactor = 0.5;
    }
    
    return self;
}

-(void)perform {
    
    UIViewController *sourceController = self.sourceViewController;
    UIViewController *destinationController = self.destinationViewController;
    
    if (NSFoundationVersionNumber <= NSFoundationVersionNumber_iOS_7_1) {
        
        UIImage *background = [UIImage new];
        
        if ([sourceController isKindOfClass:[UITableViewController class]]) {
            
            UIView *viewToRender = [(UITableViewController *)sourceController tableView];
            CGPoint contentOffset = [[(UITableViewController *)sourceController tableView]contentOffset];
            
            UIGraphicsBeginImageContext(viewToRender.bounds.size);
            CGContextRef context = UIGraphicsGetCurrentContext();
            CGContextTranslateCTM(context, 0, -contentOffset.y);
            [viewToRender.layer renderInContext:context];
            background = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
        } else {
            
            UIGraphicsBeginImageContextWithOptions(sourceController.view.bounds.size, YES, 0);
            CGContextRef context = UIGraphicsGetCurrentContext();
            [sourceController.view.layer renderInContext:context];
            background = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
        }
        
        switch ([[UIApplication sharedApplication]statusBarOrientation]) {
            case UIInterfaceOrientationPortrait:
                background = [UIImage imageWithCGImage:background.CGImage scale:1 orientation:UIImageOrientationUp];
                break;
                
            case UIInterfaceOrientationPortraitUpsideDown:
                background = [UIImage imageWithCGImage:background.CGImage scale:1 orientation:UIImageOrientationDown];
                break;
                
            case UIInterfaceOrientationLandscapeLeft:
                background = [UIImage imageWithCGImage:background.CGImage scale:1 orientation:UIImageOrientationLeft];
                break;
                
            case UIInterfaceOrientationLandscapeRight:
                background = [UIImage imageWithCGImage:background.CGImage scale:1 orientation:UIImageOrientationRight];
                break;
                
            default:
                break;
        }
        
        UIImageView *blurredBackground = [[UIImageView alloc]initWithImage:[background applyBlurWithRadius:_blurRadius tintColor:_tintColor saturationDeltaFactor:_saturationDeltaFactor maskImage:nil]];
        
        CGRect backgroundRect = [sourceController.view convertRect:sourceController.view.window.bounds fromView:Nil];
        
        if (destinationController.modalTransitionStyle == UIModalTransitionStyleCoverVertical) {
            blurredBackground.frame = CGRectMake(0, -backgroundRect.size.width, backgroundRect.size.width, backgroundRect.size.height);
        } else {
            blurredBackground.frame = CGRectMake(0, 0, backgroundRect.size.width, backgroundRect.size.height);
        }
        
        
        destinationController.view.backgroundColor = [UIColor clearColor];
        
        if ([destinationController isKindOfClass:[UITableViewController class]]) {
            [[(UITableViewController *)destinationController tableView]setBackgroundView:blurredBackground];
        } else {
            [destinationController.view addSubview:blurredBackground];
            [destinationController.view sendSubviewToBack:blurredBackground];
        }
        
        [sourceController presentViewController:destinationController animated:YES completion:nil];
        
        [destinationController.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
            
            [UIView animateWithDuration:[context transitionDuration] animations:^{
                blurredBackground.frame = CGRectMake(0, 0, backgroundRect.size.width, backgroundRect.size.height);
            }];
        } completion:nil];
    } else {
        
        UIVisualEffect *visualEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        UIVisualEffectView *blurView = [[UIVisualEffectView alloc] initWithEffect:visualEffect];
        
        blurView.translatesAutoresizingMaskIntoConstraints = NO;

        [destinationController.view insertSubview:blurView atIndex:0];
        
        [blurView.superview addConstraint:[NSLayoutConstraint constraintWithItem:blurView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:blurView.superview attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
        [blurView.superview addConstraint:[NSLayoutConstraint constraintWithItem:blurView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:blurView.superview attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
        [blurView.superview addConstraint:[NSLayoutConstraint constraintWithItem:blurView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:blurView.superview attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
        [blurView.superview addConstraint:[NSLayoutConstraint constraintWithItem:blurView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:blurView.superview attribute:NSLayoutAttributeRight multiplier:1 constant:0]];

        destinationController.view.backgroundColor = [UIColor clearColor];
        destinationController.modalPresentationStyle = UIModalPresentationOverFullScreen;

        [sourceController presentViewController:destinationController animated:YES completion:^{
            
        }];

        [destinationController.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
            
        } completion:nil];
    }
}

@end