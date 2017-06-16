//
//  KeyButtons.h
//  PasswordKeyBorad
//
//  Created by lori on 12-9-11.
//  Copyright (c) 2012年 LLBT. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KeyBoardDelegate;

@interface MBSKeyButtons : UIView{
    UILabel *m_character;
	NSInteger m_tag;
    UIImageView *m_imageBtn;
}
@property (nonatomic,retain)	UILabel *m_character;
@property (nonatomic,retain)UIImageView *m_imageBtn;
@property (nonatomic) NSInteger m_tag;
@property (nonatomic, assign) id <KeyBoardDelegate> m_delegate;
-(id)initWithFrame:(CGRect)frame tag:(NSInteger)tagNumber delegate:(id<KeyBoardDelegate>)delegate;

@end


@protocol KeyBoardDelegate <NSObject> 

@optional
-(void)keyPressed:(MBSKeyButtons*)keyButton tag:(NSInteger)value;
-(void)keyPressedBegin:(MBSKeyButtons*)keyButton;

@end
