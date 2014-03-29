//
//  OCJiraIssue.m
//  OCJiraFeedback
//
//  Created by Víctor on 18/02/14.
//  Copyright (c) 2014 VictorBerga.com. All rights reserved.
//

#import "OCJiraIssue.h"
#import "OCConnectionManager.h"

@implementation OCJiraIssue

#pragma mark -
#pragma mark Properties

- (NSString *)type
{
    return OCConnectionManager.sharedManager.issueType;
}

- (NSDictionary *)entityMap
{
    return @{
        @"id"   : @"issueId",
        @"key"  : @"issueKey",
        @"self" : @"selfURL",
    };
}

#pragma mark -
#pragma mark Instance methods

- (void)setValuesForKeysWithDictionary:(NSDictionary *)keyedValues
{
    NSMutableDictionary *keyedM = keyedValues.mutableCopy;

    for (NSString *remoteKey in self.entityMap) {
        NSString *localKey = self.entityMap[remoteKey];
        
        keyedM[localKey] = keyedValues[remoteKey];
        [keyedM removeObjectForKey:remoteKey];
    }
    
    [super setValuesForKeysWithDictionary:keyedM];
}

- (void)setValue:(id)value forKey:(NSString *)key
{
    if ([key isEqualToString:@"selfURL"])
        value = [NSURL URLWithString:value];
    
    [super setValue:value forKey:key];
}

- (void)save:(void (^)(NSError *))handler
{
    [OCConnectionManager.sharedManager
     save:self
     completion:^(NSError *error) {
         if (!error && self.attachment) {
             NSData *data = UIImagePNGRepresentation(self.attachment);
             [OCConnectionManager.sharedManager attach:data issue:self completion:^(NSError *error) {
                 handler(error);
             }];
         } else {
             handler(error);
         }
     }];
}

@end
