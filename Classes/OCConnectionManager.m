//
//  OCInstanceConnector.m
//  OCJiraFeedback
//
//  Created by Víctor on 16/02/14.
//  Copyright (c) 2014 VictorBerga.com. All rights reserved.
//

#import "OCConnectionManager.h"

static NSString * const kOCHostKey = @"host";

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
    if (self) {
        self.requestSerializer = [AFJSONRequestSerializer serializer];
        [self.requestSerializer setAuthorizationHeaderFieldWithUsername:options[@"username"]
                                                               password:options[@"password"]];
        
        [self setValuesForKeysWithDictionary:options];
    }
    
    return self;
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

@end
