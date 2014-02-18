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
 Brief description
 */
@property NSString *summary;
/**
 Detailed description
 */
@property NSString *description;

@end
