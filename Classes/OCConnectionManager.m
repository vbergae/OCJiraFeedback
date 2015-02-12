//
//  OCInstanceConnector.m
//  OCJiraFeedback
//
//  Created by Víctor on 16/02/14.
//  Copyright (c) 2014 VictorBerga.com. All rights reserved.
//

#import "OCConnectionManager.h"
#import "OCJiraConfiguration.h"

static NSString * const kOCHostKey = @"host";
static NSString * const kOCUsernameKey = @"username";
static NSString * const kOCPasswordKey = @"password";
static NSString * const kOCProjectKey = @"projectKey";
static NSString * const kOCIssueTypeKey = @"issueType";

static NSDictionary * ReadInstanceData()
{
    return OCJiraConfiguration.sharedConfiguration.configuration;
}

@interface OCConnectionManager()

@property NSString *host;
@property NSString *username;
@property NSString *password;
@property (readwrite) NSString *projectKey;
@property (readwrite) NSString *defaultIssueName;

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
    
    if (self)
    {
        self.requestSerializer = [AFJSONRequestSerializer serializer];
        [self.requestSerializer setAuthorizationHeaderFieldWithUsername:options[kOCUsernameKey]
                                                               password:options[kOCPasswordKey]];
        
        [self setValuesForKeysWithDictionary:options];
    }
    
    return self;
}

#pragma mark -
#pragma mark Class methods

+ (instancetype)sharedManager
{
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSDictionary *keyedValues = ReadInstanceData();
        sharedInstance = [[OCConnectionManager alloc] initWithOptions:keyedValues];
    });
    
    return sharedInstance;
}

@end
