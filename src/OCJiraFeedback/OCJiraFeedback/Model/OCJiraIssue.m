//
//  OCJiraIssue.m
//  OCJiraFeedback
//
//  Created by Víctor on 18/02/14.
//  Copyright (c) 2014 VictorBerga.com. All rights reserved.
//

#import "OCJiraIssue.h"

NSString * const kOCImprovementIssue = @"Improvement";
NSString * const kOCTaskIssue        = @"Task";
NSString * const kOCBugIssue         = @"Bug";

NSString * NSStringFromOCIssueType(OCIssueType type)
{
    switch (type) {
        case OCImprovementType:
            return kOCImprovementIssue;
            break;
        case OCTaskType:
            return kOCTaskIssue;
            break;
        case OCBugType:
            return kOCBugIssue;
            break;
        default:
            return nil;
            break;
    }
}

OCIssueType OCIssueTypeFromNSString(NSString *typeName)
{
    if ([typeName isEqualToString:kOCImprovementIssue])
        return OCImprovementType;
    else if ([typeName isEqualToString:kOCTaskIssue])
        return OCTaskType;
    else if ([typeName isEqualToString:kOCBugIssue])
        return OCBugType;
    else
        return OCUnknownType;
}

@implementation OCJiraIssue


@end
