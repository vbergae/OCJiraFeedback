//
//  OCAtlassianInstance.h
//  OCJiraFeedback
//
//  Created by Víctor on 16/02/14.
//  Copyright (c) 2014 VictorBerga.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@class OCInstanceConnector;

/**
 Jira's issue types
 */
typedef NS_ENUM(NSUInteger, OCIssueType) {
    OCUnknownType,
    OCBugType,
    OCImprovementType,
    OCTaskType
};

/**
 OCAtlassianInstance
 
 Use this class to configure the connection to your Atlassians Jira's instance.
 */
@interface OCAtlassianInstance : NSObject

/**
 @name Configure the instance
 */

/**
 Host name where your instance lives (example: myinstance.atlassian.net)
 */
@property NSString *host;
/**
 Username to connect and create the feedback's issue
 */
@property NSString *username;
/**
 Password to authenticate
 */
@property NSString *password;
/**
 Your Jira's project key
 */
@property NSString *projectKey;
/**
 Issue type used on creating it
 */
@property OCIssueType issueType;
/**
 Default HTTP connector
 */
@property (readonly) OCInstanceConnector *connector;

/**
 @name Issues
 */

/**
 Creates a new issue on the server
 
 @param summary
 @param description
 @param handler
 */
- (void)createIssueWithSummary:(NSString *)summary
                   description:(NSString *)description
                    completion:(void(^)(NSError *))handler;

/**
 @name Loading instance
 */

/**
 Creates and loads a new instance 
 
 Data for the connection will be load from the file Instance.plist which 
 *must* be located in your main bundle.
 */
+ (instancetype)create;

@end
