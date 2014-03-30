//
//  OCJiraFeedback.h
//  OCJiraFeedback
//
//  Created by Víctor on 14/02/14.
//  Copyright (c) 2014 VictorBerga.com. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 OCJiraFeedback
 
 Sends feedback from the user to your jira instance
 */
@interface OCJiraFeedback : NSObject

/**
 @name Show feedback's view
 */

/**
  Shows feedback's view
 */
+ (void)openFeedbackViewWithCompletion:(void(^)(void))handler;

/**
 @name Send feedback directly
 */

/**
 Creates a new issue on your instance
 
 @param summary Issue summary
 @param description Long description for the issue
 @param Completion hanlder
 */
+ (void)feedbackWithSummary:(NSString *)summary
                description:(NSString *)description
                 completion:(void(^)(NSError *error))handler;

/**
 Creates a new issue on your instance attaching an screenshot of 
 view (if exists).
 
 @param summary Issue summary
 @param description Long description for the issue
 @param view View to take an screenshot
 @param Completion hanlder
 */
+ (void)feedbackWithSummary:(NSString *)summary
                description:(NSString *)description
                       view:(UIView *)view
                 completion:(void (^)(NSError *))handler;

@end
