//
//  JNetTool.h
//  HelloIOS
//
//  Created by 周俊 on 2020/3/4.
//  Copyright © 2020 周俊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JNetCommon.h"
#import <AFNetworking.h>
#import <AFURLRequestSerialization.h>

NS_ASSUME_NONNULL_BEGIN

@interface JNetTool : NSObject

//@property (nonatomic, copy)NSDictionary<NSInteger,id> *requestSerializationDic;

+(instancetype)shareInstance;

-(AFHTTPRequestSerializer *)getRequestSerialization:(JNetRequestSerialization)requestSerializer;
-(AFHTTPResponseSerializer *)getResponseSerialization:(JNetResponseSerialization)responseSerializer;

-(NSString *)assembleURL:(NSString *)baseURL apiURL:(NSString *)apiURL;

@end

NS_ASSUME_NONNULL_END
