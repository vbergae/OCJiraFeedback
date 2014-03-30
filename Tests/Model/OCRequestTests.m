//
//  OCRequestTests.m
//  OCJiraFeedback
//
//  Created by Víctor on 29/03/14.
//  Copyright (c) 2014 VictorBerga.com. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

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

#pragma mark -
#pragma mark Instance methods

#pragma mark performRequestWithHandler:

- (void)test_performRequestWith_NIL_handler
{
    XCTAssertThrows([self.request performRequestWithHandler:nil],
                    @"should raise exception");
}

- (void)test_performRequestWithHandler
{
    id manager = [OCMockObject partialMockForObject:OCRequest.manager];
    id request = [OCMockObject partialMockForObject:self.request];
    
    [[manager expect] POST:OCMOCK_ANY
                parameters:OCMOCK_ANY
                   success:OCMOCK_ANY
                   failure:OCMOCK_ANY];
    [[[request stub] andReturn:manager] manager];
    
    [request performRequestWithHandler:^(id responseObject,
                                         NSError *error) {}];
    
    XCTAssertNoThrow([manager verify],
                     @"should perform POST request");
}

#pragma mark addMultiPartData:withName:type:

- (void)test_addMultiPartData_withName_type
{
    XCTAssertNoThrow(
        [self.request addMultiPartData:NSData.new withName:@"" type:@""],
        @"should simply work... :-/"
    );
}

#pragma mark -
#pragma mark Class methods

- (void)test_requestWithPath_parameters_requestMethod
{
    OCRequest *result = [OCRequest requestWithPath:@"some/path"
                                        parameters:@{@"foo" : @"bar"}
                                     requestMethod:OCRequestMethodGET];
    XCTAssertNotNil(result, @"should create the request");
}

@end
