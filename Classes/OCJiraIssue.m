//
//  OCJiraIssue.m
//  OCJiraFeedback
//
//  Created by Víctor on 18/02/14.
//  Copyright (c) 2014 VictorBerga.com. All rights reserved.
//

#import "OCJiraIssue.h"
#import "OCRequest.h"
#import "OCJiraConfiguration.h"

static NSString * const kOCCreateIssuePath  = @"rest/api/2/issue";
static NSString * const kOCAttachPath       = @"rest/api/2/issue/%@/attachments";

@implementation OCJiraIssue

- (instancetype)initWithSummary:(NSString *)summary description:(NSString *)description
{
    self = [super init];
    
    if (self)
    {
        self.issueSummary = summary;
        self.issueDescription = description;
    }
    
    return self;
}

#pragma mark -
#pragma mark Properties

- (NSString *)projectKey
{
    return OCJiraConfiguration.sharedConfiguration.projectKey;
}

- (NSString *)issueType
{
    return OCJiraConfiguration.sharedConfiguration.issueType;
}

- (NSDictionary *)entityMap
{
    return @{
        @"id"   : @"issueId",
        @"key"  : @"issueKey",
        @"self" : @"selfURL",
    };
}

- (NSDictionary *)parameters
{
    return @{
        @"fields": @{
            @"project": @{
                @"key" : self.projectKey ? self.projectKey : @""
            },
            @"summary": self.issueSummary ? self.issueSummary : @"",
            @"description": self.issueDescription ? self.issueDescription : @"",
            @"issuetype": @{ @"name" : self.issueType ? self.issueType : @"Task" }
        }
    };
}

#pragma mark -
#pragma mark Instance methods

- (void)setValuesForKeysWithDictionary:(NSDictionary *)keyedValues
{
    NSMutableDictionary *keyedM = keyedValues.mutableCopy;

    for (NSString *remoteKey in self.entityMap)
    {
        NSString *localKey = self.entityMap[remoteKey];
        
        keyedM[localKey] = keyedValues[remoteKey];
        [keyedM removeObjectForKey:remoteKey];
    }
    
    [super setValuesForKeysWithDictionary:keyedM];
}

- (void)setValue:(id)value forKey:(NSString *)key
{
    if ([key isEqualToString:@"selfURL"])
    {
        value = [NSURL URLWithString:value];
    }
    
    [super setValue:value forKey:key];
}

- (void)save:(void (^)(NSError *))handler
{
    OCRequest *request = [[OCRequest alloc]
                          initWithPath:kOCCreateIssuePath
                          paremeters:self.parameters
                          requestMethod:OCRequestMethodPOST];
    
    [request performRequestWithHandler:^(id responseObject, NSError *error) {
        if (!error)
        {
            [self setValuesForKeysWithDictionary:responseObject];
            
            if (self.attachment)
            {
                [self attach:handler];
            }
        }
        
        handler(error);
    }];
}

- (void)attach:(void(^)(NSError *))handler
{
    NSData *attachment = UIImagePNGRepresentation(self.attachment);
    NSString *path = [NSString stringWithFormat:kOCAttachPath, self.issueKey];
    
    OCRequest *request = [[OCRequest alloc]
                          initWithPath:path paremeters:nil
                          requestMethod:OCRequestMethodPOST];
    [request addMultiPartData:attachment withName:@"file" type:@"image/png"];
    [request performRequestWithHandler:^(id responseObject, NSError *error) {
        handler(error);
    }];
}

@end
