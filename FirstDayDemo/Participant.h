//
//  Participant.h
//  FirstDayDemo
//
//  Created by Richard Lichkus on 1/14/14.
//  Copyright (c) 2014 Codefellows. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Participant : NSObject

@property (nonatomic) NSString *name;
@property (nonatomic) NSString *twitter;
@property (nonatomic) NSString *github;
@property (nonatomic) NSString *imageTitle;
@property (nonatomic) BOOL isInstructor;

- (instancetype)initWithName:(NSString *)name;

@end
