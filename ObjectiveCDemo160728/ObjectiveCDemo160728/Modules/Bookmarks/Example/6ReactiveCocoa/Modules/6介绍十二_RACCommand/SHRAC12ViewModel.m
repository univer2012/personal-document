//
//  SHRAC12ViewModel.m
//  ObjectiveCDemo160728
//
//  Created by Mac on 2019/12/22.
//  Copyright © 2019 huangaengoln. All rights reserved.
//

#import "SHRAC12ViewModel.h"

@implementation SHRAC12ViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        @weakify(self)
        self.priceSpreadCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            @weakify(self)
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                @strongify(self)
                NSLog(@"aldjfsjdofje ");
                [subscriber sendNext:nil];
                [subscriber sendCompleted];
                return nil;
            }];
        }];
        
        
    }
    return self;
}

@end
