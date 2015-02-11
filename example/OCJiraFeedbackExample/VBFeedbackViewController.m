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
#warning Check Instance.plist and edit before to use it!!
    
    NSString *summary       = self.summaryTextField.text;
    NSString *description   = self.descriptionTextView.text;
    
    [OCJiraFeedback feedbackWithSummary:summary
                            description:description
                                   view:self.view
                             completion:^(NSError *error)
    {
        NSLog(@"Feedback result: %@", error);
        [self dismissControllerAction:nil];
    }];
}

@end
