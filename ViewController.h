//
//  ViewController.h
//  TableViewController点击展开收缩Section
//
//  Created by 陈家庆 on 15-2-6.
//  Copyright (c) 2015年 shikee_Chan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>{
    NSArray *_rowArray;
    NSArray *_sectionArray;
    
    NSMutableDictionary *_showDic;//用来判断分组展开与收缩的
}

@property(nonatomic,strong)UITableView *tableView;

@end
