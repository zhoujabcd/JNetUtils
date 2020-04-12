//
//  JNetConfiguration.h
//  HelloIOS
//
//  Created by 周俊 on 2020/3/4.
//  Copyright © 2020 周俊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JNetCommon.h"
#import "JSecurityPolicy.h"

NS_ASSUME_NONNULL_BEGIN

@interface JNetConfiguration : NSObject

+(void)updateBaseURL:(NSString *)baseURL;

+(void)updateHeader:(NSDictionary *)header;

+(NSString *)getBaseURL;

+(NSDictionary *)getHeader;

+(void)updateRequestSerialization:(JNetRequestSerialization)requestSerialization;
+(JNetRequestSerialization)getRequestSerialization;

+(void)updateResponseSerialization:(JNetResponseSerialization)responseSerialization;
+(JNetResponseSerialization)getResponseSerialization;

+(void)updateSecurityPolicy:(JSecurityPolicy *)securityPolicy;
+(JSecurityPolicy *)getSecurityPolicy;

@end

NS_ASSUME_NONNULL_END
