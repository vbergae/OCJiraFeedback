//
//  UIImage+OCJiraFeedbackTests.m
//  OCJiraFeedback
//
//  Created by Víctor on 18/03/14.
//  Copyright (c) 2014 VictorBerga.com. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "UIImage+OCJiraFeedback.h"

@interface UIImage_OCJiraFeedbackTests : XCTestCase

@end

@implementation UIImage_OCJiraFeedbackTests

#pragma mark -
#pragma mark Class methods

#pragma mark -
#pragma mark imageWithView:

- (void)test_imageWithView_requires_the_view
{
    XCTAssertThrowsSpecificNamed(
        [UIImage imageWithView:nil],
        NSException,
        NSInternalInconsistencyException,
        @"should raise NSInternalInconsistencyException"
    );
}

- (void)test_imageWithView
{
    UIView *view            = UIView.new;
    view.backgroundColor    = UIColor.redColor;
    view.frame              = CGRectMake(0., 0., 128., 128.);
    
    UIImage *image = [UIImage imageWithView:view];
    XCTAssertNotNil(image, @"should return a valid image");
}

@end
