//
//  OCAtlassianInstance.m
//  OCJiraFeedback
//
//  Created by Víctor on 16/02/14.
//  Copyright (c) 2014 VictorBerga.com. All rights reserved.
//

#import "OCAtlassianInstance.h"

#import "OCJiraIssue.h"
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
        return OCBugType;
    else
        return OCUnknownType;
}

@interface OCAtlassianInstance() {
@private
    OCInstanceConnector *_connector;
}

@property (readwrite) NSString *host;
@property (readwrite) NSString *username;
@property (readwrite) NSString *password;
@property (readwrite) NSString *projectKey;
@property (readwrite) OCIssueType issueType;

- (NSDictionary *)parametersWith:(OCJiraIssue *)issue;

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

- (void)save:(OCJiraIssue *)issue completion:(void (^)(NSError *))handler
{
    NSParameterAssert(issue);
    NSParameterAssert(handler);
    
    NSDictionary *parameters = [self parametersWith:issue];
    
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

- (void)createIssueWithSummary:(NSString *)summary
                   description:(NSString *)description
                    completion:(void (^)(NSError *))handler
{
    NSParameterAssert(summary);
    NSParameterAssert(description);
    NSParameterAssert(handler);
    
    OCJiraIssue *issue  = OCJiraIssue.new;
    issue.summary       = summary;
    issue.description   = description;
    
    [self save:issue completion:handler];
}

#pragma mark -
#pragma mark Class methods

+ (instancetype)create
{
    NSString *path = nil;
    for (NSBundle *bundle in NSBundle.allBundles) {
        path = [bundle pathForResource:@"Instance" ofType:@"plist"];
        if (path) break;
    }
    NSAssert(path, @"Instance.plist file not found, please check your configuration");
    
    NSDictionary *plist = [NSDictionary dictionaryWithContentsOfFile:path];
    OCAtlassianInstance *instance = OCAtlassianInstance.new;
    [instance setValuesForKeysWithDictionary:plist];
    
    return instance;
}

#pragma mark -
#pragma mark Private methods

- (NSDictionary *)parametersWith:(OCJiraIssue *)issue
{
    NSParameterAssert(issue);
    
    return @{
        @"fields": @{
            @"project": @{ @"key" : self.projectKey },
            @"summary": issue.summary,
            @"description": issue.description,
            @"issuetype": @{ @"name" : NSStringFromOCIssueType(self.issueType)}
        }
    };
}

@end
