//
//  JUserAgentTool.h
//  JNetUtils-Dev
//
//  Created by 周俊 on 2020/4/12.
//  Copyright © 2020 周俊. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JUserAgentTool : NSObject

+ (NSString *)getBundleId;

+ (NSString *) getLocalAppVersion;

+ (NSString *)getAppName;

+ (NSString *)getSystemName;

+ (NSString *)getNormalUserAgent;

@end

NS_ASSUME_NONNULL_END
