//
//  OCJiraFeedback.m
//  OCJiraFeedback
//
//  Created by Víctor on 14/02/14.
//  Copyright (c) 2014 VictorBerga.com. All rights reserved.
//

#import "OCJiraFeedback.h"

#import "OCJiraIssue.h"
#import "OCConnectionManager.h"

@implementation OCJiraFeedback

+ (void)feedbackWithSummary:(NSString *)summary
                description:(NSString *)description
                 completion:(void (^)(NSError *))handler
{
    NSString *typeName  = OCConnectionManager.sharedManager.issueTypeName;
    
    OCJiraIssue *issue  = OCJiraIssue.new;
    issue.summary       = summary;
    issue.description   = description;
    issue.type          = OCIssueTypeFromNSString(typeName);
    
    [OCConnectionManager.sharedManager save:issue completion:handler];
}

@end
