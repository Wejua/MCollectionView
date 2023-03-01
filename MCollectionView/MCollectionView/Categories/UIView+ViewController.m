//
//  UIView+ViewController.m
//  Mall
//
//  Created by zhouweijie1 on 2021/8/13.
//

#import "UIView+ViewController.h"
#include <objc/runtime.h>

@implementation UIView (ViewController)

- (UIViewController *)viewController_mc {
    for (UIResponder *responder = self.nextResponder; responder != nil; responder = responder.nextResponder) {
        if ([responder isKindOfClass:UIViewController.class]) {
            return (UIViewController *)responder;
        }
    }
    return nil;
}

@end
