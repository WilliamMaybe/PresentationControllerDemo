//
//  CustomTransition.m
//  PresentationController
//
//  Created by zhangyi on 16/5/19.
//  Copyright © 2016年 zhangyi. All rights reserved.
//

#import "CustomTransition.h"

@interface CustomTransition ()

@property (nonatomic, readonly) BOOL isPresenting;
@property (nonatomic, strong) UIViewController *viewController;

@end

@implementation CustomTransition

- (instancetype)initWithPresenting:(BOOL)isPresenting {
    self = [super init];
    if (self) {
        _isPresenting = isPresenting;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.5f;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    if (self.isPresenting) {
        UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
        
        CGRect finalFrame = [transitionContext finalFrameForViewController:toVC];
        CGRect initialFrame = CGRectOffset(finalFrame, 0, finalFrame.size.height);
        
        toView.frame = initialFrame;
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        
            toView.frame = finalFrame;
        
        } completion:^(BOOL finished) {
            
            if (finished) {
                [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            }
        }];
    }
    
    else {
        UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        UIView *toView   = [transitionContext viewForKey:UITransitionContextToViewKey];
        
        UIView *containerView = [transitionContext containerView];
        
        [containerView addSubview:toView];
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
            fromView.frame = CGRectOffset(fromView.frame, 0, -containerView.bounds.size.height);
        } completion:^(BOOL finished) {
            if (finished) {
                [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            }
        }];
    }
}

@end
