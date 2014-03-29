//
//  VBFeedbackViewController.h
//  OCJiraFeedbackExample
//
//  Created by Víctor on 16/02/14.
//  Copyright (c) 2014 VictorBerga.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VBFeedbackViewController : UIViewController

#pragma mark -
#pragma mark Outlets

@property (weak, nonatomic) IBOutlet UITextField *summary;

@property (weak, nonatomic) IBOutlet UITextView *description;

#pragma mark -
#pragma mark Actios

- (IBAction)dismissControllerAction:(id)sender;

- (IBAction)sendFeedbackAction:(id)sender;

@end
