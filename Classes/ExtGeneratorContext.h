//
//  ExtGeneratorContext.h
//  ExtGenerator
//
//  Created by hang_pan on 2020/3/16.

#import <Foundation/Foundation.h>
#import "ExtGeneratorDefines.h"

@class ExtGenerator;

@interface ExtGeneratorContext : NSObject

@property (nonatomic, assign, readonly) ExtGeneratorState state;
@property (nonatomic, assign, readonly) NSInteger step;
@property (nonatomic, strong, readonly) id inputValue;
@property (nonatomic, strong, readonly) id outputValue;
@property (nonatomic, assign, readonly) BOOL yieldFlag;
@property (nonatomic, assign, readonly) id argument;
@property (nonatomic, strong, readonly) void(^userMethod)(ExtGenerator *caller, id inputValue, id argument);
@property (nonatomic, strong, readonly) void(^block)(ExtGenerator *caller, id argument);

- (void *)yieldPoistion;

@end

@interface ExtGeneratorMutableContext : ExtGeneratorContext

@property (nonatomic, assign, readwrite) ExtGeneratorState state;
@property (nonatomic, assign, readwrite) NSInteger step;
@property (nonatomic, strong, readwrite) id inputValue;
@property (nonatomic, strong, readwrite) id outputValue;
@property (nonatomic, assign, readwrite) BOOL yieldFlag;
@property (nonatomic, assign, readwrite) id argument;
@property (nonatomic, strong, readwrite) void(^userMethod)(ExtGenerator *caller, id inputValue, id argument);
@property (nonatomic, strong, readwrite) void(^block)(ExtGenerator *caller, id argument);

- (void)setYieldPoistion:(void *)yieldPoistion;

@end
