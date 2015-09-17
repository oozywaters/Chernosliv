//
//  PostTableViewCell.h
//  Chernosliv
//
//  Created by Vacheslav Zavertanny on 14.07.15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import <ANTableViews/ANTableViewCell.h>
#import "ReactiveView.h"

@interface PostTableViewCell : ANTableViewCell <ReactiveView>

@property (weak, nonatomic) IBOutlet UIImageView *postImage;

@end
