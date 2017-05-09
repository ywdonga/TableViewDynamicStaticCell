//
//  ViewController.m
//  TableViewDynamicStaticCell
//
//  Created by dyw on 2017/5/9.
//  Copyright © 2017年 isoftstone. All rights reserved.
//

#import "ViewController.h"
#import "HobbyCell.h"//爱好cell（动态）

typedef enum : NSUInteger {
    SectionTypeInfo = 0,//基本信息
    SectionTypeHobby,//爱好（动态）
    SectionTypeSecurity,//安全
} SectionType;

@interface ViewController ()

/** 动态cell的数据源 */
@property (nonatomic, strong) NSMutableArray *hobbysArr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    /** 延时添加数据 */
    [self addData];
    
}


- (void)addData{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.hobbysArr addObject:@1];
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:SectionTypeHobby] withRowAnimation:UITableViewRowAnimationNone];
        self.hobbysArr.count>5?[self deleteData]:[self addData];
    });
}

- (void)deleteData{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.hobbysArr removeObjectAtIndex:0];
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:SectionTypeHobby] withRowAnimation:UITableViewRowAnimationNone];
        self.hobbysArr.count>5?[self deleteData]:[self addData];
    });
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(SectionTypeHobby == section){//爱好 （动态cell）
        return self.hobbysArr.count;
    }
    return [super tableView:tableView numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(SectionTypeHobby == indexPath.section){//爱好 （动态cell）
        HobbyCell *cell = [tableView dequeueReusableCellWithIdentifier:HobbyCellID];
        if(!cell){
            cell = [[NSBundle mainBundle] loadNibNamed:HobbyCellID owner:nil options:nil].lastObject;
        }
        return cell;
    }
    return [super tableView:tableView cellForRowAtIndexPath:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(SectionTypeHobby == indexPath.section){//爱好 （动态cell）
        return HobbyCellHeight;
    }
    return [super tableView:tableView heightForRowAtIndexPath:indexPath];
}

- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(SectionTypeHobby == indexPath.section){//爱好 （动态cell）
        return [super tableView:tableView indentationLevelForRowAtIndexPath: [NSIndexPath indexPathForRow:0 inSection:SectionTypeHobby]];
    }
    return [super tableView:tableView indentationLevelForRowAtIndexPath:indexPath];
}


- (NSMutableArray *)hobbysArr{
    if(!_hobbysArr){
        _hobbysArr = [NSMutableArray array];
    }
    return _hobbysArr;
}

@end
