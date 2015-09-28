//
//  MKCWallPresenter.h
//  Chernosliv
//
//  Created by Vyacheslav Zavertanny on 19/08/15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import "MKCWallWireframe.h"
#import "MKCWallModuleInterface.h"
#import "MKCWallModuleDelegate.h"

#import "MKCWallInteractorIO.h"

#import "ObservableMutableArray.h"

@protocol MKCWallViewInterface;

@interface MKCWallPresenter : NSObject <MKCWallModuleInterface, MKCWallInteractorOutput>

@property (nonatomic, strong) MKCWallWireframe *wireframe;
@property (nonatomic, strong) id<MKCWallInteractorInput> interactor;

@property (nonatomic, strong) RACSignal *pageLoadingSignal;

- (void)configurePresenterWithUserInterface:(UIViewController<MKCWallViewInterface>*)userInterface;
//- (void)loadNextPageWithCompletionHandler:(void(^)(void))completion;

@end
