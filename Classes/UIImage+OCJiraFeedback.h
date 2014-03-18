//
//  UIImage+OCJiraFeedback.h
//  OCJiraFeedback
//
//  Created by Víctor on 18/03/14.
//  Copyright (c) 2014 VictorBerga.com. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 UIImage+OCJiraFeedback
 
 The UIImage+OCJiraFeedback category adds class method 'imageWithView:' as
 a helper to take screenshots from a view.
 */
@interface UIImage (OCJiraFeedback)

/**
 Creates an UIImage object as view's represention
 
 @param view Original view to transform
 @return Valid image object
 @warning Throws NSInternalInconsistencyException if view is nil
 */
+ (UIImage *)imageWithView:(UIView *)view;

@end
