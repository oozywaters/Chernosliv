//
//  MKCCommentsPresenter.h
//  Chernosliv
//
//  Created by Vyacheslav Zavertanny on 31/08/15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import "MKCCommentsModuleInterface.h"
#import "MKCCommentsViewInterface.h"
#import "MKCCommentsInteractorIO.h"
#import "VKPost.h"

@interface MKCCommentsPresenter : NSObject <MKCCommentsModuleInterface, MKCCommentsInteractorOutput>

@property (nonatomic, strong) UIViewController<MKCCommentsViewInterface> *userInterface;
@property (nonatomic, strong) id<MKCCommentsInteractorInput> interactor;

- (instancetype)initWithPost:(VKPost *)post;
- (void)configurePresenterWithUserInterface:(UIViewController<MKCCommentsViewInterface> *) userInterface;

@end
