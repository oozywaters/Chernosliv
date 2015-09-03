//
//  MKCCommentsViewController.m
//  Chernosliv
//
//  Created by Vyacheslav Zavertanny on 31/08/15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import "MKCCommentsViewController.h"
#import "MKCCommentsHeaderView.h"
#import "MKCCommentsPostTableViewCell.h"
#import "VKPost.h"
#import "VKAttachment.h"
#import "VKPhotoMTL.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <SDWebImage/UIImage+MultiFormat.h>
#import <Masonry/Masonry.h>

@interface MKCCommentsViewController () <UIScrollViewDelegate>

@property (nonatomic, strong, readonly) NSString *postDetailsCellReuseIdentifier;
@property (nonatomic, strong, readonly) NSString *commentsCellReuseIdentifier;

@property (nonatomic, strong) VKPost *post;

@property (nonatomic, strong, readonly) UIView *headerView;

@property (nonatomic, strong) CAGradientLayer *gradient;

@end

static const CGFloat kTableHeaderHeight = 75.0;

@implementation MKCCommentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNeedsStatusBarAppearanceUpdate];
    
    [self setUpHeaderView];
    [self setUpCells];
    
    self.tableView.contentInset = UIEdgeInsetsMake(kTableHeaderHeight, 0, 0, 0);
    self.tableView.contentOffset = CGPointMake(0, -kTableHeaderHeight);
    
    [self updateHeaderView];
//    UIView *view = [UIView new];
//    view.backgroundColor = [UIColor redColor];
//    [self.tableView addSubview:view];
//    
//    [view mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.tableView.mas_top);
//        make.right.equalTo(self.tableView.mas_right);
//        make.left.equalTo(self.tableView.mas_left);
//    }];
//    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)setUpCells {
    UINib *nib = [UINib nibWithNibName:@"MKCCommentsPostTableViewCell" bundle:nil];
    UITableViewCell *templateCell = [[nib instantiateWithOwner:nil options:nil] firstObject];
    _postDetailsCellReuseIdentifier = templateCell.reuseIdentifier;
    [self.tableView registerNib:nib forCellReuseIdentifier:self.postDetailsCellReuseIdentifier];
}

- (void)setUpHeaderView {
    VKPhotoMTL *photo = self.post.attachments[0];
    UIImageView *headerImage = [UIImageView new];
    headerImage.contentMode = UIViewContentModeScaleAspectFill;
    //    [self.headerView addSubview:headerImage];
    //    [headerImage mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.edges.equalTo(self.headerView);
    //    }];
    [headerImage sd_setImageWithURL:photo.url];
    
    
    CGFloat headerWidth = self.tableView.bounds.size.width;
    _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, headerWidth, kTableHeaderHeight)];
    _headerView.clipsToBounds = YES;
//    _headerView.backgroundColor = [UIColor redColor];
//    _headerView = [UIView new];
//    self.tableView.tableHeaderView = _headerView;
    [self.tableView addSubview:self.headerView];
    [_headerView addSubview:headerImage];
    [headerImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.headerView);
    }];
    
    MKCCommentsHeaderView *gradient = [[MKCCommentsHeaderView alloc] initWithFrame:_headerView.frame];
    [_headerView addSubview:gradient];
    [gradient mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.headerView);
    }];
//
    
//    _headerView.backgroundColor = [UIColor redColor];
//    _gradient = [CAGradientLayer layer];
//    _gradient.frame = _headerView.frame;
//    _gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor blackColor] CGColor], (id)[[UIColor clearColor] CGColor], nil];
//    [_headerView.layer addSublayer:_gradient];
//    [_headerView.layer insertSublayer:gradient atIndex:0];
}

- (void)updateHeaderView {
    CGRect headerRect = CGRectMake(0, -kTableHeaderHeight, self.tableView.bounds.size.width, kTableHeaderHeight);
    if (self.tableView.contentOffset.y < -kTableHeaderHeight) {
        headerRect.origin.y = self.tableView.contentOffset.y;
        headerRect.size.height = -self.tableView.contentOffset.y;
    }
    self.headerView.frame = headerRect;
    [self.headerView.layer setNeedsLayout];
//    _gradient.frame = self.headerView.bounds;
//    [self.headerView setNeedsDisplay];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MKCCommentsPostTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.postDetailsCellReuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //    return 300;
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

# pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self updateHeaderView];
}

# pragma mark - MKCCommentsViewInterface

- (void)updateCommentsData:(VKPost *)post {
    self.post = post;
}

@end
