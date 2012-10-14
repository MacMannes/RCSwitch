//
//  RCSwitchCell.m
//
//  Created by André Mathlener on 17-05-12.
//  Copyright (c) 2012 MacMannes. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#import "RCSwitchCell.h"

@implementation RCSwitchCell

@synthesize rcSwitch = _rcSwitch;

// overrides superclass
- (void)performInitialization
{
    [super performInitialization];

    // place any initialization code here
    self.rcSwitch = [[RCSwitchOnOff alloc] initWithFrame:CGRectZero];
    [self.rcSwitch addTarget:self
                      action:@selector(switchControlChanged:)
            forControlEvents:UIControlEventValueChanged];
    [self.contentView addSubview:_rcSwitch];
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    CGRect switchFrame = self.switchControl.frame;
    self.rcSwitch.frame = switchFrame;
}

// overrides superclass
- (void)loadBoundValueIntoControl
{
    if (self.boundPropertyName && [self.boundValue isKindOfClass:[NSNumber class]]) {
        _pauseControlEvents = YES;
        self.rcSwitch.on = [(NSNumber *)self.boundValue boolValue];
        _pauseControlEvents = NO;
    }
}

// overrides superclass
- (void)commitChanges
{
    if (!self.needsCommit || !self.valueIsValid) {
        return;
    }

    [super commitChanges];

    self.boundValue = [NSNumber numberWithBool:self.rcSwitch.on];
    needsCommit = YES;
}

@end
