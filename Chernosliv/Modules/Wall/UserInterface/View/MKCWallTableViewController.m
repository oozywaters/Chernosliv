//
//  WallTableViewController.m
//  Chernosliv
//
//  Created by Vacheslav Zavertanny on 14.07.15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import "MKCWallTableViewController.h"
#import "VKPost.h"
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


@end

@implementation MKCWallTableViewController

//- (instancetype)initWithViewModel:(WallViewModel *)viewModel {
//    self = [super init];
//    if (self) {
//        _viewModel = viewModel;
//    }
//    return self;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    [self.refreshControl addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];
    
    UINib *nib = [UINib nibWithNibName:@"PostTableViewCell" bundle:nil];
    _bindingHelper = [TableViewBindingHelper bindingHelperForTableView:self.tableView
                                                          sourceSignal:RACObserve(self, posts)
                                                      selectionCommand:nil
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

- (void)postTableViewCellAttachmentsTapped:(UITableViewCell *)cell {
    _currentCell = (PostTableViewCell *)cell;
    NSLog(@"Current cell: %@", self.currentCell);
}

# pragma mark - MKCWallViewInterface

- (void)updateDataSource:(ObservableMutableArray *)dataSource {
    self.posts = dataSource;
}

@end