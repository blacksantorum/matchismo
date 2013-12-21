//
//  Card.h
//  Matchismo
//
//  Created by Chris Tibbs on 12/20/13.
//  Copyright (c) 2013 Chris Tibbs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong, nonatomic) NSString *contents;

@property (nonatomic, getter=isChosen) BOOL chosen;
@property (nonatomic, getter=isMatched) BOOL matched;

- (int)match:(NSArray *)otherCards;

@end
