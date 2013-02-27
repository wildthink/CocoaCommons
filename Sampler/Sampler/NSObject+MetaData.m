//
//  NSObject+MetaData.m
//
//  Created by Jason Jobe on 1/15/13.
//  Copyright (c) 2013 Jason Jobe. All rights reserved.
//

#import <objc/runtime.h>

#import "NSObject+MetaData.h"

static void * const kMetadataKey = @"kMetadataKey";


@implementation NSObject (MetaData)
@dynamic metadata;

-(void)setMetadata:(MetaMap *)md
{
    objc_setAssociatedObject(self, kMetadataKey, md, OBJC_ASSOCIATION_RETAIN);
}

- (MetaMap*)metadata
{
    MetaMap *md = objc_getAssociatedObject(self, kMetadataKey);
    if (md == nil) {
        md = [[MetaMap alloc] initWithOwner:self];
        objc_setAssociatedObject(self, kMetadataKey, md, OBJC_ASSOCIATION_RETAIN);
    }
    return md;
}

- metadata:(NSString*)mdKey;
{
    MetaMap *md = objc_getAssociatedObject(self, kMetadataKey);
    return (md ? [md valueForKey:mdKey] : nil);
}

- (BOOL)hasMetadata {
    MetaMap *md = objc_getAssociatedObject(self, kMetadataKey);
    return (md != nil);
}

- metadataForKeyPath:(NSString*)keypath {
    if ([self hasMetadata])
        return [[self metadata] objectForKeyPath:keypath];
    else
        return nil;
}

@end

@implementation MetaMap

- initWithOwner:ownr
{
    self = [super init];
    if (self != nil)
    {
        self.owner = ownr;
        //       self.map = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (id)initWithCapacity:(NSUInteger)capacity
{
    self = [super init];
    if (self != nil)
    {
        self.map = [[NSMutableDictionary alloc] initWithCapacity:capacity];
    }
    return self;
}

- (id)initWithObjects:(NSArray *)objects forKeys:(NSArray *)keys
{
    self = [super init];
    if (self != nil)
    {
        self.map = [[NSMutableDictionary alloc] initWithObjects:objects forKeys:keys];
    }
    return self;
}

-(void)unbindFromOwnerIfNeeded
{
    if ([self count] == 0) {
        [self.owner setMetadata:nil];
        self.owner = nil;
    }
}

- (void)setObject:(id)anObject forKey:(id)aKey
{
    if (self.map == nil) {
        self.map = [[NSMutableDictionary alloc] init];
    }
    [self.map setObject:anObject forKey:aKey];
    [self unbindFromOwnerIfNeeded];
}

- (void)removeObjectForKey:(id)aKey
{
    [self.map removeObjectForKey:aKey];
    [self unbindFromOwnerIfNeeded];
}

- (NSUInteger)count
{
    return [self.map count];
}

- (id)objectForKey:(id)aKey
{
    [self unbindFromOwnerIfNeeded];
    return [self.map objectForKey:aKey];
}

- objectForKeyPath:(NSString*)keypath
{
    return [self.map objectForKey:keypath];
}

- (NSEnumerator *)keyEnumerator
{
    return [self.map keyEnumerator];
}


@end