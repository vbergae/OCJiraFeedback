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
    OCJiraIssue *issue  = OCJiraIssue.new;
    issue.summary       = summary;
    issue.description   = description;
    
    if (view)
        issue.attachment    = [UIImage imageWithView:view];
    
    [issue save:handler];
}

@end
