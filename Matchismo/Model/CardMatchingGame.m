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
@property (nonatomic, readwrite) NSString *status;
@end

@implementation CardMatchingGame

- (NSMutableArray *) cards
{
    if(!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
{
    self.score = 0;
    self.numMatches = 2;
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
    
    if(!card.isMatched){
        if(card.isChosen){
            _selectedCards--;
            card.chosen = NO;
            self.status = [@"Unchose the card: " stringByAppendingString:card.contents];
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
                
                int tempScore = 0;
                for (int i1 = 0; i1 < [chosenCardsArray count]; i1++){
                    for (int i2 = i1+1; i2 < [chosenCardsArray count]; i2++){
                        int matchScore = [chosenCardsArray[i1] match:@[chosenCardsArray[i2]]];
                        NSLog(@"match score: %d, i1:%d, i2:%d", matchScore, i1, i2);
                        if (matchScore){
                            tempScore += matchScore;
                        }
                    }
                }
                
                self.status = @"";
                if (tempScore){
                    self.status = @"Matched the cards: ";
                    for (Card *chosenCard in chosenCardsArray) {
                        chosenCard.matched = YES;
                        self.status = [self.status stringByAppendingString:chosenCard.contents];
                        self.status = [self.status stringByAppendingString:@" "];
                    }
                    self.score += tempScore * MATCH_BONUS;
                } else {
                    self.status = @"Following cards did not match: ";
                    for (Card *chosenCard in chosenCardsArray) {
                        chosenCard.chosen = NO;
                        self.status = [self.status stringByAppendingString:chosenCard.contents];
                        self.status = [self.status stringByAppendingString:@" "];
                    }
                    self.score -= MISMATCH_PENALTY;
                }
            }
            else{
                self.status = [@"Chose the card: " stringByAppendingString:card.contents];
            }
            self.score -= COST_TO_CHOOSE;

        }
    }
}

@end
