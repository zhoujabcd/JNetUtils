//
//  JUserAgentTool.m
//  JNetUtils-Dev
//
//  Created by 周俊 on 2020/4/12.
//  Copyright © 2020 周俊. All rights reserved.
//

#import "JUserAgentTool.h"
#import <UIKit/UIKit.h>

@implementation JUserAgentTool

+ (NSString *)getBundleId
{
    return [[NSBundle mainBundle] bundleIdentifier];
}

+ (NSString *)getLocalAppVersion

{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

+ (NSString *)getAppName
{
    return  [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
}

+ (NSString *)getSystemName

{
    return [[UIDevice currentDevice] systemName];
}

+ (NSString *)getNormalUserAgent
{
    NSString *bundleId = [JUserAgentTool getBundleId];
    
//    NSString *appName = [JUserAgentTool getAppName];
    
    NSString *appVersion = [JUserAgentTool getLocalAppVersion];
    
    NSString *userAgent = [[NSString alloc]initWithFormat:@"BundleId/%@ AppVersion/%@",bundleId, appVersion];
    
    return userAgent;
}

@end
