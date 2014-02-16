OCJiraFeedback
==============

#Summary


Simple framework which sends feedback data from your apps to Atlassian Jira instances.

## Usage

1. Adds OCJiraFeedback to your application

```
#import "OCJiraFeedback.h"
```

2. Recolect the summary a description fields and send

For example, from an action implemented inside a controller with two textfield's outlets: 'summary' and 'description'.

```
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
}
```


### Build status

Bracnh | Status
------------ | -------------
master | [![Build Status](https://travis-ci.org/vbergae/OCJiraFeedback.png?branch=master)](https://travis-ci.org/vbergae/OCJiraFeedback)
develop | [![Build Status](https://travis-ci.org/vbergae/OCJiraFeedback.png?branch=develop)](https://travis-ci.org/vbergae/OCJiraFeedback)
