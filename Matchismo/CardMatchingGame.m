//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Chris Tibbs on 12/20/13.
//  Copyright (c) 2013 Chris Tibbs. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (nonatomic,readwrite) NSInteger score;
@property (nonatomic,strong) NSMutableArray *cards; //of Card

@end


@implementation CardMatchingGame

-(NSMutableArray *)cards
{
    if (!_cards) {
        _cards = [[NSMutableArray alloc] init];
    }
    return _cards;
}

-(NSInteger)matchMode
{
    if (!_matchMode) {
        _matchMode = 2;
    }
    return _matchMode;
}

-(instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
{
    self = [super init];
    
    if (self) {
        for (int i = 0; i<count; i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            } else {
                self = nil;
                break;
            }
        }
    }
    return self;
}

-(NSArray *)chosenUnmatchedCards
{
    NSMutableArray *chosenUnmatchedCards = [[NSMutableArray alloc] init];
    for (Card *c in self.cards) {
        if (c.isChosen && !c.isMatched) {
            [chosenUnmatchedCards addObject:c];
        }
    }
    return chosenUnmatchedCards;
}

-(Card *)cardAtIndex:(NSUInteger)index
{
    return (index<[self.cards count]) ? self.cards[index] : nil;
}

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

-(void)chooseCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    self.lastScoreChange = 0;
    if (!card.isMatched) {
        if (card.isChosen) {
            card.chosen = NO;
        } else  if  ([[self chosenUnmatchedCards] count] < self.matchMode - 1) {
            self.lastChosenCard = card;
            card.chosen = YES;
            self.score -= COST_TO_CHOOSE;
        } else {
            self.lastChosenCard = card;
            int matchScore = [card match:[self chosenUnmatchedCards]];
            card.chosen = YES;
            self.score -= COST_TO_CHOOSE;
            if (matchScore) {
                self.lastScoreChange = matchScore * MATCH_BONUS;
                self.score += self.lastScoreChange;
                for (Card *c in [self chosenUnmatchedCards]) {
                    c.matched = YES;
                }
            } else {
                self.lastScoreChange = 0 - MISMATCH_PENALTY;
                self.score -= self.lastScoreChange;
                for (Card *c in [self chosenUnmatchedCards]) {
                    c.chosen = NO;
                }
                card.chosen = YES;
            }
        }
    }
}

@end

