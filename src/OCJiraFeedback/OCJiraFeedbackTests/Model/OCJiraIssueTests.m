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
#pragma mark Helper functions

#pragma mark NSStringFromOCIssueType

- (void)test_NSStringFromOCIssueType_with_unknown_type
{
    NSString *result = NSStringFromOCIssueType(NSUIntegerMax);
    XCTAssertNil(result, @"should return nil name");
}

- (void)test_NSStringFromOCIsueType_with_known_type
{
    NSArray *expecteds         = @[@"Improvement", @"Task", @"Bug"];
    OCIssueType types[]        = { OCImprovementType, OCTaskType, OCBugType };
    unsigned char typesCount   = 3;
    
    for (unsigned char i = 0; i < typesCount; ++i) {
        NSString *result = NSStringFromOCIssueType(types[i]);
        XCTAssertEqualObjects(result, expecteds[i],
                              @"should return a valid name");
    }
}

#pragma mark OCIssueTypeFromNSString

- (void)test_OCIssueTypeFromNSString_with_unknown_string
{
    OCIssueType result = OCIssueTypeFromNSString(@"dsdgsg");
    XCTAssertTrue(result == OCUnknownType,
                  @"should return unknown type");
}

- (void)test_OCIssueTypeFromNSString_with_known_string
{
    NSArray *names             = @[@"Improvement", @"Task", @"Bug"];
    OCIssueType types[]        = { OCImprovementType, OCTaskType, OCBugType };
    unsigned char typesCount   = 3;
    
    for (unsigned char i = 0; i < typesCount; ++i) {
        OCIssueType result = OCIssueTypeFromNSString(names[i]);
        XCTAssertTrue(result == types[i],
                      @"should return a valid type");
    }
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
    self.issue.type = OCImprovementType;
    XCTAssertTrue(self.issue.type != OCUnknownType, @"should return a type");
}

- (void)test_typeName
{
    self.issue.type = OCBugType;
    XCTAssertNotNil(self.issue.typeName, @"should return a typeName");
}

@end
