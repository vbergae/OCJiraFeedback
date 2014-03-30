//
//  OCJiraFeedback.m
//  OCJiraFeedback
//
//  Created by Víctor on 14/02/14.
//  Copyright (c) 2014 VictorBerga.com. All rights reserved.
//

#import "OCJiraFeedback.h"

#import "OCJiraIssue.h"
#import "UIImage+OCJiraFeedback.h"

@implementation OCJiraFeedback

+ (void)openFeedbackViewWithCompletion:(void (^)(void))handler
{
    NSParameterAssert(handler);
    
    UIViewController *controller = nil;
    
    UIApplication *application          = UIApplication.sharedApplication;
    id<UIApplicationDelegate> delegate  = application.delegate;
    UIWindow *window                    = delegate.window;
    id rootInstance                     = window.rootViewController;
    
    if ([rootInstance isKindOfClass:UINavigationController.class]) {
        UINavigationController *root = (UINavigationController *)rootInstance;
        [root presentViewController:controller animated:YES completion:nil];
    } else {
        NSAssert(NO, @"instance not valid");
    }
}

+ (void)feedbackWithSummary:(NSString *)summary
                description:(NSString *)description
                 completion:(void (^)(NSError *))handler
{
    [self feedbackWithSummary:summary
                  description:description
                         view:nil
                   completion:handler];
}

+ (void)feedbackWithSummary:(NSString *)summary
                description:(NSString *)description
                       view:(UIView *)view
                 completion:(void (^)(NSError *))handler
{
    NSParameterAssert(summary);
    NSParameterAssert(description);
    NSParameterAssert(handler);
    
    OCJiraIssue *issue  = OCJiraIssue.new;
    issue.summary       = summary;
    issue.description   = description;
    
    if (view)
        issue.attachment    = [UIImage imageWithView:view];
    
    [issue save:handler];
}

@end
