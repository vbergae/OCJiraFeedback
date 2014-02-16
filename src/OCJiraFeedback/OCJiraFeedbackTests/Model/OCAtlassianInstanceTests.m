//
//  OCAtlassianInstanceTests.m
//  OCJiraFeedback
//
//  Created by Víctor on 16/02/14.
//  Copyright (c) 2014 VictorBerga.com. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

#import "OCAtlassianInstance.h"
#import "OCInstanceConnector.h"

@interface OCAtlassianInstanceTests : XCTestCase

@property OCAtlassianInstance *instance;

@end

@implementation OCAtlassianInstanceTests

- (void)setUp
{
    [super setUp];
    
    self.instance = OCAtlassianInstance.new;
}

- (void)tearDown
{
    self.instance = nil;
    
    [super tearDown];
}

#pragma mark -
#pragma mark Initialization

- (void)test_init
{
    XCTAssertNotNil(self.instance, @"should return a new instance");
}

#pragma mark -
#pragma mark Properties

- (void)test_host
{
    self.instance.host = @"example.atlassian.net";
    XCTAssertNotNil(self.instance.host, @"should set example host");
}

- (void)test_username
{
    self.instance.username = @"feedback_username";
    XCTAssertNotNil(self.instance.username, @"shoudl set example user");
}

- (void)test_password
{
    self.instance.password = @"feedback_password";
    XCTAssertNotNil(self.instance.password, @"should set example password");
}

- (void)test_projectkey
{
    self.instance.projectKey = @"TEST";
    XCTAssertNotNil(self.instance.projectKey, @"should set projectKey");
}

- (void)test_issueType
{
    self.instance.issueType = OCImproventIssueType;
    XCTAssertTrue(self.instance.issueType > 0, @"should set issueType");
}

- (void)test_connector_without_host
{
    self.instance.host = nil;
    XCTAssertThrows(self.instance.connector, @"should raise exception");
}

- (void)test_connector
{
    self.instance.host = @"example.atlassian.net";
    XCTAssertNotNil(self.instance.connector, @"should create a connector");
}

#pragma mark -
#pragma mark Instance methods

#pragma mark createIssueWithSummary:description:completion

- (void)test_createIssue_without_summary
{
    XCTAssertThrows(
        [self.instance createIssueWithSummary:nil
                                  description:@""
                                   completion:^(NSError *e) {}],
        @"should raise argument exception"
    );
}

- (void)test_createIssue_without_description
{
    XCTAssertThrows(
        [self.instance createIssueWithSummary:@""
                                  description:nil
                                   completion:^(NSError *e) {}],
        @"should raise argument exception"
    );
}

- (void)test_createIssue_without_handler
{
    XCTAssertThrows(
        [self.instance createIssueWithSummary:@""
                                  description:@""
                                   completion:nil],
        @"should raise argument exception"
    );
}

- (void)test_createIssue_makes_the_request
{
    self.instance.projectKey = @"TEST";
    self.instance.issueType  = OCImproventIssueType;
    
    NSString *expectedPath = @"rest/api/2/issue";
    NSDictionary *expectedParams = @{
        @"fields": @{
            @"project": @{ @"key" : @"TEST" },
            @"summary": @"summary",
            @"description": @"description",
            @"issuetype": @{ @"name" : @"Improvement"}
        }
    };
    
    id connector = [OCMockObject mockForClass:OCInstanceConnector.class];
    [[connector expect]
     POST:expectedPath
     parameters:expectedParams
     success:OCMOCK_ANY
     failure:OCMOCK_ANY];
    
    id instance = [OCMockObject partialMockForObject:self.instance];
    [[[instance stub] andReturn:connector] connector];
    
    [instance createIssueWithSummary:@"summary"
                         description:@"description"
                          completion:^(NSError *e) {}];
    
    XCTAssertNoThrow([connector verify],
                     @"should call POST:parameters:success:failure");
}

@end
