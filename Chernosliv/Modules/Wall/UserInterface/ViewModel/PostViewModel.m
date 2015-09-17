//
//  PostViewModel.m
//  Chernosliv
//
//  Created by Vacheslav Zavertanny on 29.07.15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import "PostViewModel.h"
#import "VKPhotoMTL.h"
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
    
    _likesCount = self.post.likesCount;
    _commentsCount = self.post.commentsCount;
    _repostsCount = self.post.repostsCount;
    
    _imageWidth = _imageHeight = 0.0;
    
    if (self.post.attachments) {
        VKPhotoMTL *thumbnailPhoto = [self.post.attachments firstObject];
        _imageURL = thumbnailPhoto.url;
        _imageWidth = thumbnailPhoto.size.width;
        _imageHeight = thumbnailPhoto.size.height;
    }
//
    _attachmentsCount = self.post.attachments.count;
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
    
    CGFloat topPadding = 12.0;
    CGFloat leftPadding = 12.0;
    CGFloat rightPadding = 12.0;
    CGFloat bottomPadding = 12.0;
    
    CGFloat buttonsHeight = 22.0;
    
    // Calculate label height
    CGFloat labelHeight = 0.0;
    CGFloat labelWidth = width - leftPadding - rightPadding;
    CGFloat labelBottomMargin = 0.0;
    if (self.postText) {
        UIFont *labelFont = [UIFont fontWithName:@"HelveticaNeue" size:16.0];
        CGSize maximumLabelSize = CGSizeMake(labelWidth, FLT_MAX);
        
        CGFloat maximumLabelHeight = labelFont.lineHeight * 6;
        CGSize boundingBox = [self.postText boundingRectWithSize:maximumLabelSize
                                                         options:NSStringDrawingUsesLineFragmentOrigin
                                                      attributes:@{NSFontAttributeName: labelFont}
                                                         context:nil].size;
        
        if (boundingBox.height > maximumLabelHeight) {
            labelHeight = maximumLabelHeight;
        } else {
            labelHeight = boundingBox.height;
        }
        labelBottomMargin = 12.0;
    }
    
   
    CGFloat imagePaddingLeft = 12.0;
    CGFloat imagePaddingRight = 12.0;
    CGFloat imageWidth = width - (imagePaddingLeft + imagePaddingRight);
    CGFloat imageHeight = 0.0;
    CGFloat imageBottomMargin = 0.0;
    
    if (self.post.attachments) {
        CGFloat imageAspectRatio = self.imageWidth / self.imageHeight;
        imageBottomMargin = 12.0;
        imageHeight = imageWidth / imageAspectRatio;
    }
    
    CGFloat result = topPadding + labelHeight + labelBottomMargin + imageHeight + imageBottomMargin + buttonsHeight + bottomPadding + 0.5;
    
    self.viewHeight = result;
    
    return self.viewHeight;
}

@end
