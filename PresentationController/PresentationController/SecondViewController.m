//
//  SecondViewController.m
//  PresentationController
//
//  Created by zhangyi on 16/5/19.
//  Copyright © 2016年 zhangyi. All rights reserved.
//

#import "SecondViewController.h"
#import "CustomPresentation.h"
#import "CustomTransition.h"

@interface SecondViewController () <UIViewControllerTransitioningDelegate>

@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *percentTransition;

@end

@implementation SecondViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.modalPresentationStyle = UIModalPresentationCustom;
        self.transitioningDelegate = self;
    }
    return self;
}

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.modalPresentationStyle = UIModalPresentationCustom;
        self.transitioningDelegate  = self;
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIPanGestureRecognizer *gesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
    [self.view addGestureRecognizer:gesture];
}

- (IBAction)clickToDismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)panGesture:(UIPanGestureRecognizer *)gesture {
    CGFloat progress = [gesture translationInView:gesture.view].y / CGRectGetHeight(gesture.view.bounds);
//    progress = MIN(1, MAX(0, progress));
//    progress = [gesture locationInView:self.view].y / 1800;
    
    NSLog(@"%.2lf",progress);
    
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
            self.percentTransition = [UIPercentDrivenInteractiveTransition new];
            [self dismissViewControllerAnimated:YES completion:nil];
            break;
        case UIGestureRecognizerStateChanged:
            [self.percentTransition updateInteractiveTransition:progress];
            break;
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
//            if (progress > 0.3) {
//                [self.percentTransition finishInteractiveTransition];
//            } else {
//                [self.percentTransition cancelInteractiveTransition];
//            }
            [self.percentTransition finishInteractiveTransition];
            self.percentTransition = nil;
            break;
        default:
            break;
    }
}

#pragma mark - UIViewControllerTransitioning Delegate
- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source {
    return [[CustomPresentation alloc] initWithPresentedViewController:presented presentingViewController:presenting];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return [[CustomTransition alloc] initWithPresenting:YES];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    if (dismissed) {
        return [[CustomTransition alloc] initWithPresenting:NO];
    }
    return nil;
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator {
    if (animator) {
        return self.percentTransition;
    }
    return nil;
}

@end
