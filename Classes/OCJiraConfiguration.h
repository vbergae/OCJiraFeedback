//
//  OCJiraConfiguration.h
//  OCJiraFeedback
//
//  Created by alexruperez on 12/2/15.
//  Copyright (c) 2015 VictorBerga.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OCJiraConfiguration : NSObject

@property (readonly) NSString *host;

@property (readonly) NSString *username;

@property (readonly) NSString *password;

@property (readonly) NSString *projectKey;

@property (readonly) NSString *issueType;

@property (strong, nonatomic) NSDictionary *configuration;

+ (instancetype)sharedConfiguration;

- (BOOL)loadFromPropertyList:(NSString *)name;

@end
