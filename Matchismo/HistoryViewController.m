//
//  HistoryViewController.m
//  Matchismo
//
//  Created by Hagai Weinfeld on 8/23/15.
//  Copyright (c) 2015 Lightricks Ltd. All rights reserved.
//

#import "HistoryViewController.h"

@interface HistoryViewController ()

@property (weak, nonatomic) IBOutlet UITextView *body;

@end

@implementation HistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _body.attributedText = _bodyText;
}

@end
