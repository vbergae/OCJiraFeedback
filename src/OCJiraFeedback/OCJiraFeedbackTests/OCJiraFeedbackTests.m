//
//  OCJiraFeedbackTests.m
//  OCJiraFeedbackTests
//
//  Created by Víctor on 14/02/14.
//  Copyright (c) 2014 VictorBerga.com. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

@interface OCJiraFeedbackTests : XCTestCase

@end

@implementation OCJiraFeedbackTests

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testOCMockIntgration
{
    id mock = [OCMockObject mockForClass:NSString.class];
    XCTAssertNotNil(mock, @"should create a mock object");
}

@end
