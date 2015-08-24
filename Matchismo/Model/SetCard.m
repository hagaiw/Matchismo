//
//  SetCard.m
//  Matchismo
//
//  Created by Hagai Weinfeld on 8/20/15.
//  Copyright (c) 2015 Lightricks Ltd. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

static const int MATCH_SCORE = 10;


- (int)match:(NSArray *)otherCards
{
    int colorMatches = 0;
    int numberMatches = 0;
    int alphaMatches = 0;
    int shapeMatches = 0;

    
    
    for (int i1 = 0; i1 < [otherCards count]; i1++){
        for (int i2 = i1+1; i2 < [otherCards count]; i2++){
            
            SetCard *card1 = (SetCard *)otherCards[i1];
            SetCard *card2 = (SetCard *)otherCards[i2];
            
            if (card1.color == card2.color){
                colorMatches += 1;
            }
            if (card1.number == card2.number){
                numberMatches += 1;
            }
            if (card1.alpha == card2.alpha){
                alphaMatches += 1;
            }
            if (card1.shape == card2.shape){
                shapeMatches += 1;
            }
        }
    }

    if(colorMatches % 3 != 0){
        return 0;
    }else if(numberMatches % 3 != 0){
        return 0;
    }else if(alphaMatches % 3 != 0){
        return 0;
    }else if(shapeMatches % 3 != 0){
        return 0;
    }
    
    return MATCH_SCORE;
}

- (NSString *)contents
{
    return nil;
}

@end
