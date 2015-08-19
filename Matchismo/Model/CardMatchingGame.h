//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Hagai Weinfeld on 8/18/15.
//  Copyright (c) 2015 Lightricks Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"


@interface CardMatchingGame : NSObject

// designated iniitalizer
- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck;
- (void)chooseCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;
@property (nonatomic, readonly) NSInteger score;
@property (nonatomic, readonly) NSString *status;
@property (nonatomic) NSInteger numMatches;

@end
