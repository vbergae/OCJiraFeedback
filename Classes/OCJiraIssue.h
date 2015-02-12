//
//  OCJiraIssue.h
//  OCJiraFeedback
//
//  Created by Víctor on 18/02/14.
//  Copyright (c) 2014 VictorBerga.com. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 OCJiraIssue
 
 Class used to represent an issue on Jira
 */
@interface OCJiraIssue : NSObject

- (instancetype)initWithSummary:(NSString *)summary description:(NSString *)description NS_DESIGNATED_INITIALIZER;

/**
 Project key returned when is created
 */
@property (readonly) NSString *projectKey;

/**
 Issue id returned when is created
 */
@property NSString *issueId;

/**
 Issue key returned when is created
 */
@property NSString *issueKey;

/**
 Issue's remote URL
 */
@property NSURL *selfURL;

/**
 Brief description
 */
@property NSString *issueSummary;
/**
 Detailed description
 */
@property NSString *issueDescription;
/**
 Image attached to this issue
 */
@property UIImage *attachment;

/**
 String used as issue type (Improvement, Task, Bug, etc..) when it's creted
 on Jira instance.
 
 The default type is set on your Instance.plist file
 */
@property (readonly) NSString *issueType;

/**
 Returns a NSDictionary instance with information aboute remote fields
 and his map to local instance.
 
 It is used on setValuesForKeysWithDictionary: to match remote properties
 with local.
 */
@property (readonly) NSDictionary *entityMap;

/**
 Returns a NSDictionary containing request's parameters
 */
@property (readonly) NSDictionary *parameters;

/**
 @name Saving the issue
 */

/**
 Saves the recevier on the remote host as new issue.
 
 @param handler Completion handler
 */
- (void)save:(void(^)(NSError *error))handler;

@end
