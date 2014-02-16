//
//  OCAtlassianInstance.h
//  OCJiraFeedback
//
//  Created by Víctor on 16/02/14.
//  Copyright (c) 2014 VictorBerga.com. All rights reserved.
//

#import <Foundation/Foundation.h>

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

@end
