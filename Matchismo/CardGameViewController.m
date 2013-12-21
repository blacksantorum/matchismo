//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Chris Tibbs on 12/20/13.
//  Copyright (c) 2013 Chris Tibbs. All rights reserved.
//

#import "CardGameViewController.h"
#import "Deck.h"
#import "PlayingCardDeck.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (nonatomic,strong) Deck *deck;
@end

@implementation CardGameViewController

-(Deck *)deck
{
    if (!_deck) {
        _deck = [[PlayingCardDeck alloc] init];
    }
    return _deck;
}

-(void)setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d",self.flipCount];
}

- (IBAction)touchCardButton:(UIButton *)sender {
    if ([sender.currentTitle length]) {
        [sender setBackgroundImage:[UIImage imageNamed:@"cardback"]
                          forState:UIControlStateNormal];
        [sender setTitle:@"" forState:UIControlStateNormal];
    } else {
        Card *c = [self.deck drawRandomCard];
        if (c) {
            [sender setBackgroundImage:[UIImage imageNamed:@"cardfront"]
                              forState:UIControlStateNormal];
            [sender setTitle:c.contents forState:UIControlStateNormal];
            self.flipCount++;
        }
        // else { [sender removeFromSuperview];}
    }
    
}


@end
