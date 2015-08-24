//
//  SetCardViewController.m
//  Matchismo
//
//  Created by Hagai Weinfeld on 8/20/15.
//  Copyright (c) 2015 Lightricks Ltd. All rights reserved.
//

#import "SetCardViewController.h"
#import "SetDeck.h"
#import "SetCard.h"
#import "CardMatchingGame.h"

@interface SetCardViewController ()
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (strong, nonatomic) IBOutlet SetDeck *deck;
@end

@implementation SetCardViewController


- (Deck *)createDeck
{
    NSArray *colors = @[[UIColor redColor], [UIColor greenColor], [UIColor blueColor]];
    NSArray *numbers = @[@1, @2, @3];
    NSArray *alphas = @[@0, [NSNumber numberWithFloat:0.3f], @1];
    NSArray *shapes = @[@"▲", @"●", @"■"];
    _deck = [[SetDeck alloc] initWithColors:colors Numbers:numbers Alphas:alphas Shapes:shapes];
    return _deck;
}

- (NSAttributedString *)getCardString:(Card *)card
{
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] init];
    
    SetCard *setCard = (SetCard *)card;
    
    for( NSUInteger i = 0; i <= setCard.number; i++) {
        NSString *shapeString = _deck.shapes[setCard.shape];
        [title appendAttributedString:[[NSAttributedString alloc] initWithString:shapeString ]];
        
        UIColor *color = _deck.colors[setCard.color];
        [title addAttribute:NSStrokeColorAttributeName value:color range:NSMakeRange(0, title.length)];
        NSNumber *alpha = _deck.alphas[setCard.alpha];
        color = [color colorWithAlphaComponent: [alpha floatValue]];
        [title addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, title.length)];
        [title addAttribute:NSStrokeWidthAttributeName value:@-3 range:NSMakeRange(0, title.length)];
        
    }
    return title;
}

- (void)updateCardUI:(Card *)card button:(UIButton *)cardButton
{
    [cardButton setAttributedTitle:[self getCardString:card] forState:UIControlStateNormal];
    [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
}

- (UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:@"cardfront"];
}




@end
