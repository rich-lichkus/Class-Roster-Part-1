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
        self.favColorRGB = @[@1.f,@1.f,@1.f];
        
    }
	return self;
}

- (id)initWithCoder:(NSCoder *)decoder {
    
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.name  = [decoder decodeObjectForKey:@"name"];
    self.isInstructor = [decoder decodeBoolForKey:@"isInstructor"];
    self.twitter = [decoder decodeObjectForKey:@"twitter"];
    self.github = [decoder decodeObjectForKey:@"github"];
    self.favColorRGB = [decoder decodeObjectForKey:@"favColorRGB"];
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.name forKey:@"name"];
    [encoder encodeBool:[self isInstructor] forKey:@"isInstructor"];
    [encoder encodeObject:self.twitter forKey:@"twitter"];
    [encoder encodeObject:self.github forKey:@"github"];
    [encoder encodeObject:self.favColorRGB forKey:@"favColorRGB"];
}



@end
