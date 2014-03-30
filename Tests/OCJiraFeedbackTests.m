//
//  OCJiraFeedbackTests.m
//  OCJiraFeedback
//
//  Created by Víctor on 19/02/14.
//  Copyright (c) 2014 VictorBerga.com. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

#import "OCJiraFeedback.h"
#import "OCConnectionManager.h"

@interface OCJiraFeedbackTests : XCTestCase

@end

@implementation OCJiraFeedbackTests

#pragma mark -
#pragma mark Class methods

#pragma mark feedbackWithSummary:description:completion:

- (void)test_feedbackWithSummary
{
    NSString *path = @"rest/api/2/issue";
    NSDictionary *parameters = @{
        @"fields" : @{
            @"description" : @"description",
            @"issuetype"  : @{
                    @"name" : @"Task"
            },
            @"project"    : @{
                    @"key" : @"KEY"
            },
            @"summary"      : @"summary"
        }
    };
    
    
    id manager = [OCMockObject mockForClass:OCConnectionManager.class];
    [[[manager stub] andReturn:manager] sharedManager];
    [[[manager stub] andReturn:@"Task"] issueType];
    [[[manager stub] andReturn:@"KEY"] projectKey];
    [[manager expect] POST:path
                parameters:parameters
                   success:OCMOCK_ANY
                   failure:OCMOCK_ANY];
    
    [OCJiraFeedback feedbackWithSummary:@"summary"
                            description:@"description"
                             completion:^(NSError *error) {}];
    
    XCTAssertNoThrow([manager expect],
                     @"should send and issue using OCConnectionManager");
}

#pragma mark feedbackWithSummary:description:view:completion

- (void)test_feedbackWithSummary_view_without_summary
{
    XCTAssertThrows(
        [OCJiraFeedback feedbackWithSummary:nil
                                description:@""
                                       view:UIView.new
                                 completion:^(NSError *error) {}],
        @"should throw exception"
    );
}

- (void)test_feedbackWithSummary_view_without_description
{
    XCTAssertThrows(
        [OCJiraFeedback feedbackWithSummary:@""
                                description:nil
                                        view:UIView.new
                                completion:^(NSError *error) {}],
        @"should throw exception"
    );
}

- (void)test_feedbackWithSummary_view_without_handler
{
    XCTAssertThrows(
        [OCJiraFeedback feedbackWithSummary:@""
                                description:@""
                                       view:UIView.new
                                 completion:nil],
            @"should throw exception"
    );
}

@end
