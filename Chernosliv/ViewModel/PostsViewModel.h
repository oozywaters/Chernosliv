//
//  PostsViewModel.h
//  Chernosliv
//
//  Created by Vacheslav Zavertanny on 11.07.15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface PostsViewModel : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSMutableArray *posts;
@property (nonatomic, strong) RACCommand *updateCommand;

@end
