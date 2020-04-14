//
//  JNetUtils.h
//  HelloIOS
//
//  Created by 周俊 on 2020/3/3.
//  Copyright © 2020 周俊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import "JNetCommon.h"
#import "JNetConfiguration.h"
#import "JSecurityPolicy.h"

NS_ASSUME_NONNULL_BEGIN

static JNetConfiguration *jConfig = nil;

@interface JNetUtils : NSObject

@property(nonatomic, strong)NSURLSessionConfiguration *configuration;
@property(nonatomic, strong)AFURLSessionManager *manager;
@property(nonatomic, copy)NSDictionary *dataDic;
@property(nonatomic, copy)NSString *methodStr;
@property(nonatomic, copy)NSString *urlStr;
@property(nonatomic, copy)NSDictionary *header;
@property(nonatomic, strong)JSecurityPolicy *securityPolicy;

@property(nonatomic, assign)JNetRequestSerialization requestSerializer;
@property(nonatomic, assign)JNetResponseSerialization responseSerializer;

@property(nonatomic, assign)float timeoutInterval;
@property(nonatomic, assign)NSURLRequestCachePolicy cachePolicy;


+(JNetUtils *)build;


-(instancetype)init;

-(instancetype)updateParams:(NSDictionary *)dataDic;

-(instancetype)updateMethod:(JNetRequestMethod)method;

-(instancetype)updateURL:(NSString *)url;

-(instancetype)updateRequestSerialization:(JNetRequestSerialization)requestSerialization;

-(instancetype)updateResponseSerialization:(JNetResponseSerialization)responseSerialization;

-(instancetype)updateHeader:(NSDictionary *)header;

-(instancetype)updateSecurityPolicy:(JSSLPinningMode)pinningMode cerData:(NSSet  * _Nullable)cerData;

-(instancetype)updateTimeoutInterval:(float)time;

-(instancetype)updateCahePolicy:(NSURLRequestCachePolicy)cachePolicy;

-(void)requestData:( void(^ _Nullable )(NSProgress  * _Nullable uploadProgress))uploadProgress downloadProgress:(void(^ _Nullable )(NSProgress  * _Nullable downloadProgress))downloadProgress completionHandler:(void (^)(NSURLResponse * _Nonnull response, id _Nullable responseObject, NSError * _Nullable error))completionHandler;

@end

NS_ASSUME_NONNULL_END
