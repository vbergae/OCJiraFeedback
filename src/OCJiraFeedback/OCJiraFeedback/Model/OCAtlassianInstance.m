//
//  OCAtlassianInstance.m
//  OCJiraFeedback
//
//  Created by Víctor on 16/02/14.
//  Copyright (c) 2014 VictorBerga.com. All rights reserved.
//

#import "OCAtlassianInstance.h"
#import "OCInstanceConnector.h"

NSString * const kOCCreateIssuePath  = @"rest/api/2/issue";
NSString * const kOCImprovementIssue = @"Improvement";
NSString * const kOCTaskIssue        = @"Task";
NSString * const kOCBugIssue         = @"Bug";

NSString * NSStringFromOCIssueType(OCIssueType type)
{
    switch (type) {
        case OCImprovementType:
            return kOCImprovementIssue;
            break;
        case OCTaskType:
            return kOCTaskIssue;
            break;
        case OCBugType:
            return kOCBugIssue;
            break;
        default:
            return nil;
            break;
    }
}

OCIssueType OCIssueTypeFromNSString(NSString *type)
{
    if ([type isEqualToString:kOCImprovementIssue])
        return OCImprovementType;
    else if ([type isEqualToString:kOCTaskIssue])
        return OCTaskType;
    else if ([type isEqualToString:kOCBugIssue])
        return OCTaskType;
    else
        return OCUnknownType;
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

    [self.connector POST:kOCCreateIssuePath
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
                           pathForResource:@"Instance"
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
