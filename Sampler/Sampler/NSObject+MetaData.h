//
//  NSObject+MetaData.h
//
//  Created by Jason Jobe on 1/15/13.
//  Copyright (c) 2013 Jason Jobe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MetaMap : NSMutableDictionary

@property (weak) NSObject *owner;
@property (strong) NSMutableDictionary *map;

- initWithOwner:ownr;
- objectForKeyPath:(NSString*)keypath;

@end


@interface NSObject (MetaData)

@property (strong) MetaMap *metadata;

- (void)setMetadata:(MetaMap *)md;
- (MetaMap*)metadata;
- metadata:(NSString*)mdKey;

- (BOOL)hasMetadata;
- metadataForKeyPath:(NSString*)keypath;

@end



