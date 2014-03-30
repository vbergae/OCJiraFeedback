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

#pragma mark openFeedbackViewWithCompletion:

- (void)test_openFeedbackViewWith_NIL_completion
{
    XCTAssertThrows([OCJiraFeedback openFeedbackViewWithCompletion:nil],
                    @"should require a completion handler");
}

- (void)test_openFeedbackViewWithCompletion
{
    // Given
    id application      = [OCMockObject mockForClass:UIApplication.class];
    id delegate         = [OCMockObject mockForProtocol:
                           @protocol(UIApplicationDelegate)];
    id window           = [OCMockObject mockForClass:UIWindow.class];
    id rootControler    = [OCMockObject mockForClass:
                           UINavigationController.class];
    
    [[[application stub] andReturn:application] sharedApplication];
    [[[application stub] andReturn:delegate] delegate];
    [[[delegate stub] andReturn:window] window];
    [[[window stub] andReturn:rootControler] rootViewController];
    
    [[rootControler expect]
     presentViewController:OCMOCK_ANY
     animated:YES
     completion:OCMOCK_ANY];
    
    // when
    [OCJiraFeedback openFeedbackViewWithCompletion:^{}];
    
    // then
    XCTAssertNoThrow([rootControler verify],
                     @"should pop a controller on top of current stack");
    
    [rootControler stopMocking];
    [window stopMocking];
    [delegate stopMocking];
    [application stopMocking];
    
    rootControler   = nil;
    window          = nil;
    delegate        = nil;
    application     = nil;
    
}

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
    
    
    id manager = [OCMockObject partialMockForObject:OCConnectionManager.sharedManager];
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
