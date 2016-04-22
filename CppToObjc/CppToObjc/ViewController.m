//
//  ViewController.m
//  CppToObjc
//
//  Created by Kai Yin on 4/22/16.
//  Copyright © 2016 kky. All rights reserved.
//

#import "ViewController.h"
#import "ObjcClass.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    ObjcClass *objc = [[ObjcClass alloc] init];
    [objc objcMethod];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
