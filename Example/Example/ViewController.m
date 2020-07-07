//
//  ViewController.m
//  Example
//
//  Created by hang_pan on 2020/5/13.
//  Copyright © 2020 hang_pan. All rights reserved.
//

#import "ViewController.h"
#import <ExtGenerator/ExtGenerator.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[ExtGeneratorFactory shared] regist:@"fibo" withBuilder:^ExtGenerator *(id argument) {
        return [[ExtGenerator alloc] initWithBlock:^(ExtGenerator *caller, id argument) {
            gen_variable NSInteger a = 0;
            gen_variable NSInteger b = 1;
            gen_method({
                while (1) {
                    inputValue = gen_yield(@(b));
                    b = a + b;
                    a = b - a;
                }
            });
        }];
    }];
    
    ExtGenerator *fibo = [[ExtGeneratorFactory shared] build:@"fibo" withArgument:@(10)];
    for (int i = 0; i < 20; i++) {
        id v = fibo.send(@(i));
        NSLog(@"fibo value: %@", v);
    }
}


@end
