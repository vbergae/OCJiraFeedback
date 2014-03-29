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
#pragma mark Class methods

#pragma mark sharedManager

- (void)test_sharedManager
{
    XCTAssertNotNil(OCConnectionManager.sharedManager,
                    @"should return an instance");
}

@end
