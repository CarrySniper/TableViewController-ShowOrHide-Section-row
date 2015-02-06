//
//  ViewController.m
//  TableViewController点击展开收缩Section
//
//  Created by 陈家庆 on 15-2-6.
//  Copyright (c) 2015年 shikee_Chan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.barTintColor = [UIColor orangeColor];//不能放init处
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationItem.title = @"点击section展开收缩row";
    
    //1.定义全局tableView
    
    //2.初始化_tableView
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    //3.设置代理，头文件也要包含 UITableViewDelegate,UITableViewDataSource
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    //4.添加_tableView
    [self.view addSubview:self.tableView];
    
    
    self.tableView.tableFooterView = [[UIView alloc]init];
    _sectionArray = [NSArray arrayWithObjects:@"好友",@"家人",@"朋友",@"同学",@"陌生人",@"黑名单", nil];
    
    _rowArray = [NSArray arrayWithObjects:@"aaaa",@"aaaa",@"aaaa",@"aaaa",@"aaaa", nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [_sectionArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_rowArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"这个自己命名，最好一个工程里面的不要有相同的"];
    if(cell==NULL){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"这个自己命名，最好一个工程里面的不要有相同的"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.separatorInset=UIEdgeInsetsZero;
        cell.clipsToBounds = YES;
    }
    cell.textLabel.text = [NSString stringWithFormat:@"第 %ld 行",indexPath.row];
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([_showDic objectForKey:[NSString stringWithFormat:@"%ld",indexPath.section]]) {
        return 44;
    }
    return 0;
}
//section头部高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
//section头部显示的内容
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
    header.backgroundColor = [UIColor purpleColor];
    
    
    UILabel *myLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 300, 20)];
    myLabel.text = [NSString stringWithFormat:@"分组--第 %ld 组  名称：%@",section,_sectionArray[section]];
    myLabel.textColor = [UIColor whiteColor];
    [header addSubview:myLabel];
    
    
    // 单击的 Recognizer ,收缩分组cell
    header.tag = section;
    
    UITapGestureRecognizer *singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(SingleTap:)];
    singleRecognizer.numberOfTapsRequired = 1; //点击的次数 =1:单击
    [singleRecognizer setNumberOfTouchesRequired:1];//1个手指操作
    [header addGestureRecognizer:singleRecognizer];//添加一个手势监测；
    
    return header;
}

#pragma mark 展开收缩section中cell 手势监听
-(void)SingleTap:(UITapGestureRecognizer*)recognizer{
    NSInteger didSection = recognizer.view.tag;
    
    if (!_showDic) {
        _showDic = [[NSMutableDictionary alloc]init];
    }
    
    NSString *key = [NSString stringWithFormat:@"%ld",didSection];
    if (![_showDic objectForKey:key]) {
        [_showDic setObject:@"1" forKey:key];
        
    }else{
        [_showDic removeObjectForKey:key];
    }
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:didSection] withRowAnimation:UITableViewRowAnimationFade];
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
