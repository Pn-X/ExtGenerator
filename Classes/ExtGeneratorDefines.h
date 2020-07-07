//
//  ExtGeneratorDefines.h
//  ExtGenerator
//
//  Created by hang_pan on 2020/3/16.

#ifndef ExtGeneratorDefines_h
#define ExtGeneratorDefines_h

#define EXT_GENERATOR_CONCAT_ARG(x,y) x##_##y

#define EXT_GENERATOR_CONCAT(x,y) EXT_GENERATOR_CONCAT_ARG(x,y)

#define gen_variable __block

#define gen_method(f)   _Pragma("clang diagnostic push")\
                        _Pragma("clang diagnostic ignored \"-Wdeprecated-declarations\"")\
                        ExtGeneratorMutableContext *context = ((ExtGeneratorMutableContext *)[caller valueForKeyPath:@"mutableContext"]);\
                        _Pragma("clang diagnostic pop")\
                        if (context.userMethod != nil) {\
                            return;\
                        };\
                        context.userMethod = ^(ExtGenerator *caller, id inputValue, id argument) {\
                            if ([[caller valueForKeyPath:@"mutableContext.yieldFlag"] boolValue] && ((ExtGeneratorContext *)[caller valueForKeyPath:@"mutableContext"]).yieldPoistion != NULL) {\
                                goto *(((ExtGeneratorContext *)[caller valueForKeyPath:@"mutableContext"]).yieldPoistion);\
                                EXT_GENERATOR_CONCAT(EXT_GENERATOR_LABEL, __LINE__ ):[((ExtGeneratorMutableContext *)[caller valueForKeyPath:@"mutableContext"]) setYieldPoistion:&&EXT_GENERATOR_CONCAT(EXT_GENERATOR_LABEL,  __LINE__ )];\
                            }\
                            f\
                            [caller setValue:@{kExtGeneratorValue:@(0),kExtGeneratorDone:@(YES)} forKeyPath:@"mutableContext.outputValue"];\
                            [caller setValue:@(ExtGeneratorStateDone) forKeyPath:@"mutableContext.state"];\
                        };\

#define gen_yield(x)    ((void)(({ \
                            [caller setValue:@{kExtGeneratorValue:x,kExtGeneratorDone:@(NO)} forKeyPath:@"mutableContext.outputValue"];\
                            EXT_GENERATOR_CONCAT(EXT_GENERATOR_LABEL, __LINE__ ):[((ExtGeneratorMutableContext *)[caller valueForKeyPath:@"mutableContext"]) setYieldPoistion:&&EXT_GENERATOR_CONCAT(EXT_GENERATOR_LABEL, __LINE__ )];\
                            if ([[caller valueForKeyPath:@"mutableContext.yieldFlag"] boolValue]) {\
                                [caller setValue:@(NO) forKeyPath:@"mutableContext.yieldFlag"];\
                                return;\
                            } else {\
                                [caller setValue:@(YES) forKeyPath:@"mutableContext.yieldFlag"];\
                            }\
                            nil;\
                        })),\
                        _Pragma("clang diagnostic push")\
                        _Pragma("clang diagnostic ignored \"-Wunused-value\"")\
                        inputValue\
                        _Pragma("clang diagnostic pop")\
                        );

extern NSString * const kExtGeneratorValue;
extern NSString * const kExtGeneratorDone;

typedef NS_ENUM(NSInteger, ExtGeneratorState) {
    ExtGeneratorStateInit = 0,
    ExtGeneratorStateDoing,
    ExtGeneratorStateDone
};


#endif /* ExtGeneratorDefines_h */
