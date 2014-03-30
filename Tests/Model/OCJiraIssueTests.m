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

- (void)test_issueId
{
    self.issue.issueId = @"issueId";
    XCTAssertNotNil(self.issue.issueId, @"should return an issueId");
}

- (void)test_issueKey
{
    self.issue.issueKey = @"issueKey";
    XCTAssertNotNil(self.issue.issueKey, @"should return a issueKey");
}

- (void)test_selfURL
{
    self.issue.selfURL = [NSURL URLWithString:@"http://url.com"];
    XCTAssertNotNil(self.issue.selfURL, @"should return a URL");
}

- (void)test_summary
{
    self.issue.summary = @"summary";
    XCTAssertNotNil(self.issue.summary, @"should return a summary");
}

- (void)test_description
{
    self.issue.description = @"description";
    XCTAssertNotNil(self.issue.description, @"should return a description");
}

- (void)test_attachment
{
    self.issue.attachment = UIImage.new;
    XCTAssertNotNil(self.issue.attachment, @"should return an attachmetn");
}

- (void)test_type
{
    XCTAssertNotNil(self.issue.type, @"should return a typeName");
}

- (void)test_entityMap
{
    // See Jira documentation
    NSDictionary *expected = @{
        @"id": @"issueId",
        @"key" : @"issueKey",
        @"self" : @"selfURL"
    };
    
    XCTAssertEqualObjects(self.issue.entityMap, expected,
                          @"should return expected map information");
}

- (void)test_parameters
{
    self.issue.summary      = @"The summary";
    self.issue.description  = @"The description";
    self.issue.attachment   = UIImage.new;
    
    NSDictionary *expected = @{
        @"fields": @{
            @"project": @{@"key" : @"TEST"},
            @"summary": @"The summary",
            @"description": @"The description",
            @"issuetype": @{ @"name" : @"Improvement"}
        }
    };
    
    XCTAssertEqualObjects(self.issue.parameters, expected,
                          @"should return expected parameters");
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
        @"summary"      : @"summary_field",
        @"description"  : @"description_field",
    };
    
    [self.issue setValuesForKeysWithDictionary:keyedValues];
    
    XCTAssertEqualObjects(self.issue.issueId, @"issueId_field",
                          @"should map id to issueId");
    XCTAssertEqualObjects(self.issue.issueKey, @"issueKey_field",
                          @"should map key to issueKey");
    XCTAssertEqualObjects(self.issue.selfURL,
                          [NSURL URLWithString:@"http://www.selfURL.com"],
                          @"should map self to selfURL");
    XCTAssertEqualObjects(self.issue.summary, @"summary_field",
                          @"should map summary");
    XCTAssertEqualObjects(self.issue.description, @"description_field",
                          @"should map description");
}

#pragma mark save:
#warning Write tests

@end
