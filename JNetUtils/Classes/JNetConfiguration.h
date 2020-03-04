//
//  JNetConfiguration.h
//  HelloIOS
//
//  Created by 周俊 on 2020/3/4.
//  Copyright © 2020 周俊. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JNetConfiguration : NSObject

@property(nonatomic, copy)NSString *baseURL;

@property(nonatomic, copy)NSDictionary *header;

@end

NS_ASSUME_NONNULL_END
