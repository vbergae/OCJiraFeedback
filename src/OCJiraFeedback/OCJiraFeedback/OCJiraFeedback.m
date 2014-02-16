//
//  OCJiraFeedback.m
//  OCJiraFeedback
//
//  Created by Víctor on 14/02/14.
//  Copyright (c) 2014 VictorBerga.com. All rights reserved.
//

#import "OCJiraFeedback.h"
#import "OCAtlassianInstance.h"

@implementation OCJiraFeedback

+ (void)feedbackWithSummary:(NSString *)summary
                description:(NSString *)description
                 completion:(void (^)(NSError *))handler
{
    OCAtlassianInstance *instance = OCAtlassianInstance.create;
    
    [instance createIssueWithSummary:summary
                         description:description
                          completion:handler];
}

@end
