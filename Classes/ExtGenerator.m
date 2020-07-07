//
//  ExtGenerator.m
//  ExtGenerator
//
//  Created by hang_pan on 2020/3/16.


#import "ExtGenerator.h"

NSString * const kExtGeneratorValue = @"value";
NSString * const kExtGeneratorDone = @"done";

@interface ExtGenerator()

@property (nonatomic, strong) ExtGeneratorMutableContext *mutableContext;

@end

@implementation ExtGenerator

- (instancetype)initWithBlock:(void(^)(ExtGenerator *caller, id argument))block {
    return [self initWithArgument:nil block:block];
}

- (instancetype)initWithArgument:(id)argument block:(void(^)(ExtGenerator *caller, id argument))block {
    self = [super init];
    if (self) {
        self.mutableContext = [ExtGeneratorMutableContext new];
        self.mutableContext.block = block;
        self.mutableContext.argument = argument;
        self.mutableContext.yieldFlag = YES;
        self.mutableContext.outputValue = @{kExtGeneratorValue:@(0),kExtGeneratorDone:@NO};
    }
    return self;
}

- (id(^)(void))next {
    return ^id {
        return self.send(nil);
    };
}

- (id(^)(id value))send {
    return ^id (id value) {
        if (self.mutableContext.state == ExtGeneratorStateInit) {
            self.mutableContext.state = ExtGeneratorStateDoing;
            if (self.mutableContext.block) {
                self.mutableContext.block(self, self.mutableContext.argument);
            } else {
                self.mutableContext.state = ExtGeneratorStateDone;
                self.mutableContext.outputValue = @{kExtGeneratorValue:@(0),kExtGeneratorDone:@YES};
            }
        }
        if (self.mutableContext.state == ExtGeneratorStateDoing) {
            self.mutableContext.step++;
            if (self.mutableContext.userMethod) {
                self.mutableContext.userMethod(self, value, self.mutableContext.argument);
            }
        }
        return self.mutableContext.outputValue;
    };
}

- (ExtGeneratorState)state {
    return self.mutableContext.state;
}

- (NSInteger)step {
    return self.mutableContext.step;
}

- (id)value {
    return self.mutableContext.outputValue;
}

- (ExtGeneratorContext *)context {
    return self.mutableContext;
}

- (void)dealloc {
#ifdef DEBUG
    NSLog(@"%@ - dealloc", self);
#else
#endif
}

@end
