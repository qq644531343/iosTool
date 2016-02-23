//
//  SRTViewController.m
//  SlimeRefresh
//
//  Created by zrz on 12-6-15.
//  Copyright (c) 2012年 zrz. All rights reserved.
//

#import "SRTViewController.h"
#import "SRRefreshView.h"
#import "FXBlurView.h"

@interface SRTViewController ()
<UITableViewDelegate, UITableViewDataSource, SRRefreshDelegate, MenuBaseViewDelegate>

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
    self.menuView = [MenuBaseView getMenuViewWithFrame:frame parentView:self.view delegate:self];
}

- (void)addRefresh {
    
    CGRect bounds = self.view.bounds;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, bounds.size.width, bounds.size.height)];
    bounds.size.height += 1;
    _tableView.delegate = self;
    _tableView.dataSource = self;
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
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, bounds.size.width, 0)];
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
    
    [self.menuView changeFrame:CGRectMake(0, _tableView.frame.origin.y + fabs(scrollView.contentOffset.y), self.menuView.frame.size.width, self.menuView.frame.size.height)];
    
    if (scrollView.contentOffset.y < - (_slimeView.upInset + 5)) {
        float alpha = 1 * ((fabs(scrollView.contentOffset.y)-(_slimeView.upInset + 10))/10);
        [self.menuView changeAlpha:alpha];
       
        [self setNavigationBarAlpha:1-self.menuView.alpha];
    }else {
        [UIView animateWithDuration:0.3 animations:^{
            [self.menuView changeAlpha:0];
            [self setNavigationBarAlpha:1];
        }];
    }

    if (scrollView.contentOffset.y <= - (132+_slimeView.upInset) && _slimeView.showMenu==YES) {
        self.menuView.cancelBtn.hidden = NO;
        [self.menuView changeFrame:CGRectMake(0, _tableView.frame.origin.y + (132+_slimeView.upInset), self.menuView.frame.size.width, self.menuView.frame.size.height)];
    }else {
        self.menuView.cancelBtn.hidden = YES;
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [_slimeView scrollViewDidEndDraging];
}

- (void)setNavigationBarAlpha:(float)alpha {
    self.navigationController.navigationBar.alpha = alpha;
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

#pragma mark - 

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 30;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.textLabel.text = @"喝咯，沙发舒服防守打法";
    return cell;
}

@end
