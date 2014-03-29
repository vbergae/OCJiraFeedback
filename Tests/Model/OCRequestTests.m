//
//  OCRequestTests.m
//  OCJiraFeedback
//
//  Created by Víctor on 29/03/14.
//  Copyright (c) 2014 VictorBerga.com. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "OCRequest.h"

@interface OCRequestTests : XCTestCase

@property OCRequest *request;

@end

@implementation OCRequestTests

- (void)setUp
{
    [super setUp];
    
    self.request = [[OCRequest alloc]
                    initWithPath:@"relative/path"
                    paremeters:@{@"foo" : @"bar"}
                    requestMethod:OCRequestMethodPOST];
}

- (void)tearDown
{
    self.request = nil;
    
    [super tearDown];
}

#pragma mark -
#pragma mark Properties

- (void)test_path
{
    XCTAssertEqualObjects(self.request.path, @"relative/path",
                          @"should return path used on init");
}

- (void)test_parameters
{
    XCTAssertEqualObjects(self.request.parameters, @{@"foo" : @"bar"},
                          @"should return parameters used on init");
}

- (void)test_requestMethod
{
    XCTAssertTrue(self.request.requestMethod == OCRequestMethodPOST,
                  @"should return request method used on init");
}

@end
