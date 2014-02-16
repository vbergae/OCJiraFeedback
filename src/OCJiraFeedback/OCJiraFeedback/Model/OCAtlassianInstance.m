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

OCIssueType OCIssueTypeFromNSString(NSString *type)
{
    if ([type isEqualToString:@"Improvement"])
        return OCImproventIssueType;
    else if ([type isEqualToString:@"Task"])
        return OCTaskIssueType;
    else if ([type isEqualToString:@"Bug"])
        return OCBugIssueType;
    else
        return OCNoneIssueType;
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
        
        if (self.username) {
            [_connector.requestSerializer
             setAuthorizationHeaderFieldWithUsername:self.username
             password:self.password];
        }
    }
    
    return _connector;
}

#pragma mark -
#pragma mark Instance methods

- (void)setValue:(id)value forKey:(NSString *)key
{
    if ([key isEqualToString:@"issueType"]) {
        NSAssert([value isKindOfClass:NSString.class],
                 @"Issue type expected as NSString from Instance.plist");
        value = @(OCIssueTypeFromNSString(value));
    }
    
    [super setValue:value forKey:key];
}

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
#pragma mark Class methods

+ (instancetype)create
{
    NSString *path = [[NSBundle mainBundle]
                           pathForResource:@"instance"
                           ofType:@"plist"];
    NSDictionary *plist = [NSDictionary dictionaryWithContentsOfFile:path];
    NSAssert(plist, @"Instance.plist file not found, please check your configuration");
    
    OCAtlassianInstance *instance = OCAtlassianInstance.new;
    [instance setValuesForKeysWithDictionary:plist];
    
    return instance;
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
