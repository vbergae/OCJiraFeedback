//
//  OCConnectionManagerTests.m
//  OCJiraFeedback
//
//  Created by Víctor on 19/02/14.
//  Copyright (c) 2014 VictorBerga.com. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

#import "OCConnectionManager.h"
#import "OCJiraIssue.h"

@interface OCConnectionManagerTests : XCTestCase

@end

@implementation OCConnectionManagerTests

#pragma mark -
#pragma mark Class methods

#pragma mark -
#pragma mark Properties

- (void)test_issueTypeName_returns_fixture_configuration
{
    NSString *result = OCConnectionManager.sharedManager.issueType;
    XCTAssertEqualObjects(result, @"Improvement",
                          @"should return value saved on Instance.plist file");
}

#pragma mark -
#pragma mark Properties

- (void)test_base_url
{
    XCTAssertNotNil(OCConnectionManager.sharedManager.baseURL,
                    @"should_have_base_url");
}

- (void)test_request_serializer
{
    XCTAssertTrue([OCConnectionManager.sharedManager.requestSerializer
                   isKindOfClass:AFJSONRequestSerializer.class],
                  @"should be AFJSONRequestSerializer");
}

#pragma mark -
#pragma mark Instance methods

#pragma mark save:completion:

- (void)test_save_completion_with_nil_issue
{
    XCTAssertThrows(
        [OCConnectionManager.sharedManager
         save:nil
         completion:^(NSError *e) {}],
        @"should raise parameter exception"
    );
}

- (void)test_save_completion_with_nil_handler
{
    XCTAssertThrows(
        [OCConnectionManager.sharedManager
         save:OCJiraIssue.new
         completion:nil],
        @"should raise parameter exception"
    );
}

- (void)test_save_completion
{
    id manager = [OCMockObject partialMockForObject:
                  OCConnectionManager.sharedManager];
    [[manager expect]
     POST:OCMOCK_ANY
     parameters:OCMOCK_ANY
     success:OCMOCK_ANY
     failure:OCMOCK_ANY];
    
    OCJiraIssue *issue  = OCJiraIssue.new;
    issue.summary       = @"summary";
    issue.description   = @"description";
    
    [manager save:issue completion:^(NSError *e) {}];
    XCTAssertNoThrow([manager verify],
                     @"should make POST request");
}

#pragma mark -
#pragma mark Class methods

#pragma mark sharedManager

- (void)test_sharedManager
{
    XCTAssertNotNil(OCConnectionManager.sharedManager,
                    @"should return an instance");
}

@end
