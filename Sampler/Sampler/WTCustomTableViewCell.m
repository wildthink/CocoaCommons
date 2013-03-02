//
//  CTCustomTableViewCell.m
//  ComLink
//
//  Created by Jason Jobe on 2/11/13.
//  Copyright (c) 2013 Jason Jobe. All rights reserved.
//

#import "WTCustomTableViewCell.h"
#import "NSObject+MetaData.h"


@implementation WTCustomTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withNibNamed:(NSString*)nibName
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        UINib *nib = [UINib nibWithNibName:nibName bundle:nil];
//        NSArray *tops = [nib instantiateWithOwner:self options:nil];
        NSArray *tops = [[NSBundle mainBundle] loadNibNamed:nibName owner:self options:nil];
        NSLog (@"Loaded nib with %d tops", [tops count]);
    }
    return self;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)takeValuesFromRepresentedObject:nob;
{
    NSString *key;
    
    for (UIView *vu in self.elements)
    {
        key = [vu metadata:kWTPropertyName];
        if ([vu respondsToSelector:@selector(setRepresentedValue:)]) {
            id value = [nob valueForKey:key];
            [vu performSelector:@selector(setRepresentedValue:) withObject:value];
        }
    }
}

- (void)setValuesOnRepresentedObject:nob;
{
    NSString *key;
    
    for (UIView *vu in self.elements)
    {
        key = [vu metadata:kWTPropertyName];
        if ([vu respondsToSelector:@selector(representedValue:)]) {
            id value;
            value = [vu performSelector:@selector(representedValue:)];
            [nob setValue:value forKey:key];
        }
    }
}

@end


// Default implementations for common UI elements

@implementation UILabel (CTCustomValueElement)

- (void)setRepresentedValue:value {
    [self setText:value];
}

- representedValue {
    return [self text];
}
@end

@implementation UITextField (CTCustomValueElement)
- (void)setRepresentedValue:value {
    [self setText:value];
}

- representedValue {
    return [self text];
}
@end