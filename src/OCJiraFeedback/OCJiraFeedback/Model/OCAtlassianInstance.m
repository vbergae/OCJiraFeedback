//
//  OCAtlassianInstance.m
//  OCJiraFeedback
//
//  Created by Víctor on 16/02/14.
//  Copyright (c) 2014 VictorBerga.com. All rights reserved.
//

#import "OCAtlassianInstance.h"
#import "OCInstanceConnector.h"

@interface OCAtlassianInstance() {
@private
    OCInstanceConnector *_connector;
}

@end

@implementation OCAtlassianInstance

#pragma mark -
#pragma mark Properties

- (OCInstanceConnector *)connector
{
    if (!_connector) {
        NSAssert(self.host, @"Connector requires a host");
        NSString *baseURLString = [NSString stringWithFormat:@"https://%@",
                                   self.host];
        NSURL *baseURL = [NSURL URLWithString:baseURLString];
        
        _connector = [[OCInstanceConnector alloc] initWithBaseURL:baseURL];
    }
    
    return _connector;
}

#pragma mark -
#pragma mark Instance methods

- (void)createIssueWithSummary:(NSString *)summary
                   description:(NSString *)description
                    completion:(void (^)(NSError *))handler
{
    
}

@end
