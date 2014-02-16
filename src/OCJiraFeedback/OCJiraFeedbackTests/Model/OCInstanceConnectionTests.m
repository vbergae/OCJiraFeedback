//
//  OCInstanceConnectionTests.m
//  OCJiraFeedback
//
//  Created by Víctor on 16/02/14.
//  Copyright (c) 2014 VictorBerga.com. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "OCInstanceConnector.h"

@interface OCInstanceConnectionTests : XCTestCase

@property OCInstanceConnector *connector;

@end

@implementation OCInstanceConnectionTests

- (void)setUp
{
    [super setUp];
    
    NSURL *testURL = [NSURL URLWithString:@"http://example.com"];
    self.connector = [[OCInstanceConnector alloc] initWithBaseURL:testURL];
}

- (void)tearDown
{
    self.connector = nil;
    
    [super tearDown];
}

#pragma mark -
#pragma mark Initialization

- (void)test_instance
{
    XCTAssertNotNil(self.connector, @"should create a new instance");
}

#pragma mark -
#pragma mark Properties

- (void)test_base_url
{
    XCTAssertNotNil(self.connector.baseURL, @"should_have_base_url");
}

- (void)test_request_serializer
{
    XCTAssertTrue([self.connector.requestSerializer isKindOfClass:
                   AFJSONRequestSerializer.class],
                  @"should be AFJSONRequestSerializer");
}

@end
