//
//  PlayingCardGameViewController.m
//  Matchismo
//
//  Created by Chris Tibbs on 12/21/13.
//  Copyright (c) 2013 Chris Tibbs. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "Deck.h"
#import "PlayingCardDeck.h"

@interface PlayingCardGameViewController ()

@end

@implementation PlayingCardGameViewController

-(Deck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
}

-(NSString *)titleForCard:(Card *)card
{
    return card.isChosen ? card.contents : @"";
}

-(UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}



@end
