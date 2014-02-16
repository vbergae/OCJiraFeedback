//
//  OCAtlassianInstance.m
//  OCJiraFeedback
//
//  Created by Víctor on 16/02/14.
//  Copyright (c) 2014 VictorBerga.com. All rights reserved.
//

#import "OCAtlassianInstance.h"
#import "OCInstanceConnector.h"

NSString * const OCCreateIssuePath = @"rest/api/2/issue";

NSString * NSStringFromOCIssueType(OCIssueType type)
{
    switch (type) {
        case OCImproventIssueType:
            return @"Improvement";
            break;
        case OCTaskIssueType:
            return @"Task";
            break;
        case OCBugIssueType:
            return @"Bug";
            break;
        default:
            return nil;
            break;
    }
}

@interface OCAtlassianInstance() {
@private
    OCInstanceConnector *_connector;
}

- (NSDictionary *)parametersWithSummary:(NSString *)summary
                            description:(NSString *)description;

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
    NSAssert(summary, @"Issue summary not setted");
    NSAssert(description, @"Issue description not setted");
    NSAssert(handler, @"Completion handler not setted");
    
    NSDictionary *parameters = [self parametersWithSummary:summary
                                               description:description];

    [self.connector POST:OCCreateIssuePath
              parameters:parameters
                 success:^(AFHTTPRequestOperation *operation,
                          id responseObject)
    {
        handler(nil);
    }
                failure:^(AFHTTPRequestOperation *operation,
                          NSError *error)
    {
        handler(error);
    }];
}

#pragma mark -
#pragma mark Private methods

- (NSDictionary *)parametersWithSummary:(NSString *)summary 
                            description:(NSString *)description
{
    NSAssert(self.projectKey, @"Poject key not setted");
    NSAssert(self.issueType > 0, @"Issue type not setted");
    
    return @{
        @"fields": @{
            @"project": @{ @"key" : self.projectKey },
            @"summary": summary,
            @"description": description,
            @"issuetype": @{ @"name" : NSStringFromOCIssueType(self.issueType)}
        }
    };
}

@end
