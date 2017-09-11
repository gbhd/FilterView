//
//  ViewController.m
//  FilterView
//
//  Created by soso-mac on 2016/12/15.
//  Copyright © 2016年 soso-mac. All rights reserved.
//

#import "ViewController.h"
#import "STListFilterView.h"
@interface ViewController ()<STListFilterViewDelegate>
@property(strong,nonatomic)STListFilterView *filterView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    _filterView = [[STListFilterView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64)];
    _filterView.delegate = self;
    [self.view addSubview:_filterView];
}

-(void)g_setSelecetFilter:(id)result{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
