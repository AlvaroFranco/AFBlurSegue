//
//  AFBlurSegue.h
//  AFBlurSegue-Demo
//
//  Created by Alvaro Franco on 6/5/14.
//  Copyright (c) 2014 AlvaroFranco. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AFBlurSegue : UIStoryboardSegue

@property (nonatomic) CGFloat blurRadius;
@property (nonatomic, strong) UIColor *tintColor;
@property (nonatomic) CGFloat saturationDeltaFactor;
@property (nonatomic) UIBlurEffectStyle blurEffectStyle;

@end
