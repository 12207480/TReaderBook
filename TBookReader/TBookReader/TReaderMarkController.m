//
//  TReaderMarkController.m
//  TBookReader
//
//  Created by tanyang on 16/2/2.
//  Copyright © 2016年 Tany. All rights reserved.
//

#import "TReaderMarkController.h"
#import "TReaderMark.h"

@interface TReaderMarkController () <UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *markArray;
@end

@implementation TReaderMarkController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"书签";
    
    [self addTableView];
    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellId"];
    
    [self getAllMarksWithBookId:_bookId];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewWillLayoutSubviews
{
    self.tableView.frame = self.view.bounds;
}

- (void)addTableView
{
    UITableView *tableView = [[UITableView alloc]init];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:tableView];
    _tableView = tableView;
}

- (void)getAllMarksWithBookId:(NSInteger)bookId
{
    dispatch_async(dispatch_queue_create("com.tany.searchMarkDb", DISPATCH_QUEUE_SERIAL), ^{
        // 异步操作
        NSMutableArray *selectedArray = [TReaderMark dbObjectsWithBookId:bookId];
        dispatch_async(dispatch_get_main_queue(), ^{
            // 主线程更新
            self.markArray = selectedArray;
            [self.tableView reloadData];
        });
    });
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.markArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId" forIndexPath:indexPath];
    cell.textLabel.numberOfLines = 3;
    cell.textLabel.font = [UIFont systemFontOfSize:13];
    TReaderMark *mark = self.markArray[indexPath.row];
    cell.textLabel.text = mark.content;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TReaderMark *mark = self.markArray[indexPath.row];
    if ([_delegate respondsToSelector:@selector(readerMarkController:didSelectedMark:)]) {
        [_delegate readerMarkController:self didSelectedMark:mark];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
