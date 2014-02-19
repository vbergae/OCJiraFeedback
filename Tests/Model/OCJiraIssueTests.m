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

- (void)test_type
{
    self.issue.type = @"Improvement";
    XCTAssertNotNil(self.issue.type, @"should return a typeName");
}

@end
