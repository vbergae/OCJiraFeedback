//
//  OCInstanceConnector.m
//  OCJiraFeedback
//
//  Created by Víctor on 16/02/14.
//  Copyright (c) 2014 VictorBerga.com. All rights reserved.
//

#import "OCConnectionManager.h"

#import "OCJiraIssue.h"

static NSString * const kOCCreateIssuePath  = @"rest/api/2/issue";
static NSString * const kOCAttachPath       = @"rest/api/2/issue/%@/attachments";
static NSString * const kOCHostKey          = @"host";

static NSDictionary * ReadInstanceData()
{
    NSString *path = nil;
    for (NSBundle *bundle in NSBundle.allBundles) {
        path = [bundle pathForResource:@"Instance" ofType:@"plist"];
        if (path) break;
    }
    assert(path);
    
    return [NSDictionary dictionaryWithContentsOfFile:path];
}

@interface OCConnectionManager()

@property NSString *host;
@property NSString *username;
@property NSString *password;
@property NSString *projectKey;
@property (readwrite) NSString *defaultIssueName;

- (NSDictionary *)parametersWith:(OCJiraIssue *)issue;

@end

@implementation OCConnectionManager

#pragma mark -
#pragma mark Initialization

- (id)initWithOptions:(NSDictionary *)options
{
    NSParameterAssert(options);
    NSString *URLString = [NSString stringWithFormat:@"https://%@",
                           options[kOCHostKey]];
    NSURL *URL = [NSURL URLWithString:URLString];
    
    self = [super initWithBaseURL:URL];
    if (self) {
        self.requestSerializer = [AFJSONRequestSerializer serializer];
        [self.requestSerializer setAuthorizationHeaderFieldWithUsername:options[@"username"]
                                                               password:options[@"password"]];
        
        [self setValuesForKeysWithDictionary:options];
    }
    
    return self;
}

#pragma mark -
#pragma mark Instance methods

- (void)save:(OCJiraIssue *)issue completion:(void (^)(NSError *))handler
{
    NSParameterAssert(issue);
    NSParameterAssert(handler);

    NSDictionary *parameters = [self parametersWith:issue];
    
    [self POST:kOCCreateIssuePath
    parameters:parameters
       success:^(AFHTTPRequestOperation *operation,
                           id responseObject)
     {
         NSMutableDictionary *keyedValues = [(NSDictionary *)responseObject
                                             mutableCopy];
         
         keyedValues[@"issueId"]    = responseObject[@"id"];
         keyedValues[@"issueKey"]   = responseObject[@"key"];
         keyedValues[@"selfURL"]    = responseObject[@"self"];
         
         [keyedValues removeObjectForKey:@"id"];
         [keyedValues removeObjectForKey:@"key"];
         [keyedValues removeObjectForKey:@"self"];
         
         [issue setValuesForKeysWithDictionary:keyedValues];
         handler(nil);
     }
       failure:^(AFHTTPRequestOperation *operation,
                           NSError *error)
     {
         handler(error);
     }];
}

- (void)attach:(NSData *)data
         issue:(OCJiraIssue *)issue
    completion:(void (^)(NSError *))handler
{
    NSParameterAssert(data);
    NSParameterAssert(issue);
    NSParameterAssert(handler);
    
    // Takes the reference to remove custom headers later
    __block AFHTTPRequestSerializer *serializer = self.requestSerializer;
    [serializer setValue:@"nocheck"
      forHTTPHeaderField:@"X-Atlassian-Token"];
    //
    
    NSString *path = [NSString stringWithFormat:kOCAttachPath, issue.issueKey];
    
    [self POST:path
    parameters:nil
    constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:data
                                    name:@"file"
                                fileName:@"attachment.png"
                                mimeType:@"image/png"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [serializer setValue:@"" forHTTPHeaderField:@"X-Atlassian-Token"];
        handler(nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [serializer setValue:@"" forHTTPHeaderField:@"X-Atlassian-Token"];
        handler(error);
    }];
}

#pragma mark -
#pragma mark Class methods

+ (instancetype)sharedManager
{
    static dispatch_once_t onceToken;
    static OCConnectionManager *manager;
    dispatch_once(&onceToken, ^{
        NSDictionary *keyedValues = ReadInstanceData();
        manager = [[OCConnectionManager alloc] initWithOptions:keyedValues];
    });
    
    return manager;
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
            @"issuetype": @{ @"name" : issue.type}
        }
    };
}

@end
