//
//  JNetTool.m
//  HelloIOS
//
//  Created by 周俊 on 2020/3/4.
//  Copyright © 2020 周俊. All rights reserved.
//

#import "JNetTool.h"

@implementation JNetTool

+(instancetype)shareInstance
{
    static dispatch_once_t token;
    static JNetTool *instance = nil;
    
    dispatch_once(&token, ^{
        if(instance == nil)
        {
            instance = [[JNetTool alloc]init];
        }
    });
    
    return instance;
}

-(AFSSLPinningMode)getPinningMode:(JSSLPinningMode)pinningMode
{
    if(pinningMode == JSSLPinningModeNone)
    {
        return AFSSLPinningModeNone;
    }
    else if(pinningMode == JSSLPinningModePublicKey)
    {
        return AFSSLPinningModePublicKey;
    }
    else if(pinningMode == JSSLPinningModeCertificate)
    {
        return AFSSLPinningModeCertificate;
    }
    
    return AFSSLPinningModeNone;
}


-(AFHTTPRequestSerializer *)getRequestSerialization:(JNetRequestSerialization)requestSerializer
{
    if(requestSerializer == HTTPRequestSerializer)
    {
        return [AFHTTPRequestSerializer serializer];
    }
    else if(requestSerializer == JSONRequestSerializer)
    {
        return [AFJSONRequestSerializer serializer];
    }
    else if(requestSerializer == PropertyListRequestSerializer)
    {
        return [AFPropertyListRequestSerializer serializer];
    }
    
    return nil;
}

-(AFHTTPResponseSerializer *)getResponseSerialization:(JNetResponseSerialization)responseSerializer
{
    if(responseSerializer == HTTPResponseSerializer)
    {
        return [AFHTTPResponseSerializer serializer];
    }
    else if(responseSerializer == JSONResponseSerializer)
    {
        return [AFJSONResponseSerializer serializer];
    }
    else if(responseSerializer == XMLParserResponseSerializer)
    {
        return [AFXMLParserResponseSerializer serializer];
    }
    else if(responseSerializer == PropertyListResponseSerializer)
    {
        return [AFPropertyListResponseSerializer serializer];
    }
    else if(responseSerializer == ImageResponseSerializer)
    {
        return [AFImageResponseSerializer serializer];
    }
    else if(responseSerializer == CompoundResponseSerializer)
    {
        return [AFCompoundResponseSerializer serializer];
    }
    
    return nil;
}

-(NSString *)assembleURL:(NSString *)baseURL apiURL:(NSString *)apiURL
{
    NSString* regStr = @"^http.*$";
    
    NSPredicate *regHttp = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regStr];
    
    if ([regHttp evaluateWithObject:apiURL] == YES)
    {
        return apiURL;
    }
    
    return [baseURL stringByAppendingString:apiURL];
}

@end
