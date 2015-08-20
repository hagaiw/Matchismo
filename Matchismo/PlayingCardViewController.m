//
//  PlayingCardViewController.m
//  Matchismo
//
//  Created by Hagai Weinfeld on 8/19/15.
//  Copyright (c) 2015 Lightricks Ltd. All rights reserved.
//

#import "PlayingCardViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface PlayingCardViewController ()
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *matchNumButton;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@end

@implementation PlayingCardViewController

- (Deck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
}


- (void)updateCardUI:(Card *)card button:(UIButton *)cardButton
{
    [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
    [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
}


- (NSString *)titleForCard:(Card *)card
{
    return card.isChosen ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}

- (NSString *)getCardString:(Card *)card
{
    return [card contents];
}

@end
