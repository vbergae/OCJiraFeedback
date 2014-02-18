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
    
    self.instance = OCAtlassianInstance.create;
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
    XCTAssertNotNil(self.instance.host, @"should set example host");
}

- (void)test_username
{
    XCTAssertNotNil(self.instance.username, @"shoudl set example user");
}

- (void)test_password
{
    XCTAssertNotNil(self.instance.password, @"should set example password");
}

- (void)test_projectkey
{
    XCTAssertNotNil(self.instance.projectKey, @"should set projectKey");
}

- (void)test_connector
{
    XCTAssertNotNil(self.instance.connector, @"should create a connector");
}

- (void)test_connector_with_username
{
    id username = [OCMockObject mockForClass:NSString.class];
    id password = [OCMockObject mockForClass:NSString.class];
    
    id instance = [OCMockObject partialMockForObject:self.instance];
    [[[instance expect] andReturn:username] username];
    [[[instance expect] andReturn:password] password];
    
    XCTAssertNoThrow(self.instance.connector, @"should not raise exception");
    
    [instance verify];
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

- (void)test_create_improvement_issue_makes_the_request
{
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
    
    OCIssueType type = OCImprovementType;
    id instance = [OCMockObject partialMockForObject:self.instance];
    [[[instance stub] andReturn:connector] connector];
    [[[instance stub] andReturnValue:OCMOCK_VALUE(type)] issueType];
    
    [instance createIssueWithSummary:@"summary"
                         description:@"description"
                          completion:^(NSError *e) {}];
    
    XCTAssertNoThrow([connector verify],
                     @"should call POST:parameters:success:failure");
}

- (void)test_create_bug_issue_makes_the_request
{
    NSString *expectedPath = @"rest/api/2/issue";
    NSDictionary *expectedParams = @{
        @"fields": @{
            @"project": @{ @"key" : @"TEST" },
            @"summary": @"summary",
            @"description": @"description",
            @"issuetype": @{ @"name" : @"Bug"}
        }
    };
    
    id connector = [OCMockObject mockForClass:OCInstanceConnector.class];
    [[connector expect]
     POST:expectedPath
     parameters:expectedParams
     success:OCMOCK_ANY
     failure:OCMOCK_ANY];
    
    OCIssueType type = OCBugType;
    id instance = [OCMockObject partialMockForObject:self.instance];
    [[[instance stub] andReturn:connector] connector];
    [[[instance stub] andReturnValue:OCMOCK_VALUE(type)] issueType];
    
    [instance createIssueWithSummary:@"summary"
                         description:@"description"
                          completion:^(NSError *e) {}];
    
    XCTAssertNoThrow([connector verify],
                     @"should call POST:parameters:success:failure");
}

- (void)test_create_task_issue_makes_the_request
{
    NSString *expectedPath = @"rest/api/2/issue";
    NSDictionary *expectedParams = @{
        @"fields": @{
            @"project": @{ @"key" : @"TEST" },
            @"summary": @"summary",
            @"description": @"description",
            @"issuetype": @{ @"name" : @"Task"}
        }
    };
    
    id connector = [OCMockObject mockForClass:OCInstanceConnector.class];
    [[connector expect]
     POST:expectedPath
     parameters:expectedParams
     success:OCMOCK_ANY
     failure:OCMOCK_ANY];
    
    OCIssueType type = OCTaskType;
    id instance = [OCMockObject partialMockForObject:self.instance];
    [[[instance stub] andReturn:connector] connector];
    [[[instance stub] andReturnValue:OCMOCK_VALUE(type)] issueType];
    
    [instance createIssueWithSummary:@"summary"
                         description:@"description"
                          completion:^(NSError *e) {}];
    
    XCTAssertNoThrow([connector verify],
                     @"should call POST:parameters:success:failure");
}

@end
