//
//  ViewController.m
//  RSDrawRectangleView
//
//  Created by Raysharp666 on 2020/11/12.
//  Copyright © 2020 LyongY. All rights reserved.
//

#import "ViewController.h"
#import "RSRectangle.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)viewDidAppear:(BOOL)animated {
    RSRectangle *rectangle = [[RSRectangle alloc] initWithParent:self.view frame:[[RSRectangleData alloc] initWithFrame:CGRectMake(0.2, 0.2, 0.5, 0.3)]];
//    RSRectangle *rectangle = [[RSRectangle alloc] initWithParent:self.view frame:CGRectMake(0, 0, 1, 1)];
    NSLog(@"%@", NSStringFromCGRect(rectangle.frame));

}

@end
