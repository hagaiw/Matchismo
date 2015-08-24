//
//  Card.m
//  Matchismo
//
//  Created by Hagai Weinfeld on 8/17/15.
//  Copyright (c) 2015 Lightricks Ltd. All rights reserved.
//

#import "Card.h"

@interface Card()

@end


@implementation Card

- (int)match:(NSArray *)otherCards
{
    return 0;
}

- (void)reset
{
    _chosen = NO;
    _matched = NO;
}

@end
