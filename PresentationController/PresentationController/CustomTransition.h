//
//  CustomTransition.h
//  PresentationController
//
//  Created by zhangyi on 16/5/19.
//  Copyright © 2016年 zhangyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTransition : NSObject <UIViewControllerAnimatedTransitioning>

- (instancetype)initWithPresenting:(BOOL)isPresenting;

@end
