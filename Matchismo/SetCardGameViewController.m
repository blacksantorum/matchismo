//
//  SetCardGameViewController.m
//  Matchismo
//
//  Created by Chris Tibbs on 12/22/13.
//  Copyright (c) 2013 Chris Tibbs. All rights reserved.
//

#import "SetCardGameViewController.h"
#import "SetCardDeck.h"
#import "SetCard.h"

@interface SetCardGameViewController ()

@end

@implementation SetCardGameViewController

-(Deck *)createDeck
{
    return [[SetCardDeck alloc] init];
}

-(UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen ? @"selectedsetcard" : @"cardfront"];
}

-(UIColor *)colorForCard:(SetCard *)card
{
    UIColor *color = [[UIColor alloc] init];
    if ([card.color isEqualToString:@"red"]) {
        color = [UIColor redColor];
    } else if ([card.color isEqualToString:@"green"]) {
        color = [UIColor greenColor];
    } else if ([card.color isEqualToString:@"purple"]) {
        color = [UIColor purpleColor];
    }
    
    if ([card.shading isEqualToString:@"shaded"]) {
        color = [color colorWithAlphaComponent:0.5];
    }
    return color;
}

-(NSString *)symbolStringForCard:(SetCard *)card
{
    NSString *symbolString = [[NSString alloc] init];
    
    for (int i = 0; i < card.number ; i++) {
        symbolString = [symbolString stringByAppendingString:card.symbol];
        symbolString = [symbolString stringByAppendingString:@" "];
    }
    NSLog (@"%@",symbolString);
    return symbolString;
}

-(NSAttributedString *)attributedTitleForCard:(SetCard *)card
{
    NSString *stringForCard = [self symbolStringForCard:card];
    NSMutableAttributedString *attributedTitle = [[NSMutableAttributedString alloc] initWithString:stringForCard];
    [attributedTitle addAttribute:NSForegroundColorAttributeName value:[self colorForCard:card] range:NSMakeRange(0, [attributedTitle length]-1)];
    if ([card.shading isEqualToString:@"open"]) {
        [attributedTitle addAttribute:NSStrokeWidthAttributeName value:@-5 range:NSMakeRange(0,attributedTitle.length -1)];
     }
    return attributedTitle;
}

@end
