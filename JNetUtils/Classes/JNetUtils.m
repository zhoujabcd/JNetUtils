//
//  JNetUtils.m
//  HelloIOS
//
//  Created by 周俊 on 2020/3/3.
//  Copyright © 2020 周俊. All rights reserved.
//

#import "JNetUtils.h"
#import "JNetTool.h"

@implementation JNetUtils

+(JNetUtils *)build
{
    return [[JNetUtils alloc]init];
}

+ (void)initialize
{
}


- (void)dealloc
{
    NSLog(@"JNetUtils dealloc");
}

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        _configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        _manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:_configuration];
        
        _methodStr = @"POST";
        _urlStr = @"";
        
        _requestSerializer = [JNetConfiguration getRequestSerialization];
        _responseSerializer = [JNetConfiguration getResponseSerialization];
        
        _manager.responseSerializer = [[JNetTool shareInstance] getResponseSerialization:_responseSerializer];
        
        if([JNetConfiguration getHeader] != nil)
        {
            _header = [JNetConfiguration getHeader];
        }
        
        _manager.securityPolicy = [JNetConfiguration getSecurityPolicy];
        
        _timeoutInterval = [JNetConfiguration getTimeoutInterval];
        
        _cachePolicy = [JNetConfiguration getCachePolicy];
    }
    
    return self;
}

-(instancetype)updateParams:(NSDictionary *)dataDic
{
    _dataDic = dataDic;
    
    return self;
}

-(instancetype)updateMethod:(JNetRequestMethod)method
{
    if(method == POST)
    {
        _methodStr = @"POST";
    }
    else if(method == GET)
    {
        _methodStr = @"GET";
    }
    
//    NSLog(@"request method: %@", _methodStr);
    
    return self;
}

-(instancetype)updateURL:(NSString *)url
{
    _urlStr = url;
    
    return self;
}

-(instancetype)updateRequestSerialization:(JNetRequestSerialization)requestSerialization
{
    _requestSerializer = requestSerialization;
    
    return self;
}

-(instancetype)updateResponseSerialization:(JNetResponseSerialization)responseSerialization
{
    _responseSerializer = responseSerialization;
    
    _manager.responseSerializer = [[JNetTool shareInstance] getResponseSerialization:self.responseSerializer];
    
    return self;
}

-(instancetype)updateHeader:(NSDictionary *)header
{
    _header = header;
    
    return self;
}

-(instancetype)updateTimeoutInterval:(float)time
{
    _timeoutInterval = time;
    
    return self;
}

-(instancetype)updateSecurityPolicy:(JSSLPinningMode)pinningMode cerData:(NSSet * _Nullable)cerData
{
    if(cerData != nil)
    {
        _securityPolicy = [JSecurityPolicy policyWithPinningMode:pinningMode withPinnedCertificates:cerData];
    }
    else
    {
        _securityPolicy = [JSecurityPolicy policyWithPinningMode:pinningMode];
    }
    
    _manager.securityPolicy = _securityPolicy;
    
    return self;
}

-(instancetype)updateCachePolicy:(NSURLRequestCachePolicy)cachePolicy
{
    _cachePolicy = cachePolicy;
    
    return self;
}

-(void)requestData:(void(^)(NSProgress  * _Nullable uploadProgress))uploadProgress downloadProgress:(void(^)(NSProgress  * _Nullable downloadProgress))downloadProgress completionHandler:(void (^)(NSURLResponse * _Nonnull response, id _Nullable responseObject, NSError * _Nullable error))completionHandler
{
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    
//    __weak typeof(self) wS = self;
    
    dispatch_async(queue, ^{
//        __strong typeof(wS) sS = wS;
         __strong typeof(self) sS = self;
        
        NSString *url = nil;
        
        if([JNetConfiguration getBaseURL] != nil)
        {
            url = [[JNetTool shareInstance]assembleURL:[JNetConfiguration getBaseURL] apiURL:sS.urlStr];
        }
        else
        {
            url = sS.urlStr;
        }
        
        NSMutableURLRequest *request = [[[JNetTool shareInstance] getRequestSerialization:sS.requestSerializer]requestWithMethod:sS.methodStr URLString:url parameters:sS.dataDic error:NULL];
        
        request.timeoutInterval = sS.timeoutInterval;
        request.cachePolicy = sS.cachePolicy;
        
        if(sS.header != nil)
        {
            [sS.header enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                [request addValue:obj forHTTPHeaderField:key];
            }];
        }
        
        NSURLSessionDataTask *dataTask = [sS.manager dataTaskWithRequest:request uploadProgress:uploadProgress downloadProgress:downloadProgress completionHandler:completionHandler];
        
        [dataTask resume];
    });
}

@end
