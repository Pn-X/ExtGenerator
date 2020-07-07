//
//  ExtGeneratorFactory.m
//  ExtGenerator
//
//  Created by hang_pan on 2020/3/16.

#import "ExtGeneratorFactory.h"
#import "ExtGenerator.h"

@interface ExtGeneratorFactory()

@property (nonatomic, strong) NSMutableDictionary *builderMap;

@end

@implementation ExtGeneratorFactory

+ (ExtGeneratorFactory *)shared {
    static ExtGeneratorFactory *f;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        f = [ExtGeneratorFactory new];
    });
    return f;
}

- (void)regist:(NSString *)name withBuilder:(ExtGenerator *(^)(id argument))builder {
    if (name == nil || builder == nil) {
        return;
    }
    self.builderMap[name] = builder;
}

- (void)unregist:(NSString *)name {
    if (name == nil) {
        return;
    }
    [self.builderMap removeObjectForKey:name];
}

- (BOOL)hasRegist:(NSString *)name {
    if (name == nil) {
        return NO;
    }
    return self.builderMap[name] != nil;
}

- (ExtGenerator *)build:(NSString *)name {
    return [self build:name withArgument:nil];
}

- (ExtGenerator *)build:(NSString *)name withArgument:(id)argument {
    if (name == nil) {
        return nil;
    }
    ExtGenerator *(^builder)(id argument) = self.builderMap[name];
    ExtGenerator *generator = builder?builder(argument):nil;
    if (![generator isKindOfClass:[ExtGenerator class]]) {
        generator = nil;
    }
    return generator;
}

- (NSMutableDictionary *)builderMap {
    if (!_builderMap) {
        _builderMap = [@{} mutableCopy];
    }
    return _builderMap;
}

@end
