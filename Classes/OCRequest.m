//
//  OCRequest.m
//  OCJiraFeedback
//
//  Created by Víctor on 29/03/14.
//  Copyright (c) 2014 VictorBerga.com. All rights reserved.
//

#import "OCRequest.h"
#import "OCConnectionManager.h"

static NSString * const kMultipartDataKey   = @"data";
static NSString * const kMultipartNameKey   = @"name";
static NSString * const kMultipartTypeKey   = @"type";

@interface OCRequest() {
@private
    NSMutableArray *_multipartData;
}

@property (readwrite) NSString *path;
@property (readwrite) NSDictionary *parameters;
@property (readwrite) OCRequestMethod requestMethod;
@property (readonly) NSMutableArray *multipartData;

- (void)performGET:(void(^)(id responseObject, NSError *error))handler;

- (void)performPOST:(void(^)(id responseObject, NSError *error))handler;

@end

@implementation OCRequest

#pragma mark -
#pragma mark Properties

+ (OCConnectionManager *)manager
{
    return OCConnectionManager.sharedManager;
}

- (NSMutableArray *)multipartData
{
    if (!_multipartData) {
        _multipartData = NSMutableArray.new;
    }
    
    return _multipartData;
}

#pragma mark -
#pragma mark Initialization

- (id)initWithPath:(NSString *)path
        paremeters:(NSDictionary *)parameters
     requestMethod:(OCRequestMethod)requestMethod
{
    NSParameterAssert(path);
    
    self = [super init];
    if (self) {
        self.path           = path;
        self.parameters     = parameters;
        self.requestMethod  = requestMethod;
    }
    
    return self;
}

#pragma mark -
#pragma mark Instance methods

- (void)performRequestWithHandler:(void (^)(id, NSError *))handler
{
    NSAssert(self.requestMethod == OCRequestMethodGET
             || self.requestMethod == OCRequestMethodPOST,
             @"Unknown requestMethod");
    
    if (self.requestMethod == OCRequestMethodGET)
        [self performGET:handler];
    else if (self.requestMethod == OCRequestMethodPOST)
        [self performPOST:handler];
}

- (void)addMultiPartData:(NSData *)data
                withName:(NSString *)name
                    type:(NSString *)type
{
    NSDictionary *multipart = @{kMultipartDataKey : data,
                                kMultipartNameKey : name,
                                kMultipartTypeKey : type};
    
    [self.multipartData addObject:multipart];
}

#pragma mark -
#pragma mark Private methods

- (void)performGET:(void (^)(id, NSError *))handler
{
    [OCRequest.manager GET:self.path
                parameters:self.parameters
                   success:^(AFHTTPRequestOperation *operation,
                             id responseObject)
    {
        handler(responseObject, nil);
    }
                   failure:^(AFHTTPRequestOperation *operation,
                             NSError *error)
    {
        handler(nil, error);
    }];
}

- (void)performPOST:(void (^)(id, NSError *))handler
{
    if (!self.multipartData.count) {
        [OCRequest.manager POST:self.path
                     parameters:self.parameters
                        success:^(AFHTTPRequestOperation *operation,
                                  id responseObject)
        {
            handler(responseObject, nil);
        }
                        failure:^(AFHTTPRequestOperation *operation,
                                  NSError *error)
        {
            handler(nil, error);
        }];
    } else {
        [self performMultipartPOST:handler];
    }
}

- (void)performMultipartPOST:(void(^)(id, NSError *))handler
{
    [OCRequest.manager POST:self.path
                 parameters:self.parameters
  constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
     {
         [self appendMultipartToFormData:formData];
     }
                    success:^(AFHTTPRequestOperation *operation,
                              id responseObject)
     {
         handler(responseObject, nil);
     }
                    failure:^(AFHTTPRequestOperation *operation,
                              NSError *error)
     {
         handler(nil, error);
     }];
}

- (void)appendMultipartToFormData:(id<AFMultipartFormData>)formData
{
    for (NSDictionary *multipart in self.multipartData) {
        NSData *data        = multipart[kMultipartDataKey];
        NSString *name      = multipart[kMultipartNameKey];
        NSString *type      = multipart[kMultipartTypeKey];
        NSString *filename  = [self filenameForName:name type:type];

        NSAssert(data, @"data name not found");
        NSAssert(name, @"Multipart name not found");
        NSAssert(type, @"Multipart type not found");
        NSAssert(filename, @"Multipart filename not found");
        
        [formData appendPartWithFileData:data
                                    name:name
                                fileName:filename
                                mimeType:type];
    }
}

- (NSString *)filenameForName:(NSString *)name type:(NSString *)type
{
    NSString *filename  = name;
    NSRange separator   = [type rangeOfString:@"/"];
    
    if (separator.location != NSNotFound) {
        NSString *extension = [type substringFromIndex:separator.location];
        filename = [NSString stringWithFormat:@"%@.%@",
                    name, extension];
    }
    
    return filename;
}

@end
