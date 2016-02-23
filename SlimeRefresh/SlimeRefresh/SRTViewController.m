//
//  SRTViewController.m
//  SlimeRefresh
//
//  Created by zrz on 12-6-15.
//  Copyright (c) 2012年 zrz. All rights reserved.
//

#import "SRTViewController.h"
#import "SRRefreshView.h"

@interface SRTViewController ()
<UITableViewDelegate, SRRefreshDelegate, MenuBaseViewDelegate>

@property (nonatomic, strong) MenuBaseView *menuView;

@end

@implementation SRTViewController {
    SRRefreshView   *_slimeView;
    UITableView     *_tableView;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"SlimeRefresh";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self addRefresh];
    
    [self addMenuView];
}


- (void)addMenuView {
    
    CGRect frame = CGRectMake(0, _tableView.frame.origin.y, _tableView.frame.size.width, _tableView.frame.size.height);
    self.menuView = [MenuBaseView getMenuViewWithFrame:frame  delegate:self];
    self.menuView.alpha = 0;
    [self.view addSubview:self.menuView];
}

- (void)addRefresh {
    
    CGRect bounds = self.view.bounds;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, bounds.size.width, bounds.size.height)];
    bounds.size.height += 1;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    _slimeView = [[SRRefreshView alloc] init];
    _slimeView.delegate = self;
    _slimeView.slimeMissWhenGoingBack = YES;
    _slimeView.slime.bodyColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    _slimeView.slime.skinColor = _slimeView.slime.bodyColor;
    _slimeView.slime.lineWith = 0;
    _slimeView.slime.shadowBlur = 0;
    _slimeView.slime.shadowColor = _slimeView.slime.bodyColor;
    _slimeView.supportMenu = YES;
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, bounds.size.width, 40)];
    headerView.backgroundColor = [UIColor redColor];
    _tableView.tableHeaderView = headerView;
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth| UIViewAutoresizingFlexibleHeight;
    [_tableView addSubview:_slimeView];
    _tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    [_slimeView update:64];

}

#pragma mark - scrollView delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_slimeView scrollViewDidScroll];
    
    self.menuView.frame = CGRectMake(0, _tableView.frame.origin.y + fabs(scrollView.contentOffset.y), self.menuView.frame.size.width, self.menuView.frame.size.height);
    
    if (scrollView.contentOffset.y < - (_slimeView.upInset + 5)) {
        self.menuView.alpha = 1 * ((fabs(scrollView.contentOffset.y)-(_slimeView.upInset + 10))/10);
    }else {
        [UIView animateWithDuration:0.3 animations:^{
            self.menuView.alpha = 0;
        }];
    }

    if (scrollView.contentOffset.y <= - (132+_slimeView.upInset) && _slimeView.showMenu==YES) {
        self.menuView.cancelBtn.hidden = NO;
        self.menuView.frame = CGRectMake(0, _tableView.frame.origin.y + (132+_slimeView.upInset), self.menuView.frame.size.width, self.menuView.frame.size.height);
    }else {
        self.menuView.cancelBtn.hidden = YES;
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [_slimeView scrollViewDidEndDraging];
}

#pragma mark - slimeRefresh delegate

- (void)slimeRefreshStartRefresh:(SRRefreshView *)refreshView
{
    [_slimeView performSelector:@selector(endRefresh)
                     withObject:nil afterDelay:1
                        inModes:[NSArray arrayWithObject:NSRunLoopCommonModes]];
}

#pragma mark - MenuBaseViewDelegate

-(void)menuBaseView:(id)menuView cancelBtnClicked:(UIButton *)btn
{
    [_slimeView endRefresh];
}

@end
