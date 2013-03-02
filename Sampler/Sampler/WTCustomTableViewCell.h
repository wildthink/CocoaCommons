//
//  CTCustomTableViewCell.h
//  ComLink
//
//  Created by Jason Jobe on 2/11/13.
//  Copyright (c) 2013 Jason Jobe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WTCustomTableViewCell : UITableViewCell

@property (strong) IBOutletCollection (UIView) NSArray* elements;

- (void)takeValuesFromRepresentedObject:nob;
- (void)setValuesOnRepresentedObject:nob;

@end


@protocol WTCustomValueElement <NSObject>

- (void)setRepresentedValue:value;
- representedValue;

@end

@interface UILabel (CTCustomValueElement) <WTCustomValueElement>
@end

@interface UITextField (CTCustomValueElement) <WTCustomValueElement>
@end

static NSString *kWTPropertyName = @"uiKey";
