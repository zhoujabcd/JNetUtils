//
//  JNetConfiguration.m
//  HelloIOS
//
//  Created by 周俊 on 2020/3/4.
//  Copyright © 2020 周俊. All rights reserved.
//

#import "JNetConfiguration.h"

NSString *_baseURL;

NSDictionary *_header;

JNetRequestSerialization _requestSerializer;
JNetResponseSerialization _responseSerializer;

JSecurityPolicy *_securityPolicy;

@implementation JNetConfiguration

+ (void)initialize
{
    if (self == [JNetConfiguration class]) {
        _requestSerializer = HTTPRequestSerializer;
        _responseSerializer = JSONResponseSerializer;
        
        _securityPolicy = [JSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    }
}

+(void)updateSecurityPolicy:(JSecurityPolicy *)securityPolicy
{
    _securityPolicy = securityPolicy;
}

+(JSecurityPolicy *)getSecurityPolicy
{
    return _securityPolicy;
}

+(void)updateRequestSerialization:(JNetRequestSerialization)requestSerialization
{
    _requestSerializer = requestSerialization;
}

+(JNetRequestSerialization)getRequestSerialization
{
    return _requestSerializer;
}

+(void)updateResponseSerialization:(JNetResponseSerialization)responseSerialization
{
    _responseSerializer = responseSerialization;
}

+(JNetResponseSerialization)getResponseSerialization
{
    return _responseSerializer;
}

+(void)updateBaseURL:(NSString *)baseURL
{
    _baseURL = baseURL;
}

+(NSString *)getBaseURL
{
    return _baseURL;
}

+(void)updateHeader:(NSDictionary *)header
{
    _header = header;
}

+(NSDictionary *)getHeader
{
    return _header;
}

@end
