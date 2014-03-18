//
//  OCJiraIssue.m
//  OCJiraFeedback
//
//  Created by Víctor on 18/02/14.
//  Copyright (c) 2014 VictorBerga.com. All rights reserved.
//

#import "OCJiraIssue.h"
#import "OCConnectionManager.h"

@implementation OCJiraIssue

#pragma mark -
#pragma mark Properties

- (NSString *)type
{
    return OCConnectionManager.sharedManager.issueType;
}

#pragma mark -
#pragma mark Instance methods

- (void)save:(void (^)(NSError *))handler
{
    [OCConnectionManager.sharedManager save:self completion:handler];
}

@end
