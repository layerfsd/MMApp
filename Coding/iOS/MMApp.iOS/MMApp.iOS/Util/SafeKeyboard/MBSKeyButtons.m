//
//  KeyButtons.m
//  PasswordKeyBorad
//
//  Created by lori on 12-9-11.
//  Copyright (c) 2012年 LLBT. All rights reserved.
//

#import "MBSKeyButtons.h"

@implementation MBSKeyButtons

@synthesize m_character,m_tag,m_delegate,m_imageBtn;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame tag:(NSInteger)tagNumber delegate:(id<KeyBoardDelegate>)delegate
{
    self = [super initWithFrame:frame];
    if (self) {
        m_tag = tagNumber;
        m_delegate = delegate;
        
        m_imageBtn = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        m_imageBtn.layer.borderWidth = 1.0f;
        m_imageBtn.layer.borderColor = [UIColor colorWithRed:209/225.0f green:209/225.0f blue:209/225.0f alpha:1.0f].CGColor;
        m_imageBtn.layer.cornerRadius = 3.0f;
        [self addSubview:m_imageBtn];
        
        m_character = [[UILabel alloc] initWithFrame:CGRectMake(2, 0, frame.size.width-5, frame.size.height)];
        m_character.backgroundColor = [UIColor clearColor];
        m_character.textAlignment = NSTextAlignmentCenter;
        m_character.textColor = [UIColor colorWithRed:128/225.0f green:128/225.0f blue:128/225.0f alpha:1.0f];
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:m_character];
        
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //    m_imageBtn.image = [UIImage imageNamed:@"字母按钮1.png"];
    if ([m_delegate respondsToSelector:@selector(keyPressedBegin:)]) {
        [m_delegate keyPressedBegin:self];
    }
    
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if ([m_delegate respondsToSelector:@selector(keyPressed:tag:)]) {
        [m_delegate keyPressed:self tag:m_tag];
    }
}

@end
