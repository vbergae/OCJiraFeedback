//
//  UIImage+OCJiraFeedback.m
//  OCJiraFeedback
//
//  Created by Víctor on 18/03/14.
//  Copyright (c) 2014 VictorBerga.com. All rights reserved.
//

#import "UIImage+OCJiraFeedback.h"

static CGFloat ScreenScale()
{
    CGFloat scale = 1.;
    
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
        scale = UIScreen.mainScreen.scale;
    }
    
    return scale;
}

@implementation UIImage (OCJiraFeedback)

+ (UIImage *)imageWithView:(UIView *)view
{
    NSParameterAssert(view);
    
    // Example from:http://www.ios-dev-blog.com/how-to-create-uiimage-from-uiview/
    
    CGFloat scale = ScreenScale();
    
    if (scale > 1) {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, scale);
    } else {
        UIGraphicsBeginImageContext(view.bounds.size);
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    [view.layer renderInContext: context];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return viewImage;
}

@end
