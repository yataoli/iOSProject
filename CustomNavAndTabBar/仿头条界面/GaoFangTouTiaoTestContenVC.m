//
//  GaoFangTouTiaoTestContenVC.m
//  CustomNavAndTabBar
//
//  Created by yatao li on 2018/7/3.
//  Copyright © 2018年 李亚涛. All rights reserved.
//

#import "GaoFangTouTiaoTestContenVC.h"

@interface GaoFangTouTiaoTestContenVC ()

@end

@implementation GaoFangTouTiaoTestContenVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    switch (self.index) {
        case 0:
            self.view.backgroundColor = [UIColor redColor];
            break;
        case 1:
            self.view.backgroundColor = [UIColor greenColor];
            break;
        case 2:
            self.view.backgroundColor = [UIColor orangeColor];
            break;
        case 3:
            self.view.backgroundColor = [UIColor purpleColor];
            break;
        case 4:
            self.view.backgroundColor = [UIColor yellowColor];
            break;
        case 5:
            self.view.backgroundColor = [UIColor whiteColor];
            break;
        case 6:
            self.view.backgroundColor = [UIColor brownColor];
            break;
            
        default:
            self.view.backgroundColor = [UIColor whiteColor];
            break;
    }
    
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
