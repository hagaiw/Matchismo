//
//  SetDeck.h
//  Matchismo
//
//  Created by Hagai Weinfeld on 8/20/15.
//  Copyright (c) 2015 Lightricks Ltd. All rights reserved.
//

#import "Deck.h"

@interface SetDeck : Deck

- (instancetype)initWithColors:(NSArray *)colors Numbers:(NSArray *)numbers Alphas:(NSArray *)alphas Shapes:(NSArray *)shapes;
- (NSUInteger)numColors;
- (NSUInteger)numNumbers;
- (NSUInteger)numAlphas;
- (NSUInteger)numShapes;

@property (strong, nonatomic) NSArray *colors;
@property (strong, nonatomic) NSArray *numbers;
@property (strong, nonatomic) NSArray *alphas;
@property (strong, nonatomic) NSArray *shapes;

@end
