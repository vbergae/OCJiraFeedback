//
//  OCJiraIssue.h
//  OCJiraFeedback
//
//  Created by Víctor on 18/02/14.
//  Copyright (c) 2014 VictorBerga.com. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 OCJiraIsuue
 
 Class used to represent an issue on Jira
 */
@interface OCJiraIssue : NSObject

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
@property NSString *summary;
/**
 Detailed description
 */
@property NSString *description;
/**
 
 */
@property UIImage *attachment;

/**
 String used as issue type (Improvement, Task, Bug, etc..) when it's creted
 on Jira instance.
 
 The default type is set on your Instance.plist file
 */
@property (readonly) NSString *type;

/**
 @name Saving the issue
 */

/**
 Saves the recevier on the remote host as new issue.
 
 @param handler Completion handler
 */
- (void)save:(void(^)(NSError *error))handler;

@end
