//  ZPPViewController.m
//  ZPPSafeObject
//  Created by ZPP506 on 05/15/2020.
//  Copyright (c) 2020 ZPP506. All rights reserved.
//

#import "ZPPViewController.h"

@interface ZPPViewController ()

@end

@implementation ZPPViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    id zhang = @"123";
   NSString * S123 = zhang[@"123"];
    [zhang setURL:nil];
   NSLog(@"--%@",S123);

    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
