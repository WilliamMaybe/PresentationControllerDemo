//
//  CustomPresentation.m
//  PresentationController
//
//  Created by zhangyi on 16/5/19.
//  Copyright © 2016年 zhangyi. All rights reserved.
//

#import "CustomPresentation.h"

@interface CustomPresentation ()

@property (nonatomic, strong) UIView *backgroundView;

@end

@implementation CustomPresentation

- (void)presentationTransitionWillBegin {
    [self.containerView addSubview:self.presentingViewController.view];
    [self.containerView addSubview:self.backgroundView];
    [self.containerView addSubview:self.presentedViewController.view];
    
    self.backgroundView.alpha = 0;
    [self.presentingViewController.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        self.backgroundView.alpha = 0.7;
        self.presentingViewController.view.transform = CGAffineTransformScale(self.presentingViewController.view.transform, 0.92, 0.92);
    } completion:nil];
}

- (void)presentationTransitionDidEnd:(BOOL)completed {
    if (!completed) {
        [self.backgroundView removeFromSuperview];
    }
}

- (void)dismissalTransitionWillBegin {
    [self.presentingViewController.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        self.backgroundView.alpha = 0;
        self.presentingViewController.view.transform = CGAffineTransformIdentity;
    } completion:nil];
}

- (void)dismissalTransitionDidEnd:(BOOL)completed {
    if (completed) {
        [self.backgroundView removeFromSuperview];
    }
    
    [[UIApplication sharedApplication].keyWindow addSubview:self.presentingViewController.view];
}

- (CGRect)frameOfPresentedViewInContainerView {
    CGRect frame1 = self.containerView.bounds;
    
    CGFloat heightOffset = 100;
    frame1.origin.y += heightOffset;
    frame1.size.height -= heightOffset;
    
    return frame1;
}

- (UIView *)presentedView {
    UIView *presentedView = self.presentedViewController.view;
    presentedView.layer.cornerRadius = 8;
    return presentedView;
}

#pragma mark - Initializer
- (UIView *)backgroundView {
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        
        UIVisualEffectView *blurView = [[UIVisualEffectView alloc] initWithFrame:self.containerView.bounds];
        [blurView setEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
        [_backgroundView addSubview:blurView];
    }
    return _backgroundView;
}

@end
