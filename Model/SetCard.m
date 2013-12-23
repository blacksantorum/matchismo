//
//  SetCard.m
//  Matchismo
//
//  Created by Chris Tibbs on 12/21/13.
//  Copyright (c) 2013 Chris Tibbs. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

-(void)setNumber:(NSUInteger)number
{
    if ( number >= 1 && number <= 3) {
        _number = number;
    }
}

-(void)setSymbol:(NSString *)symbol
{
    if ([[SetCard validSymbols] containsObject:symbol]) {
        _symbol = symbol;
    }
}

-(void)setShading:(NSString *)shading
{
    if ([[SetCard validShadings] containsObject:shading]) {
        _shading = shading;
    }
}

-(void)setColor:(NSString *)color
{
    if ([[SetCard validColors] containsObject:color]) {
        _color = color;
    }
}

+(NSArray *)validSymbols
{
    return @[@"●",@"▲",@"■"];
}

+(NSArray *)validShadings
{
    return @[@"solid",@"open",@"shaded"];
}

+(NSArray *)validColors
{
    return @[@"red",@"green",@"purple"];
}

-(int)match:(NSArray *)otherCards
{
    int matchScore = 0;
    
    NSMutableArray *mutableCardsArray = (NSMutableArray *)otherCards;
    [mutableCardsArray addObject:self];
    
    NSMutableArray *numbers = [[NSMutableArray alloc] init];
    NSMutableArray *symbols = [[NSMutableArray alloc] init];
    NSMutableArray *shadings = [[NSMutableArray alloc] init];
    NSMutableArray *colors = [[NSMutableArray alloc] init];
    
    for (SetCard *c in mutableCardsArray) {
        NSNumber *num = [NSNumber numberWithInteger:c.number];
        [numbers addObject:num];
        [symbols addObject:c.symbol];
        [shadings addObject:c.shading];
        [colors addObject:c.color];
    }
    
    NSSet *uniqueNumbers = [NSSet setWithArray:numbers];
    NSSet *uniqueSymbols = [NSSet setWithArray:symbols];
    NSSet *uniqueShadings = [NSSet setWithArray:shadings];
    NSSet *uniqueColors = [NSSet setWithArray:colors];
    
    if ([uniqueNumbers count] != 2 && [uniqueSymbols count] != 2 && [uniqueShadings count] != 2 && [uniqueColors count] != 2) {
        matchScore = 1;
    }
    return matchScore;
}

@end
