//
//  JNetCommon.h
//  HelloIOS
//
//  Created by 周俊 on 2020/3/4.
//  Copyright © 2020 周俊. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, JNetRequestMethod) {
    POST,
    GET
};

typedef NS_ENUM(NSInteger, JNetRequestSerialization) {
    HTTPRequestSerializer,
    JSONRequestSerializer,
    PropertyListRequestSerializer
};

typedef NS_ENUM(NSInteger, JNetResponseSerialization) {
    HTTPResponseSerializer,
    JSONResponseSerializer,
    XMLParserResponseSerializer,
    PropertyListResponseSerializer,
    ImageResponseSerializer,
    CompoundResponseSerializer
};

@interface JNetCommon : NSObject

@end

NS_ASSUME_NONNULL_END
