//
//  VBFeedbackViewController.m
//  OCJiraFeedbackExample
//
//  Created by Víctor on 16/02/14.
//  Copyright (c) 2014 VictorBerga.com. All rights reserved.
//

#import <OCJiraFeedback/OCJiraFeedback.h>

#import "VBFeedbackViewController.h"

@interface VBFeedbackViewController ()

@end

@implementation VBFeedbackViewController

- (IBAction)dismissControllerAction:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)sendFeedbackAction:(id)sender
{
    NSString *summary       = self.summary.text;
    NSString *description   = self.description.text;
    
    [OCJiraFeedback feedbackWithSummary:summary
                            description:description
                             completion:^(NSError *error)
    {
        NSLog(@"Feedback result: %@", error);
        [self dismissControllerAction:nil];
    }];
}

@end
