//
//  SetDeck.h
//  Matchismo
//
//  Created by Hagai Weinfeld on 8/20/15.
//  Copyright (c) 2015 Lightricks Ltd. All rights reserved.
//

#import "Deck.h"

@interface SetDeck : Deck

// previously on XCODE: was trying to decide if i want to put these properties in here or in card?
@property (nonatomic) NSUInteger numColors;
@property (nonatomic) NSUInteger numNumbers;
@property (nonatomic) NSUInteger numAlpha;
@property (nonatomic) NSUInteger numShapes;

@end
