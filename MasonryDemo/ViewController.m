//
//  ViewController.m
//  MasonryDemo
//
//  Created by luckyCoderCai on 2017/6/17.
//  Copyright © 2017年 luckyCoderCai. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import "MessageCell.h"
#import "MessageModel.h"
#import "YYModel.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *messagesArray;

@end

@implementation ViewController

#pragma mark -懒加载
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor cyanColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = 100;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    self.title = @"VC";
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.messagesArray = [NSMutableArray array];
    
    [self createUI];
    
    [self getMessagesData];
    
}

#pragma mark -模拟网络请求
- (void)getMessagesData
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        //加载本地json数据
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"message" ofType:@"json"];
        NSData *data = [NSData dataWithContentsOfFile:filePath];
        NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];

        NSArray *modelArr = [NSArray yy_modelArrayWithClass:[MessageModel class] json:array];
        
        [_messagesArray addObjectsFromArray:modelArr];
        
        [_tableView reloadData];
        
    });
}

#pragma mark-createUI
- (void)createUI
{
    [self.view addSubview:self.tableView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.and.trailing.equalTo(@0);
        make.top.equalTo(self.mas_topLayoutGuide).mas_offset(15);
        make.bottom.equalTo(self.mas_bottomLayoutGuide);
    }];
    
}

#pragma mark -UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.messagesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *iden = @"messageCell";
    MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:iden];
    if (!cell) {
        cell = [[MessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iden];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.model = self.messagesArray[indexPath.row];
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
