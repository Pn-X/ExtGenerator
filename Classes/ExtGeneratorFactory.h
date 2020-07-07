//
//  ExtGeneratorFactory.h
//  ExtGenerator
//
//  Created by hang_pan on 2020/3/16.

#import <Foundation/Foundation.h>

@class ExtGenerator;

@interface ExtGeneratorFactory : NSObject

+ (ExtGeneratorFactory *)shared;

- (void)regist:(NSString *)name withBuilder:(ExtGenerator *(^)(id argument))builder;

- (void)unregist:(NSString *)name;

- (BOOL)hasRegist:(NSString *)name;

- (ExtGenerator *)build:(NSString *)name;

- (ExtGenerator *)build:(NSString *)name withArgument:(id)argument;

@end
