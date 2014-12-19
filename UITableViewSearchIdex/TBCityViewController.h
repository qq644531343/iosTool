//
//  TBCityViewController.h
//  teambuild
//
//  Created by libo on 12/17/14.
//  Copyright (c) 2014 sina. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TBCityViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>

@property (strong, nonatomic) UITableView *tableview;

@end
