//
//  ViewController.m
//  Matchismo
//
//  Created by Hagai Weinfeld on 8/17/15.
//  Copyright (c) 2015 Lightricks Ltd. All rights reserved.
//

#import "ViewController.h"
#import "Deck.h"
#import "CardMatchingGame.h"

@interface ViewController ()

@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *matchNumButton;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@end

@implementation ViewController

- (IBAction)redealButton:(UIButton *)sender {
    self.matchNumButton.userInteractionEnabled = YES;
    _game = nil;
    [self updateUI];
}

- (IBAction)gameTypeButton:(UISegmentedControl *)sender
{
    self.game.numMatches = sender.selectedSegmentIndex + 2;
}


- (CardMatchingGame *)game
{
    if(!_game) _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
    return _game;
}


- (Deck *)createDeck
{
    return nil;
}

- (IBAction)touchCardButton:(UIButton *)sender
{
    self.matchNumButton.userInteractionEnabled = NO;
    NSUInteger chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    [self updateUI];
    
}

- (void)updateUI
{
    // update status:
    
    self.statusLabel.text = @"";
    
    
    // a card was chosen but the ammount to match was not reached:
    if( [self.game lastMatching] == 2){
        self.statusLabel.text = @"Chose:  [";
    }
    
    // a match occured:
    else if( [self.game lastMatching] == 1){
        self.statusLabel.text = @"Math for:  [";
    }
    
    // cards didn't match:
    else if( [self.game lastMatching] == 0){
        self.statusLabel.text = @"No match for:  [";
    }
    
    // add cards to status:
    for( Card *card in [self.game lastCards]){
        self.statusLabel.text = [self.statusLabel.text stringByAppendingString: [self getCardString:card]];  // replace with method for card string
        if( ![card isEqual:[[self.game lastCards] lastObject]]){
            self.statusLabel.text = [self.statusLabel.text stringByAppendingString: @", "];
        }
    }
    
    self.statusLabel.text = [self.statusLabel.text stringByAppendingString: [NSString stringWithFormat:@"] with score: %d", (int)[self.game lastScore]] ];
    
    
    // update card ui:
    for (UIButton *cardButton in self.cardButtons){
        NSUInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        cardButton.enabled = !card.isMatched;
        [self updateCardUI:card button:cardButton];
    }
    
    // update score:
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", (int)self.game.score];
}

- (NSString *)getCardString:(Card *)card
{
    return nil;
}

- (void)updateCardUI:(Card *)card button:(UIButton *)cardButton
{
}

- (NSString *)titleForCard:(Card *)card
{
    return nil;
}

- (UIImage *)backgroundImageForCard:(Card *)card
{
    return nil;
}

@end
