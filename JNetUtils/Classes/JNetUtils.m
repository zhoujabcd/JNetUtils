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
    if (self == [JNetUtils class]) {
        jConfig = [[JNetConfiguration alloc]init];
    }
}

+(void)updateBaseURL:(NSString *)baseURL
{
    jConfig.baseURL = baseURL;
}

+(void)updateHeader:(NSDictionary *)header
{
    jConfig.header = header;
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
        
        _methodStr = @"GET";
        _urlStr = @"";
        _requestSerializer = HTTPRequestSerializer;
        _responseSerializer = HTTPResponseSerializer;
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
    
    NSLog(@"request method: %@", _methodStr);
    
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
    
    return self;
}

-(instancetype)updateHeader:(NSDictionary *)header
{
    _header = header;
    
    return self;
}

-(instancetype)updateSecurityPolicy:(AFSecurityPolicy *)securityPolicy
{
    _securityPolicy = securityPolicy;
    
    return self;
}

-(void)requestData:(void(^)(NSProgress * _Nonnull uploadProgress))uploadProgress downloadProgress:(void(^)(NSProgress * _Nonnull downloadProgress))downloadProgress completionHandler:(void (^)(NSURLResponse * _Nonnull response, id _Nullable responseObject, NSError * _Nullable error))completionHandler
{
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    
//    __weak typeof(self) wS = self;
    
    dispatch_async(queue, ^{
//        __strong typeof(wS) sS = wS;
         __strong typeof(self) sS = self;
        
        NSString *url = nil;
        
        if(jConfig.baseURL != nil)
        {
            url = [[JNetTool shareInstance]assembleURL:jConfig.baseURL apiURL:sS.urlStr];
        }
        else
        {
            url = sS.urlStr;
        }
        
        NSMutableURLRequest *request = [[[JNetTool shareInstance] getRequestSerialization:sS.requestSerializer]requestWithMethod:sS.methodStr URLString:url parameters:sS.dataDic error:NULL];

        sS.manager.responseSerializer = [[JNetTool shareInstance] getResponseSerialization:sS.responseSerializer];
        
        if(jConfig.header != nil)
        {
            [jConfig.header enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                [request addValue:obj forHTTPHeaderField:key];
            }];
        }
        
        if(sS.header != nil)
        {
            [sS.header enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                [request addValue:obj forHTTPHeaderField:key];
            }];
        }
        
        if(sS.securityPolicy != nil)
        {
            sS.manager.securityPolicy = sS.securityPolicy;
        }
        
        NSURLSessionDataTask *dataTask = [sS.manager dataTaskWithRequest:request uploadProgress:uploadProgress downloadProgress:downloadProgress completionHandler:completionHandler];
        
        [dataTask resume];
    });
}

@end
