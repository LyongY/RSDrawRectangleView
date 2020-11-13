//
//  ViewController.m
//  RSDrawRectangleView
//
//  Created by Raysharp666 on 2020/11/12.
//  Copyright © 2020 LyongY. All rights reserved.
//

#import "ViewController.h"
#import "RSDrawRectangleView.h"

@interface ViewController ()
@property (nonatomic, strong) RSDrawRectangleView *drawView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)viewDidAppear:(BOOL)animated {
    
    _drawView = [[RSDrawRectangleView alloc] initWithMaxCount:3 colors:@[UIColor.redColor, UIColor.blueColor/*, UIColor.greenColor*/]];
    _drawView.frame = CGRectMake(30, 40, 300, 700);
    _drawView.backgroundColor = UIColor.lightGrayColor;
    [self.view addSubview:_drawView];
    
//    RSRectangle *rectangle = [[RSRectangle alloc] initWithParent:self.view frame:[[RSRectangleData alloc] initWithFrame:CGRectMake(0.2, 0.2, 0.5, 0.3)]];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [_drawView addRectangle:[[RSRectangleData alloc] initWithFrame:CGRectMake(0.2, 0.3, 0.5, 0.5)]];
    
//    [_drawView addRectangles:@[
//        [[RSRectangleData alloc] initWithFrame:CGRectMake(0.0, 0.2, 0.1, 0.3)],
//        [[RSRectangleData alloc] initWithFrame:CGRectMake(0.7, 0.8, 0.3, 0.3)]
//    ]];
}

@end
