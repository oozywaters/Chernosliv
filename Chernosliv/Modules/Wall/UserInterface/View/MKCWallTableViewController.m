//
//  WallTableViewController.m
//  Chernosliv
//
//  Created by Vacheslav Zavertanny on 14.07.15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import "MKCWallTableViewController.h"
#import "PostViewModel.h"
//#import "VKPost.h"
#import "VKPhotoMTL.h"
#import "TableViewBindingHelper.h"
#import <SVPullToRefresh/SVPullToRefresh.h>
#import "MKCAttachmentsViewController.h"

@interface MKCWallTableViewController () <PostTableViewCellDelegate>

//@property (nonatomic, strong) WallViewModel *viewModel;
@property (nonatomic, strong) ObservableMutableArray *posts;

@property (nonatomic, strong) TableViewBindingHelper *bindingHelper;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *attachmentsTapGestureRecognizer;

@property (nonatomic, strong) NSArray *imagesArray;
@property (nonatomic, strong) RACCommand *postSelectedCommand;


@end

@implementation MKCWallTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    [self.refreshControl addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];
    
    UINib *nib = [UINib nibWithNibName:@"PostTableViewCell" bundle:nil];
    
    self.postSelectedCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(PostViewModel *viewModel) {
        [viewModel showComments];
        return [RACSignal empty];
    }];
    
    _bindingHelper = [TableViewBindingHelper bindingHelperForTableView:self.tableView
                                                          sourceSignal:RACObserve(self, posts)
                                                      selectionCommand:self.postSelectedCommand
                                                          templateCell:nib];
    _bindingHelper.delegate = self;
    
    // Infinite scroll functionality
    @weakify(self)
    [self.tableView addInfiniteScrollingWithActionHandler:^{
        @strongify(self)
        [self.eventHandler loadNextPage];
//        [[[self.viewModel loadNextPage] execute:nil] subscribeCompleted:^{
//            [self.tableView.infiniteScrollingView stopAnimating];
//        }];
    }];
    
    
    //    [[self.attachmentsTapGestureRecognizer rac_gestureSignal] subscribeNext:^(UITapGestureRecognizer *recognizer) {
    //        NSLog(@"%@", recognizer.view);
    //    }];
    
}

- (void)pageLoaded {
    [self.tableView.infiniteScrollingView stopAnimating];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 44;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //    return 300;
    return UITableViewAutomaticDimension;
}

# pragma mark - PostTableViewCellDelegate

- (void)postTableViewCellAttachmentsTapped:(UITableViewCell *)cell {
    _currentCell = (PostTableViewCell *)cell;
}

- (void)postTableViewCellCommentsTapped:(UITableViewCell *)cell {
    _currentCell = (PostTableViewCell *)cell;
}

# pragma mark - MKCWallViewInterface

- (void)updateDataSource:(ObservableMutableArray *)dataSource {
    self.posts = dataSource;
}

@end