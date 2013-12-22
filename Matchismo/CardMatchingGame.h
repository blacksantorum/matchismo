//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Chris Tibbs on 12/20/13.
//  Copyright (c) 2013 Chris Tibbs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Card.h"

@interface CardMatchingGame : NSObject

// designated initializer
-(instancetype)initWithCardCount:(NSUInteger)count
                       usingDeck:(Deck *)deck;

-(void)chooseCardAtIndex:(NSUInteger)index;
-(Card *)cardAtIndex:(NSUInteger)index;
-(NSArray *)chosenUnmatchedCards;

@property (nonatomic, readonly) NSInteger score;
@property (nonatomic) NSInteger matchMode;
@property (nonatomic, strong) Card *lastChosenCard;
@property (nonatomic) NSInteger lastScoreChange;

@end
