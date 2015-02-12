//
//  OCJiraIssueTests.m
//  OCJiraFeedback
//
//  Created by Víctor on 19/02/14.
//  Copyright (c) 2014 VictorBerga.com. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "OCJiraIssue.h"

@interface OCJiraIssueTests : XCTestCase

@property OCJiraIssue *issue;

@end

@implementation OCJiraIssueTests

- (void)setUp
{
    [super setUp];
    
    self.issue = OCJiraIssue.new;
}

- (void)tearDown
{
    self.issue = nil;
    
    [super tearDown];
}

#pragma mark -
#pragma mark Properties

- (void)test_project
{
    XCTAssertNotNil(self.issue.projectKey, @"should return a project");
}

- (void)test_summary
{
    self.issue.issueSummary = @"summary";
    XCTAssertNotNil(self.issue.issueSummary, @"should return a summary");
}

- (void)test_description
{
    self.issue.issueDescription = @"description";
    XCTAssertNotNil(self.issue.issueDescription, @"should return a description");
}

- (void)test_type
{
    XCTAssertNotNil(self.issue.issueType, @"should return a type");
}

- (void)test_entityMap
{
    XCTAssertNotNil(self.issue.entityMap, @"should return mapping information");
}

#pragma mark -
#pragma mark Instance methods

#pragma mark setValuesForKeysWithDictionary:

- (void)test_setValuesForKeysWithDictionary
{
    NSDictionary *keyedValues = @{
        @"id"           : @"issueId_field",
        @"key"          : @"issueKey_field",
        @"self"         : @"http://www.selfURL.com",
        @"issueSummary"      : @"summary_field",
        @"issueDescription"  : @"description_field"
    };
    
    [self.issue setValuesForKeysWithDictionary:keyedValues];
    
    XCTAssertEqualObjects(self.issue.issueId, @"issueId_field",
                          @"should map id to issueId");
    XCTAssertEqualObjects(self.issue.issueKey, @"issueKey_field",
                          @"should map key to issueKey");
    XCTAssertEqualObjects(self.issue.selfURL,
                          [NSURL URLWithString:@"http://www.selfURL.com"],
                          @"should map self to selfURL");
    XCTAssertEqualObjects(self.issue.issueSummary, @"summary_field",
                          @"should map summary");
    XCTAssertEqualObjects(self.issue.issueDescription, @"description_field",
                          @"should map description");
}

@end
