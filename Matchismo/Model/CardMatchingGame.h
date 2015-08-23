//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Hagai Weinfeld on 8/18/15.
//  Copyright (c) 2015 Lightricks Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

typedef NS_ENUM(NSUInteger, MatchStatusType) {
    MatchStatusTypeMatched,
    MatchStatusTypeMismatched,
    MatchStatusTypeNone
};


@interface CardMatchingGame : NSObject

// designated iniitalizer
- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck;
- (void)chooseCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;
@property (nonatomic, readonly) NSInteger score;
@property (nonatomic) NSInteger numMatches;

@property (nonatomic, readonly) NSArray *lastCards;
@property (nonatomic, readonly) NSUInteger lastMatching;
@property (nonatomic, readonly) NSInteger lastScore;

@end
