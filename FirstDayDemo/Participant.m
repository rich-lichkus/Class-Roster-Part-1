//
//  Participant.m
//  FirstDayDemo
//
//  Created by Richard Lichkus on 1/14/14.
//  Copyright (c) 2014 Codefellows. All rights reserved.
//

#import "Participant.h"

@implementation Participant

- (instancetype)initWithName:(NSString *)name;
{
    if(self = [super init])
	{
		self.name = name;
        self.isInstructor = NO;
		self.imageTitle = @"";
        self.twitter = @"";
        self.github = @"";
        self.favColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
        
    }
	return self;
}

@end
