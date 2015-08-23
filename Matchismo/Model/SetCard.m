//
//  SetCard.m
//  Matchismo
//
//  Created by Hagai Weinfeld on 8/20/15.
//  Copyright (c) 2015 Lightricks Ltd. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    
    if([otherCards count] == 1){
        SetCard *otherCard = [otherCards firstObject];
        if (otherCard.color == self.color){
            score += 1;
        } else if (otherCard.number == self.number){
            score += 1;
        } else if (otherCard.alpha == self.alpha){
            score += 1;
        } else if (otherCard.shape == self.shape){
            score += 1;
        }
    }
    return score;
}

- (NSString *)contents
{
    return nil;
}

@end
