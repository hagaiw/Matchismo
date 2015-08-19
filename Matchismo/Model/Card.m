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
    int score = 0;
    for(Card *card in otherCards){
        if([card.contents isEqualToString:self.contents]){
            score = 1;
        }
    }
    
    return score;
}

- (void)reset
{
    _chosen = NO;
    _matched = NO;
}

@end
