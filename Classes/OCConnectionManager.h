//
//  OCInstanceConnector.h
//  OCJiraFeedback
//
//  Created by Víctor on 16/02/14.
//  Copyright (c) 2014 VictorBerga.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFNetworking/AFNetworking.h>

@class OCJiraIssue;

/**
 OCConnectionManager
 
 Singleton class used as bridge between your Jira instance and the app. Has
 as main reponsability configure connection settings (loading from the
 Instance.plist file) and perform HTTP requests.
 */
@interface OCConnectionManager : AFHTTPRequestOperationManager

/**
 @name Properties
 */

/**
 Default issue type from Instance.plist settings. Configure it based
 on your Jira configuration.
 
 Issue will be create in the ser using this type
 */
@property (readonly) NSString *issueType;

/**
 @name Instance methods
 */

/**
 Saves the given issue on your server
 
 @param issue New issue to be created
 @param handler Completion handler
 */
- (void)save:(OCJiraIssue *)issue completion:(void(^)(NSError *))handler;

/**
 @name Class methods
 */

/**
 Returns an instancen configured from the attributes on Instance.plist file
 */
+ (instancetype)sharedManager;

@end
