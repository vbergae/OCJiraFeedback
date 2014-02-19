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

@interface OCConnectionManager : AFHTTPRequestOperationManager

@property (readonly) NSString *issueType;

- (void)save:(OCJiraIssue *)issue completion:(void(^)(NSError *))handler;

+ (instancetype)sharedManager;

@end
