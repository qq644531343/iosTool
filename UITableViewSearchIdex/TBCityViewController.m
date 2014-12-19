//
//  TBCityViewController.m
//  teambuild
//
//  Created by libo on 12/17/14.
//  Copyright (c) 2014 sina. All rights reserved.
//

#import "TBCityViewController.h"

@interface TBCityViewController ()
{
    NSMutableArray *indexsArray;
    NSMutableDictionary *allInfoDic;
    
    NSMutableArray *indexSearchArray;
    NSMutableDictionary *searchInfoDic;

    UISearchBar *searchbar;
    UISearchDisplayController *searchDisplayController;
}

@end

@implementation TBCityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect frame = self.view.frame;
    if ([[UIDevice currentDevice].systemVersion floatValue] < 8.0) {
        frame = CGRectMake(0, 64, self.view.width, self.view.height - 64);
    }
    _tableview = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    [self.view addSubview:_tableview];
    
    searchbar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 44)];
    searchbar.delegate = self;
    [searchbar setPlaceholder:@"搜索城市"];
    _tableview.tableHeaderView = searchbar;
    
    searchDisplayController = [[UISearchDisplayController alloc]initWithSearchBar:searchbar contentsController:self];
    searchDisplayController.active = NO;
    searchDisplayController.searchResultsDataSource = self;
    searchDisplayController.searchResultsDelegate = self;
    

    //改变索引的颜色
    self.tableview.sectionIndexColor = [UIColor colorWithARGB:0xff6f60];
    //改变索引选中的背景颜色
    self.tableview.sectionIndexBackgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    
    //初始化数据
    [self loadData];
    
}

-(void)loadData
{
    indexsArray = [[NSMutableArray alloc] init];
    indexSearchArray = [[NSMutableArray alloc] init];
    searchInfoDic = [[NSMutableDictionary alloc]init];
    
    allInfoDic = [[NSMutableDictionary alloc] init];
    NSArray *city = [NSArray arrayWithObjects:@"北海",@"北京",@"北太平洋", nil];
    [allInfoDic setObject:city forKey:@"b"];
    city = [NSArray arrayWithObjects:@"阿富汗",@"阿波特", nil];
    [allInfoDic setObject:city forKey:@"a"];
    
    city = [NSArray arrayWithObjects:@"cc阿富汗",@"c阿波特", nil];
    [allInfoDic setObject:city forKey:@"c"];
    city = [NSArray arrayWithObjects:@"d阿富汗",@"d阿波特", nil];
    [allInfoDic setObject:city forKey:@"d"];
    city = [NSArray arrayWithObjects:@"e阿富汗",@"e阿波特", nil];
    [allInfoDic setObject:city forKey:@"e"];
    city = [NSArray arrayWithObjects:@"f阿富汗",@"f阿波特", nil];
    [allInfoDic setObject:city forKey:@"f"];
    
    [indexsArray addObjectsFromArray:[allInfoDic.allKeys sortedArrayUsingSelector:@selector(compare:)]];

}

#pragma mark - UITableViewDelegate/Datasource

//返回section的个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [indexSearchArray count];
    }
    else {
        return [indexsArray count];
    }

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        NSString *index = [indexSearchArray objectAtIndex:section];
        return [(NSArray *)[searchInfoDic objectForKey:index] count];
    }
    else {
        NSString *index = [indexsArray objectAtIndex:section];
        return [(NSArray *)[allInfoDic objectForKey:index] count];
    }

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        NSString *index = [indexSearchArray objectAtIndex:indexPath.section];
        NSArray *cities = (NSArray *)[searchInfoDic objectForKey:index];
        cell.textLabel.text = (NSString *)[cities objectAtIndex:indexPath.row];
    }
    else {
        NSString *index = [indexsArray objectAtIndex:indexPath.section];
        NSArray *cities = (NSArray *)[allInfoDic objectForKey:index];
        cell.textLabel.text = (NSString *)[cities objectAtIndex:indexPath.row];
    }

    return cell;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (tableView == self.searchDisplayController.searchResultsTableView){
        
    }else {
       
    }

}

//返回索引数组
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if (tableView == self.searchDisplayController.searchResultsTableView){
        return indexSearchArray;
    }else {
         return indexsArray;
    }
}

//响应点击索引时的委托方法
-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    NSInteger count = 0;
//    NSLog(@"%@-%ld",title,(long)index);
    for(NSString *character in indexsArray)
    {
        if([character isEqualToString:title])
        {
            return count;
        }
        count ++;
    }
    return 0;
}

//返回每个索引的内容
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView){
        return [indexSearchArray objectAtIndex:section];
    }else {
         return [indexsArray objectAtIndex:section];
    }
}

#pragma UISearchDisplayDelegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    [searchInfoDic removeAllObjects];
    [indexSearchArray removeAllObjects];
    
    //输入索引符号
    NSUInteger index = [indexsArray indexOfObject:[searchText lowercaseString]];
    if (index != NSNotFound) {
        NSArray *data = (NSArray *)[allInfoDic objectForKey:[searchText lowercaseString]];
        [searchInfoDic setObject:data forKey:searchText];
        [indexSearchArray addObject:[searchText lowercaseString]];
        return;
    }else{
        //输入城市名或其他
        for (NSString *indexStr in allInfoDic.allKeys) {
            NSArray *array = [allInfoDic objectForKey:indexStr];
            NSMutableArray *data = [[NSMutableArray alloc] init];
            for (NSString *str in array) {
                if ([str containsString:[searchText lowercaseString]]) {
                    [data addObject:str];
                }
            }
            if ([data count] > 0) {
                [searchInfoDic setObject:data forKey:indexStr];
                [indexSearchArray addObject:[indexStr lowercaseString]];
            }
        }
    }
    
    
}

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    
    //更改cancel为取消
    searchBar.showsCancelButton=YES;
    for(id cc in [searchBar subviews])
    {
        for(id c2 in [cc subviews])
        {
            if([c2 isKindOfClass:[UIButton class]])
            {
                UIButton *sbtn = (UIButton *)c2;
                [sbtn setTitle:@"取消"  forState:UIControlStateNormal];
            }
        }
    }
}

#pragma mark - Other
-(IBAction)backToParentVC:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)dealloc
{
    XLog(@"");
}

@end
