//
//  OCAtlassianInstanceTests.m
//  OCJiraFeedback
//
//  Created by Víctor on 16/02/14.
//  Copyright (c) 2014 VictorBerga.com. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "OCAtlassianInstance.h"

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

@end
