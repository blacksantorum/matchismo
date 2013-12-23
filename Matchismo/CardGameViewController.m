//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Chris Tibbs on 12/20/13.
//  Copyright (c) 2013 Chris Tibbs. All rights reserved.
//

#import "CardGameViewController.h"
#import "CardMatchingGame.h"
#import "PlayingCard.h"
#import "SetCard.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (nonatomic,strong) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *narrationLabel;
@property (strong, nonatomic) NSString *chosenUnmatchedString;

@end

@implementation CardGameViewController

-(NSString *)chosenUnmatchedString
{
    if (!_chosenUnmatchedString) {
        _chosenUnmatchedString = [[NSString alloc] init];
    }
    return _chosenUnmatchedString;
}

-(CardMatchingGame *)game
{
    if(!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
    }
    return _game;
}

- (IBAction)newGame:(UIButton *)sender {
    self.game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
    self.narrationLabel.text = @"";
    self.chosenUnmatchedString = @"";
    [self updateUI];
}

-(Deck *)createDeck
{
    return nil;
}

- (IBAction)touchCardButton:(UIButton *)sender {
    int chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    [self narrate];
    [self updateUI];
}

-(void)narrate
{
    self.chosenUnmatchedString = [self.chosenUnmatchedString stringByAppendingString:self.game.lastChosenCard.contents];
    if (self.game.lastScoreChange > 0) {
        self.narrationLabel.text = [NSString stringWithFormat:@"Matched %@ for %d points",self.chosenUnmatchedString,self.game.lastScoreChange];
        self.chosenUnmatchedString = @"";
    } else if (self.game.lastScoreChange < 0){
        self.narrationLabel.text = [NSString stringWithFormat:@"%@ don't match! %d point penalty!",self.chosenUnmatchedString,self.game.lastScoreChange];
        self.chosenUnmatchedString = self.game.lastChosenCard.contents;
    } else {
        self.narrationLabel.text = self.chosenUnmatchedString;
    }
}

-(void)updateUI
{
    for (UIButton *cardButton in self.cardButtons) {
        int cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        if ([card isKindOfClass:[PlayingCard class]]) {
            [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        } else if ([card isKindOfClass:[SetCard class]]) {
            [cardButton setAttributedTitle:[self attributedTitleForCard:card] forState:UIControlStateNormal];
        }
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d",self.game.score];
    }
}

-(NSAttributedString *)attributedTitleForCard:(Card *)card
{
    return nil;
}

-(NSString *)titleForCard:(Card *)card
{
    return nil;
}

-(UIImage *)backgroundImageForCard:(Card *)card
{
    return nil;
}

@end
