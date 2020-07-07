//
//  ExtGenerator.h
//  ExtGenerator
//
//  Created by hang_pan on 2020/3/16.


#import <Foundation/Foundation.h>
#import "ExtGeneratorContext.h"
#import "ExtGeneratorFactory.h"

@interface ExtGenerator : NSObject

@property (nonatomic, strong, readonly) ExtGeneratorContext *context OBJC_UNAVAILABLE("do not use");

@property (nonatomic, assign, readonly) ExtGeneratorState state;

@property (nonatomic, assign, readonly) NSInteger step;

@property (nonatomic, strong, readonly) id value;

- (instancetype)initWithBlock:(void(^)(ExtGenerator *caller, id argument))block;

- (instancetype)initWithArgument:(id)argument block:(void(^)(ExtGenerator *caller, id argument))block;

- (id(^)(void))next;

- (id(^)(id value))send;

@end
