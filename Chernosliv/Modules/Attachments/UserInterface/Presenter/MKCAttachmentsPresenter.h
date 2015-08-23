//
//  MKCAttachmentsPresenter.h
//  Chernosliv
//
//  Created by Vyacheslav Zavertanny on 20/08/15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import "MKCAttachmentsModuleInterface.h"
#import "MKCAttachmentsViewInterface.h"
#import "VKPost.h"


@interface MKCAttachmentsPresenter : NSObject <MKCAttachmentsModuleInterface>

@property (nonatomic, strong) UIViewController<MKCAttachmentsViewInterface> *userInterface;

- (instancetype)initWithPost:(VKPost *)post;
- (void)configurePresenterWithUserInterface:(UIViewController<MKCAttachmentsViewInterface> *) userInterface;

@end
