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
#import "HistoryViewController.h"



@interface ViewController ()

@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *matchNumButton;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@property (strong, nonatomic) NSMutableArray *statusHistoryArray;

@end

@implementation ViewController

- (IBAction)redealButton:(UIButton *)sender {
    self.matchNumButton.userInteractionEnabled = YES;
    _game = nil;
    _game = self.game;
    _statusHistoryArray = nil;
    [self updateUI];
}

- (IBAction)gameTypeButton:(UISegmentedControl *)sender
{
    self.game.numMatches = sender.selectedSegmentIndex + 2;
}

- (NSMutableArray *)statusHistoryArray
{
    if(!_statusHistoryArray) {
        _statusHistoryArray = [[NSMutableArray alloc] init];
    }
    return _statusHistoryArray;
}


- (CardMatchingGame *)game
{
    if(!_game) _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck] numMatches:3];
    return _game;
}


- (Deck *)createDeck
{
    return nil;
}

- (IBAction)touchCardButton:(UIButton *)sender {
    self.matchNumButton.userInteractionEnabled = NO;
    NSUInteger chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    [self updateUI];
    
}

- (void)updateUI {
    // Update status:
    self.statusLabel.text = @"";
    if([self.game.lastCards count] > 0) {
        NSMutableAttributedString *status = [self getStatusPrefix];
        [self appendCardsToStatus:status];
        [self updateStatusUI:status];
        [self.statusHistoryArray addObject:status];
    }
    [self updateCardsUI];
}

- (NSMutableAttributedString *)getStatusPrefix {
    NSMutableAttributedString *status;
    // a card was chosen but the amount to match was not reached:
    if( [self.game lastMatching] == MatchStatusTypeNone){
        status = [[NSMutableAttributedString alloc] initWithString:@"Chose:  ["];
    }
    
    // a match occured:
    else if( [self.game lastMatching] == MatchStatusTypeMatched){
        status = [[NSMutableAttributedString alloc] initWithString:@"Match for:  ["];
    }
    
    // cards didn't match:
    else if( [self.game lastMatching] == MatchStatusTypeMismatched){
        status = [[NSMutableAttributedString alloc] initWithString:@"No match for:  ["];
    }
    return status;
}

- (void)appendCardsToStatus:(NSMutableAttributedString *)status {
    // add cards to status:
    for( Card *card in [self.game lastCards]){
        NSAttributedString *attString = [self getCardString:card];
        [status appendAttributedString:attString];
        if( ![card isEqual:[[self.game lastCards] lastObject]]){
            NSAttributedString *attString = [[NSAttributedString alloc] initWithString:@", "];
            [status appendAttributedString:attString];
        }
    }
}

- (void)updateStatusUI:(NSMutableAttributedString *)status {
    NSAttributedString *attString = [[NSAttributedString alloc]
                                     initWithString:[NSString stringWithFormat:@"] with score: %d", (int)[self.game lastScore]]];
    [status appendAttributedString:attString];
    self.statusLabel.attributedText = status;
    
    // update score:
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", (int)self.game.score];
}

- (NSAttributedString *)getCardString:(Card *)card
{
    return nil;
}


- (void)updateCardsUI
{
    for (UIButton *cardButton in self.cardButtons){
        NSUInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        cardButton.enabled = !card.isMatched;
        [self updateCardUI:card button:cardButton];
    }
}

- (void)updateCardUI:(Card *)card button:(UIButton *)cardButton
{
}

- (UIImage *)backgroundImageForCard:(Card *)card
{
    return nil;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"History"])
    {
        NSMutableAttributedString *historyText = [[NSMutableAttributedString alloc] init];
        for (NSMutableAttributedString *status in self.statusHistoryArray) {
            [historyText appendAttributedString:status];
            [historyText appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n"]];
        }
        
        // Get reference to the destination view controller
        HistoryViewController *historyViewController = [segue destinationViewController];
        
        // Pass any objects to the view controller here, like...
        historyViewController.bodyText = historyText;
    }
}

- (void)viewDidLoad {
    [self updateUI];
}

@end
