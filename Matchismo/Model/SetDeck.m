//
//  SetDeck.m
//  Matchismo
//
//  Created by Hagai Weinfeld on 8/20/15.
//  Copyright (c) 2015 Lightricks Ltd. All rights reserved.
//

#import "SetDeck.h"
#import "SetCard.h"

@implementation SetDeck

- (instancetype)initWithColors:(NSArray *)colors Numbers:(NSArray *)numbers Alphas:(NSArray *)alphas Shapes:(NSArray *)shapes
{
    self = [super init];
    
    self.colors = colors;
    self.numbers = numbers;
    self.alphas = alphas;
    self.shapes = shapes;
    
    if(self) {
        for (int color = 0; color < [self numColors]; color++) {
            for (int number = 0; number < [self numNumbers]; number++) {
                for (int alpha = 0; alpha < [self numAlphas]; alpha++) {
                    for (int shape = 0; shape < [self numShapes]; shape++) {
                        SetCard *card = [[SetCard alloc] init];
                        card.color = color;
                        card.number = number;
                        card.alpha = alpha;
                        card.shape = shape;
                        [self addCard:card];
                    }
                }
            }
        }
    }
    
    return self;
}

- (NSUInteger)numColors{
    return [self.colors count];
}

- (NSUInteger)numNumbers{
    return [self.numbers count];
}

- (NSUInteger)numAlphas{
    return [self.alphas count];
}

- (NSUInteger)numShapes{
    return [self.shapes count];
}



@end
