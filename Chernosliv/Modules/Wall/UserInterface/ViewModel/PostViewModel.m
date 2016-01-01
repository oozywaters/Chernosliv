//
//  PostViewModel.m
//  Chernosliv
//
//  Created by Vacheslav Zavertanny on 29.07.15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import "PostViewModel.h"
//#import "VKPhotoMTL.h"
#import "VKAttachment.h"
//#import "AttachmentsViewModel.h"

@interface PostViewModel ()

@property (nonatomic) CGFloat viewHeight;

@end

@implementation PostViewModel

- (instancetype)initWithPost:(MKCVKPost *)post {
    self = [super init];
    if (self) {
        _post = post;
        [self initialize];
    }
    return self;
}

- (void)initialize {
    _postId = self.post.postId;
    
    if (![self.post.text isEqualToString:@""]) {
        _postText = self.post.text;
    }
    
    RAC(self, isUserLikes) = RACObserve(self.post, isUserLikes);
    RAC(self, likesCount) = [RACObserve(self.post, likesCount) map:^id(NSNumber *newValue) {
        return [newValue stringValue];
    }];
    
    RAC(self, isUserReposted) = RACObserve(self.post, isUserReposted);
    RAC(self, repostsCount) = [RACObserve(self.post, repostsCount) map:^id(NSNumber *newValue) {
        return [newValue stringValue];
    }];
    
//    _likesCount = [self.post.likesCount stringValue];
    _commentsCount = [self.post.commentsCount stringValue];
//    _repostsCount = [self.post.repostsCount stringValue];
    
    _imageWidth = _imageHeight = 0.0;
    
    if (self.post.attachments) {
        VKAttachment *thumbnailPhoto = [self.post.attachments firstObject];
        _imageURL = thumbnailPhoto.url;
        _imageWidth = thumbnailPhoto.size.width;
        _imageHeight = thumbnailPhoto.size.height;
    }
//
    _attachmentsCount = self.post.attachments.count;
    
    MKCVKOwner *owner = self.post.postOwner;
//    NSLog(@"Post owner: %@", owner);
    _authorName = owner.name;
    _authorImageURL = owner.avatar;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"RU_ru"]];
    dateFormatter.dateFormat = @"dd MMMM yyyy в HH:mm";
    _postDate = [dateFormatter stringFromDate:self.post.date];
}

- (void)likePostWithResult:(void (^)(NSNumber *))completionBlock {
    [self.eventHandler addLikeToPost:self.post withResult:completionBlock];
}

- (void)copyPost {
    [self.eventHandler copyWithPost:self.post];
}

- (void)viewComments {
    [self.eventHandler viewCommentsWithModel:self];
}

- (void)viewAttachments {
    [self.eventHandler viewAttachmentsWithModel:self];
}

- (CGFloat)calculateViewHeightForWidth:(CGFloat)width {
    if (self.viewHeight) {
        return self.viewHeight;
    }
    
    CGFloat topPadding = 15.0;
    CGFloat avatarHeight = 50.0;
    CGFloat leftPadding = 15.0;
    CGFloat rightPadding = 15.0;
    
    CGFloat buttonsHeight = 52.0;
    
    // Calculate label height
    CGFloat textTopMargin = 0.0;
    CGFloat textHeight = 0.0;
    CGFloat textWidth = width - leftPadding - rightPadding;
    
    if (self.postText) {
        textTopMargin = 15.0;
        UIFont *labelFont = [UIFont systemFontOfSize:17.0];
        UILabel *postTextLabel = [[UILabel alloc] init];
        [postTextLabel setText:self.postText];
        [postTextLabel setFont:labelFont];
        
        
        CGFloat maximumLabelHeight = labelFont.lineHeight * 6;
        
        CGSize boundingBox = [postTextLabel an_textContentSizeConstrainedToWidth:textWidth];
        
        if (boundingBox.height > maximumLabelHeight) {
            textHeight = maximumLabelHeight;
        } else {
            textHeight = boundingBox.height;
        }
    }
    
   
    CGFloat imagePaddingLeft = 15.0;
    CGFloat imagePaddingRight = 15.0;
    CGFloat imageWidth = width - (imagePaddingLeft + imagePaddingRight);
    CGFloat imageHeight = 0.0;
    CGFloat imageTopMargin = 0.0;
//    CGFloat imageBottomMargin = 0.0;
    
    if (self.post.attachments && [self.post.attachments count] != 0) {
        CGFloat imageAspectRatio = self.imageWidth / self.imageHeight;
//        imageBottomMargin = 12.0;
        imageHeight = ceil(imageWidth / imageAspectRatio);
        imageTopMargin = 15.0;
    }
    
//    CGFloat result = topPadding + avatarHeight + avatarBottomMargin + labelHeight + labelBottomMargin + imageHeight + buttonsHeight;
    CGFloat result = topPadding + avatarHeight + textTopMargin + textHeight + imageTopMargin + imageHeight + buttonsHeight;
    
    self.viewHeight = result;
    
    return self.viewHeight;
}

@end
