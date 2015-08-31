//
//  MKCCommentsPresenter.m
//  Chernosliv
//
//  Created by Vyacheslav Zavertanny on 31/08/15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import "MKCCommentsPresenter.h"

@interface MKCCommentsPresenter ()

@property (nonatomic, strong) VKPost *post;

@end

@implementation MKCCommentsPresenter

- (instancetype)initWithPost:(VKPost *)post {
    self = [super init];
    if (self) {
        _post = post;
    }
    return self;
}

- (void)configurePresenterWithUserInterface:(UIViewController<MKCCommentsViewInterface> *)userInterface {
    _userInterface = userInterface;
    [self.userInterface updateCommentsData:self.post];
}

@end
