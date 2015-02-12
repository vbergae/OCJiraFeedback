#OCJiraFeedback 
[![Build Status](https://travis-ci.org/vbergae/OCJiraFeedback.png?branch=master)](https://travis-ci.org/vbergae/OCJiraFeedback)

##Overview

Simple framework which sends feedback data from your apps to Atlassian Jira instances.

## Installation

- The supported way to get OCJiraFeedback is using [CocoaPods](http://cocoapods.org/).

	Add OCJiraFeedback to your Podfile:


	```
	platform :ios, '7.0'

	pod 'OCJiraFeedback'
	```

## Usage

* Add OCJiraFeedback to your application:

	```objectivec
	#import <OCJiraFeedback/OCJiraFeedback.h>
	```

* Add and edit a Instance.plist file to your *main bundle* in order to configure the connection to your Jira instance. Get an scaffolded version from [here](https://github.com/vbergae/OCJiraFeedback/blob/master/Resources/Instance.plist.distribution):

	Valid values for issueType: 'Improvement', 'Bug' or 'Task'.

![Instance.plist example](http://files.victorberga.com/instance_plist_example.png)

* Optionally you can import the 'OCJiraConfiguration' header and set this values as a dictionary.

	```objectivec
	#import <OCJiraFeedback/OCJiraConfiguration.h>
	
	OCJiraConfiguration.sharedConfiguration.configuration = @{
	    @"host"         : @"hostname.example.com",
	    @"username"     : @"jira_username",
	    @"password"     : @"1234",
	    @"projectKey"   : @"TEST",
	    @"issueType"    : @"Bug"
	}
	```

* Recolect the summary and description fields:

	For example, from an action implemented inside a controller with two textfield's outlets: 'summary' and 'description'.

	```objectivec
	- (IBAction)sendFeedbackAction:(id)sender
	{
		NSString *summary 		= self.summaryField.text;
		NSString *description 	= self.description.text;
	
    		[OCJiraFeedback feedbackWithSummary:summary
        		                description:description
            	        	         completion:^(NSError *error) {
	        	if (error) {
    	        	// Handle error if exists
        		};
	    	}];

		// or with a creenshot of your current view

        	[OCJiraFeedback feedbackWithSummary:summary
                	                description:description
					       view:self.view
                                	 completion:^(NSError *error) {
                	if (error) {
                		// Handle error if exists
                	}
            	}];
	}

	```
