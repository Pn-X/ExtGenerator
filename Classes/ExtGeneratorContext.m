//
//  ExtGeneratorContext.m
//  ExtGenerator
//
//  Created by hang_pan on 2020/3/16.


#import "ExtGeneratorContext.h"

@interface ExtGeneratorContext (){
    @public void *yieldPosition;
}

@end

@implementation ExtGeneratorContext

- (void *)yieldPoistion {
    return self->yieldPosition;
}

- (void)setYieldPoistion:(void *)yieldPosition {
    self->yieldPosition = yieldPosition;
}

@end

@implementation ExtGeneratorMutableContext
@synthesize state;
@synthesize step;
@synthesize inputValue;
@synthesize outputValue;
@synthesize yieldFlag;
@synthesize argument;
@synthesize userMethod;
@synthesize block;

- (void)setYieldPoistion:(void *)yieldPosition {
    [super setYieldPoistion:yieldPosition];
}

@end

