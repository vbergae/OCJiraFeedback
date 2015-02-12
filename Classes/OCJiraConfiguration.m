//
//  OCJiraConfiguration.m
//  OCJiraFeedback
//
//  Created by alexruperez on 12/2/15.
//  Copyright (c) 2015 VictorBerga.com. All rights reserved.
//

#import "OCJiraConfiguration.h"

@implementation OCJiraConfiguration

- (NSString *)host
{
    return self.configuration[@"host"];
}

- (NSString *)username
{
    return self.configuration[@"username"];
}

- (NSString *)password
{
    return self.configuration[@"password"];
}

- (NSString *)projectKey
{
    return self.configuration[@"projectKey"];
}

- (NSString *)issueType
{
    return self.configuration[@"issueType"];
}

+ (instancetype)sharedConfiguration
{
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = self.new;
        [sharedInstance loadFromPropertyList:@"Instance"];
    });
    
    return sharedInstance;
}

- (BOOL)loadFromPropertyList:(NSString *)name
{
    if (name)
    {
        for (NSBundle *bundle in NSBundle.allBundles)
        {
            NSString *path = [bundle pathForResource:name ofType:@"plist"];
            
            if (path)
            {
                NSDictionary *configuration = [NSDictionary dictionaryWithContentsOfFile:path];
                if (configuration)
                {
                    self.configuration = configuration;
                    return YES;
                }
            }
        }
    }
    
    return NO;
}

@end
