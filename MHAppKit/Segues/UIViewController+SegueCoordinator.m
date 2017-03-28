//
//  UIViewController+SegueCoordinator.m
//  MHAppKit
//
//  Created by Milen Halachev on 3/28/17.
//  Copyright © 2017 Milen Halachev. All rights reserved.
//

#import "UIViewController+SegueCoordinator.h"
#import <objc/runtime.h>
#import <MHAppKit/MHAppKit-Swift.h>

@implementation UIViewController (SegueCoordinator)

+(void)load {
    
    Method m1 = class_getInstanceMethod([self class], @selector(prepareForSegue:sender:));
    Method m2 = class_getInstanceMethod([self class], @selector(sph_prepareForSegue:sender:));
    
    method_exchangeImplementations(m1, m2);
}

-(void)sph_prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    [self prepareUsingCoordinatorFor:segue sender:sender];
    [self sph_prepareForSegue:segue sender:sender];
}

@end
