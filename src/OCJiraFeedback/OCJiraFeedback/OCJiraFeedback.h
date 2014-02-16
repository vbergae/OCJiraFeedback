//
//  OCJiraFeedback.h
//  OCJiraFeedback
//
//  Created by Víctor on 14/02/14.
//  Copyright (c) 2014 VictorBerga.com. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 OCJiraFeedback
 
 Sends feedback from the user to your jira instance
 */
@interface OCJiraFeedback : NSObject

/**
 Creates a new issue on your instance
 
 @param summary Issue summary
 @param description Long description for the issue
 @param Completion hanlder
 */
+ (void)feedbackWithSummary:(NSString *)summary
                description:(NSString *)description
                 completion:(void(^)(NSError *error))handler;

@end
