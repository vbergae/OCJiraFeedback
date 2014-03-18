//
//  OCJiraFeedback.m
//  OCJiraFeedback
//
//  Created by Víctor on 14/02/14.
//  Copyright (c) 2014 VictorBerga.com. All rights reserved.
//

#import "OCJiraFeedback.h"

#import "OCJiraIssue.h"

@implementation OCJiraFeedback

+ (void)feedbackWithSummary:(NSString *)summary
                description:(NSString *)description
                 completion:(void (^)(NSError *))handler
{
    OCJiraIssue *issue  = OCJiraIssue.new;
    issue.summary       = summary;
    issue.description   = description;
    
    [issue save:handler];
}

+ (void)feedbackWithSummary:(NSString *)summary
                description:(NSString *)description
                       view:(UIView *)view
                 completion:(void (^)(NSError *))handler
{
    
}

@end
