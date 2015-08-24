//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Hagai Weinfeld on 8/18/15.
//  Copyright (c) 2015 Lightricks Ltd. All rights reserved.
//

#import "CardMatchingGame.h"


@interface CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards; //of cards
@property (nonatomic) NSInteger selectedCards;


@property (nonatomic, readwrite) NSMutableArray *lastCards;
@property (nonatomic, readwrite) NSUInteger lastMatching;
@property (nonatomic, readwrite) NSInteger lastScore;

@end



// implements a generic card game
@implementation CardMatchingGame

- (NSMutableArray *) cards
{
    if(!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck numMatches:(int)numMatchesRequired
{
    self.score = 0;
    self.numMatches = numMatchesRequired;
    self = [super init];
    if(self){
        for (int i = 0; i < count; i++){
            Card *card = [deck drawRandomCard];
            if(card){
                [self.cards addObject:card];
            }else{
                self = nil;
                break;
            }
        }
    }
    return self;
}

- (Card *)cardAtIndex:(NSUInteger)index{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

- (void)chooseCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    self.lastScore = 0;
    
    if(!card.isMatched){
        if(card.isChosen){
            _selectedCards--;
            card.chosen = NO;
        } else {
            card.chosen = YES;
            _selectedCards++;
            
            if( _selectedCards == _numMatches){
                _selectedCards = 0;
                NSMutableArray *chosenCardsArray = [[NSMutableArray alloc] init];
            
                // match against other chosen cards
                for (Card *otherCard in self.cards) {
                    if (otherCard.isChosen && !otherCard.isMatched) {
                        [chosenCardsArray addObject:otherCard];
                    }
                }
                
                
                int matchScore = [card match:chosenCardsArray];
                self.lastCards = chosenCardsArray;
                
                if (matchScore){
                    self.lastMatching = MatchStatusTypeMatched;
                    for (Card *chosenCard in chosenCardsArray) {
                        chosenCard.matched = YES;
                    }
                    self.lastScore += matchScore * MATCH_BONUS;
                } else {
                    self.lastMatching = MatchStatusTypeMismatched;
                    for (Card *chosenCard in chosenCardsArray) {
                        chosenCard.chosen = NO;
                    }
                    self.lastScore -= MISMATCH_PENALTY;
                }
            }
            else{
                self.lastMatching = MatchStatusTypeNone;
                self.lastCards = @[card];
            }
            self.lastScore -= COST_TO_CHOOSE;
        }
    }
    self.score += self.lastScore;
}

@end
