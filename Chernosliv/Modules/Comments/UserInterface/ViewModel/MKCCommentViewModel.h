//
//  MKCCommentViewModel.h
//  Chernosliv
//
//  Created by Vyacheslav Zavertanny on 23/09/15.
//  Copyright © 2015 Vyacheslav Zavertanny. All rights reserved.
//

@protocol MKCCommentsModuleInterface;
@class MKCVKComment;

@interface MKCCommentViewModel : NSObject

@property (nonatomic, strong, readonly) NSString *authorName;
@property (nonatomic, strong, readonly) NSURL *authorImageURL;
@property (nonatomic, strong, readonly) NSString *commentText;

@property (nonatomic, weak) id<MKCCommentsModuleInterface> eventHandler;

+ (instancetype)viewModelWithComment:(MKCVKComment *)comment;
- (instancetype)initWithModel:(MKCVKComment *)comment;

@end
