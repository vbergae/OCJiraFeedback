//
//  OCJiraIssue.h
//  OCJiraFeedback
//
//  Created by Víctor on 18/02/14.
//  Copyright (c) 2014 VictorBerga.com. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Jira's issue types
 */
typedef NS_ENUM(NSUInteger, OCIssueType) {
    OCUnknownType,
    OCBugType,
    OCImprovementType,
    OCTaskType
};

NSString * NSStringFromOCIssueType(OCIssueType type) __deprecated;

OCIssueType OCIssueTypeFromNSString(NSString *typeName __deprecated);

/**
 OCJiraIsuue
 
 Class used to represent an issue on Jira
 */
@interface OCJiraIssue : NSObject

/**
 Brief description
 */
@property NSString *summary;
/**
 Detailed description
 */
@property NSString *description;

@property NSString *type;

@end
