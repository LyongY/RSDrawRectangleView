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
    
    _drawView = [[RSDrawRectangleView alloc] initWithMaxCount:3 colors:@[UIColor.grayColor, /*UIColor.blueColor, UIColor.greenColor*/]];
    
    [_drawView addRectangle:[[RSRectangleData alloc] initWithFrame:CGRectMake(0.2, 0.3, 0.5, 0.5)]];

    [_drawView addRectangles:@[
        [[RSRectangleData alloc] initWithFrame:CGRectMake(0.0, 0.2, 0.1, 0.3)],
        [[RSRectangleData alloc] initWithFrame:CGRectMake(0.7, 0.8, 0.3, 0.3)]
    ]];

    _drawView.frame = CGRectMake(30, 40, 300, 700);
    _drawView.backgroundColor = UIColor.lightGrayColor;
    [self.view addSubview:_drawView];
    
    _drawView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraints:@[
        [_drawView.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:50],
        [_drawView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:-20],
        [_drawView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:-50],
        [_drawView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:20]
    ]];
}

- (void)viewDidAppear:(BOOL)animated {
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    for (RSRectangleData *item in [_drawView rectangles]) {
        NSLog(@"%@", item);
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.drawView deleteAll];
    });
}

@end
