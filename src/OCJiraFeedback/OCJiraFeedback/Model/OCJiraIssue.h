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

NSString * NSStringFromOCIssueType(OCIssueType type);

OCIssueType OCIssueTypeFromNSString(NSString *typeName);

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

@property OCIssueType type;

@property (readonly) NSString *typeName;

@end
