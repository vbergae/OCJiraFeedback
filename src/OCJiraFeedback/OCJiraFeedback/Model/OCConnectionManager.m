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

- (id)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    if (self) {
        self.requestSerializer = [AFJSONRequestSerializer serializer];
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

+ (instancetype)sharedManager
{
    static dispatch_once_t onceToken;
    static OCConnectionManager *manager;
    dispatch_once(&onceToken, ^{
        NSDictionary *keyedValues = ReadInstanceData();
        NSString *URLString = [NSString stringWithFormat:@"https://%@",
                               keyedValues[kOCHostKey]];
        NSURL *URL = [NSURL URLWithString:URLString];
        NSAssert(URL, @"Unknown host type %@", URLString);
        
        manager = [[OCConnectionManager alloc] initWithBaseURL:URL];
        [manager setValuesForKeysWithDictionary:keyedValues];
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
