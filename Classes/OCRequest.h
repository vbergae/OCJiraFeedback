//
//  OCRequest.h
//  OCJiraFeedback
//
//  Created by Víctor on 29/03/14.
//  Copyright (c) 2014 VictorBerga.com. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "OCConnectionManager.h"

/**
 Indicates the method used in the request.
 
 Use this constant to set the requestMethod property.
 */
typedef NS_ENUM(unsigned char, OCRequestMethod) {
    OCRequestMethodGET,
    OCRequestMethodPOST
};

@interface OCRequest : NSObject

/**
 @name Properties
 */

/**
 The destination's relative path for this request.
 */
@property (readonly) NSString *path;

/**
 The method to use for this request.
 */
@property (readonly) OCRequestMethod requestMethod;

/**
 The parameters to use for this request
 */
@property (readonly) NSDictionary *parameters;

/**
 @name Initializing Requests
 */

/**
 Default initializer
 
 Creates a request instance using the path, parameters (if exists) and
 request method.
 
 @param path Relative path
 @param parameters 
 @param requestMethod
 
 @return Request instance
 */
- (id)initWithPath:(NSString *)path
        paremeters:(NSDictionary *)parameters
     requestMethod:(OCRequestMethod)requestMethod;

/**
 @name Sending Requests
 */

/**
 Performs the request and calls the specified handler when done.
 
 @param handler The handler to call when the request is done. This
 handler will be called using main thread.
 */
- (void)performRequestWithHandler:(void(^)(id responseObject,
                                           NSError *error))handler;

/**
 Specifies a named multipart POST body for this request.
 */
- (void)addMultiPartData:(NSData *)data
                withName:(NSString *)name
                    type:(NSString *)type;


+ (OCConnectionManager *)manager;

@end
