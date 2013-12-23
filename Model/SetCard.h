//
//  SetCard.h
//  Matchismo
//
//  Created by Chris Tibbs on 12/21/13.
//  Copyright (c) 2013 Chris Tibbs. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card

@property (nonatomic) NSUInteger number;
@property (nonatomic,strong) NSString *symbol;
@property (nonatomic,strong) NSString *shading;
@property (nonatomic,strong) NSString *color;

+(NSArray *)validSymbols;
+(NSArray *)validShadings;
+(NSArray *)validColors;

@end
