//
//  WallTableViewController.m
//  Chernosliv
//
//  Created by Vacheslav Zavertanny on 14.07.15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import "WallTableViewController.h"
#import "PostTableViewCell.h"
#import "WallViewModel.h"
#import "VKPost.h"
#import "VKPhotoMTL.h"
#import "TableViewBindingHelper.h"
#import <SVPullToRefresh/SVPullToRefresh.h>
#import "AttachmentsViewController.h"
#import "AttachmentsViewModel.h"

@interface WallTableViewController ()

@property (nonatomic, strong) WallViewModel *viewModel;
@property (nonatomic, strong) ObservableMutableArray *someArray;

@property (nonatomic, strong) TableViewBindingHelper *bindingHelper;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *attachmentsTapGestureRecognizer;

@property (nonatomic, strong) NSArray *imagesArray;


@end

@implementation WallTableViewController

- (instancetype)initWithViewModel:(WallViewModel *)viewModel {
    self = [super init];
    if (self) {
        _viewModel = viewModel;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.tableView addSubview:self.refreshControl];
    
//    [self.refreshControl addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];
    
    self.refreshControl.rac_command = [self.viewModel loadNextPage];
    
    UINib *nib = [UINib nibWithNibName:@"PostTableViewCell" bundle:nil];
    _bindingHelper = [TableViewBindingHelper bindingHelperForTableView:self.tableView
                                                          sourceSignal:RACObserve(self.viewModel, posts)
                                                      selectionCommand:[self.viewModel viewComments]
                                                          templateCell:nib];
    _bindingHelper.delegate = self;
    
    // Infinite scroll functionality
    @weakify(self)
    [self.tableView addInfiniteScrollingWithActionHandler:^{
        @strongify(self)
        [[[self.viewModel loadNextPage] execute:nil] subscribeCompleted:^{
            [self.tableView.infiniteScrollingView stopAnimating];
        }];
    }];
    
    
//    [[self.attachmentsTapGestureRecognizer rac_gestureSignal] subscribeNext:^(UITapGestureRecognizer *recognizer) {
//        NSLog(@"%@", recognizer.view);
//    }];
    
}

- (IBAction)cellAttachmentsTapped:(id)sender {
    
    NSLog(@"Hi");
    
    CGPoint location = [sender locationInView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:location];
    NSLog(@"indexPath: %@", indexPath);
    
    NSMutableArray *imagesMutableArray = [NSMutableArray array];
    VKPost *post = self.viewModel.posts[indexPath.row];
    for (int i = 0; i < post.attachments.count; i++) {
        VKPhotoMTL *p = post.attachments[i];
        if (p && [p isKindOfClass:[VKPhotoMTL class]]) {
            [imagesMutableArray addObject:p];
        }
    }
    
    self.imagesArray = [NSArray arrayWithArray:imagesMutableArray];
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"Attachments"]) {
        
        CGPoint location = [sender locationInView:self.tableView];
        NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:location];
        
        NSMutableArray *imagesMutableArray = [NSMutableArray array];
        VKPost *post = self.viewModel.posts[indexPath.row];
        for (int i = 0; i < post.attachments.count; i++) {
            VKPhotoMTL *p = post.attachments[i];
            if (p && [p isKindOfClass:[VKPhotoMTL class]]) {
                [imagesMutableArray addObject:p];
            }
        }
        
        self.imagesArray = [NSArray arrayWithArray:imagesMutableArray];

        
//        AttachmentsViewController *avc =
        
//        AttachmentsViewModel *avm = [[AttachmentsViewModel alloc] init];
//        avm.attachments = self.imagesArray;
//        AttachmentsViewController *avc = [[AttachmentsViewController alloc] initWithViewModel:avm];
    }
}

@end