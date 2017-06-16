//
//  KeyBoardView.m
//  PasswordKeyBorad
//
//  Created by lori on 12-9-11.
//  Copyright (c) 2012年 LLBT. All rights reserved.
//

#import "MBSKeyBoardView.h"

#define kb_color_rgb(r,g,b,a) [UIColor colorWithRed:r/225.0f green:g/225.0f blue:b/225.0f alpha:a]

/*
 leftBtn.layer.borderWidth = 1.0f;
 leftBtn.layer.borderColor = kb_color_rgb(209, 209, 209, 1.0f).CGColor;
 */
@implementation MBSKeyBoardView

@synthesize m_delegate;

//生成随机键盘数据
-(NSMutableArray *)randomWithArray:(NSMutableArray *)array
{
    //    NSMutableArray *newArray = [NSMutableArray array];
    //    NSUInteger length = [array count];
    //    for (int i = 0;i<length;i++) {
    //        NSUInteger newLength =[array count];
    //        if (newLength == 1) {
    //            break;
    //        }
    //        int rand = arc4random() % (newLength-1);
    //        NSString *temp = [array objectAtIndex:rand];
    //
    //        [array removeObjectAtIndex:rand];
    //        [array insertObject:[array objectAtIndex:0] atIndex:rand];
    //
    //        [array removeObjectAtIndex:0];
    //        [newArray addObject:temp];
    //    }
    //    return newArray;
    
    //______________________下面摒弃
    
    
    //yes为开启密码乱序
//    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"openOrCloseSecretCodeKeyBoard"] == YES) {
        NSMutableArray *newArray = [NSMutableArray array];
        NSUInteger length = [array count];
        for (int i = 0;i<length;i++) {
            NSUInteger newLength =[array count];
            if (newLength == 1) {
                break;
            }
            int rand = arc4random() % (newLength-1);
            NSString *temp = [array objectAtIndex:rand];
            
            [array removeObjectAtIndex:rand];
            [array insertObject:[array objectAtIndex:0] atIndex:rand];
            
            [array removeObjectAtIndex:0];
            [newArray addObject:temp];
        }
        return newArray;
//    }else {
//        [array removeLastObject];
//        return array;
//    }
}

- (void)numberKeyBoardView{
    NSMutableArray *spchar = [[NSMutableArray alloc] initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0",@"11", nil];
    NSArray *randomArray = [self randomWithArray:spchar];
    
    m_numArray = [[NSMutableArray alloc] initWithArray:randomArray];
    [m_numArray insertObject:@"@" atIndex:9];
    
    NSArray *signArray = [[NSArray alloc] initWithObjects:@"/",@"?",@"!",@":", nil];
    for (int i = 0; i < 4; i++) {
        UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        leftBtn.frame = CGRectMake(2, 2+i*35, 50, 33);
        leftBtn.layer.cornerRadius = 2.0f;
        [leftBtn setTitle:[signArray objectAtIndex:i] forState:UIControlStateNormal];
        [leftBtn setBackgroundColor:kb_color_rgb(166, 166, 166, 1.0f)];
        [leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [leftBtn setTitleColor:kb_color_rgb(128, 128, 128, 1.0f) forState:UIControlStateHighlighted];
        [leftBtn addTarget:self action:@selector(keyBoardBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        [m_numberKeyView addSubview:leftBtn];
    }
    
    UIButton *changeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    changeBtn.frame = CGRectMake(2, 142, 50, 35);
    changeBtn.tag = 1010;
    [changeBtn setTitle:@"abc" forState:UIControlStateNormal];
    [changeBtn setBackgroundColor:kb_color_rgb(166, 166, 166, 1.0f)];
    [changeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [changeBtn setTitleColor:kb_color_rgb(128, 128, 128, 1.0f) forState:UIControlStateHighlighted];
    changeBtn.layer.cornerRadius = 2.0f;
    [changeBtn addTarget:self action:@selector(changeKeyTypeOfNum:) forControlEvents:UIControlEventTouchUpInside];
    [m_numberKeyView addSubview:changeBtn];
    
    CGFloat numberWidth = (self.frame.size.width-56-52)/3;
    for (int i =0; i<4; i++) {
        for ( int j = 0; j<3; j++) {
            if (i==3&&j==2) {
                break;
            }
            UIButton *numBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            numBtn.frame = CGRectMake(56+(numberWidth)*j, 2+44*i, numberWidth-2, 42);
            numBtn.layer.borderWidth = 1.0f;
            numBtn.layer.borderColor = kb_color_rgb(209, 209, 209, 1.0f).CGColor;
            numBtn.layer.cornerRadius = 3.0f;
            [numBtn setTitleColor:kb_color_rgb(128, 128, 128, 1.0f) forState:UIControlStateNormal];
            [numBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
            [numBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:22]];
            [numBtn addTarget:self action:@selector(keyBoardBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
            [numBtn setBackgroundImage:[UIImage imageNamed:@"CPSSDKImages.bundle/key_char_pressed"] forState:UIControlStateHighlighted];
            [m_numBtnsArray addObject:numBtn];
            [m_numberKeyView addSubview:numBtn];
        }
    }
    
    
    UIButton *spaceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    spaceBtn.frame = CGRectMake(56+(numberWidth)*2, 134, numberWidth-2, 42);
    spaceBtn.tag = 1018;
    //    [spaceBtn setTitle:@"┗  ┛" forState:UIControlStateNormal];
    //    spaceBtn.layer.borderWidth = 1.0f;
    //    spaceBtn.layer.borderColor = kb_color_rgb(209, 209, 209, 1.0f).CGColor;
    //    spaceBtn.layer.cornerRadius = 3.0f;
    //    [spaceBtn setTitleColor:[UIColor colorWithRed:15/255 green:35/255 blue:53/255 alpha:1] forState:UIControlStateNormal];
    //    [spaceBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [spaceBtn setBackgroundImage:[UIImage imageNamed:@"CPSSDKImages.bundle/key_dig_space_normal.png"] forState:UIControlStateNormal];
    [spaceBtn setBackgroundImage:[UIImage imageNamed:@"CPSSDKImages.bundle/key_dig_space_clicked.png"] forState:UIControlStateHighlighted];
    [spaceBtn addTarget:self action:@selector(keyButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [m_numberKeyView addSubview:spaceBtn];
    
    UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    deleteBtn.frame = CGRectMake(self.frame.size.width-52, 1, 50, 42);
    deleteBtn.tag = 1019;
    //    [deleteBtn setBackgroundColor:kb_color_rgb(166, 166, 166, 1.0f)];
    //    [deleteBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //    [deleteBtn setTitleColor:kb_color_rgb(128, 128, 128, 1.0f) forState:UIControlStateHighlighted];
    //    deleteBtn.layer.cornerRadius = 2.0f;
    //    [deleteBtn setTitle:@"<---" forState:UIControlStateNormal];
    [deleteBtn setImage:[UIImage imageNamed:@"CPSSDKImages.bundle/key_dig_delete_normal"] forState:UIControlStateNormal];
    [deleteBtn setImage:[UIImage imageNamed:@"CPSSDKImages.bundle/key_dig_delete_clicked"] forState:UIControlStateHighlighted];
    [deleteBtn addTarget:self action:@selector(keyButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [m_numberKeyView addSubview:deleteBtn];
    
    UIButton *signBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    signBtn.frame = CGRectMake(self.frame.size.width-52, 46, 50, 42);
    [signBtn setTitle:@"," forState:UIControlStateNormal];
    [signBtn setBackgroundColor:kb_color_rgb(166, 166, 166, 1.0f)];
    [signBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [signBtn setTitleColor:kb_color_rgb(128, 128, 128, 1.0f) forState:UIControlStateHighlighted];
    signBtn.layer.cornerRadius = 2.0f;
    [signBtn addTarget:self action:@selector(keyBoardBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [m_numberKeyView addSubview:signBtn];
    
    UIButton *signaBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    signaBtn.frame = CGRectMake(self.frame.size.width-52, 91, 50, 42);
    [signaBtn setTitle:@"." forState:UIControlStateNormal];
    [signaBtn setBackgroundColor:kb_color_rgb(166, 166, 166, 1.0f)];
    [signaBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [signaBtn setTitleColor:kb_color_rgb(128, 128, 128, 1.0f) forState:UIControlStateHighlighted];
    signaBtn.layer.cornerRadius = 2.0f;
    [signaBtn addTarget:self action:@selector(keyBoardBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [m_numberKeyView addSubview:signaBtn];
    
    UIButton *toSignBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    toSignBtn.frame = CGRectMake(self.frame.size.width-52, 136, 50, 42);
    toSignBtn.tag = 1011;
    [toSignBtn setTitle:@"#+=" forState:UIControlStateNormal];
    [toSignBtn setBackgroundColor:kb_color_rgb(166, 166, 166, 1.0f)];
    [toSignBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [toSignBtn setTitleColor:kb_color_rgb(128, 128, 128, 1.0f) forState:UIControlStateHighlighted];
    toSignBtn.layer.cornerRadius = 2.0f;
    [toSignBtn addTarget:self action:@selector(changeKeyTypeOfNum:) forControlEvents:UIControlEventTouchUpInside];
    [m_numberKeyView addSubview:toSignBtn];
}

//初始化字母键盘数据和字母键盘按钮
- (void)letterKeyBoradView{
    
    NSMutableArray *spchar = [[NSMutableArray alloc] initWithObjects:@"Q",@"W",@"E",@"R",@"T",@"Y",@"U",@"I",@"O",@"P",@"A",@"S",@"D",@"F",@"G",@"H",@"J",@"K",@"L",@"Z",@"X",@"C",@"V",@"B",@"N",@"M",@"11", nil];
    m_upcharArray = [[NSArray alloc] initWithArray:[self randomWithArray:spchar]];
    
    NSMutableArray *lowSpchar = [[NSMutableArray alloc] initWithObjects:@"q",@"w",@"e",@"r",@"t",@"y",@"u",@"i",@"o",@"p",@"a",@"s",@"d",@"f",@"g",@"h",@"j",@"k",@"l",@"z",@"x",@"c",@"v",@"b",@"n",@"m",@"11", nil];
    m_lowcharArray = [[NSArray alloc] initWithArray:[self randomWithArray:lowSpchar]];
    
    NSInteger tagIndex = 10;
    
    CGFloat letterWidth = self.frame.size.width/10;
    
    for (int i = 0; i < 3; i++){
        switch (i) {
            case 0:
            {
                NSUInteger letterIndex = 10;
                for (int j = 0; j < letterIndex; j++) {
                    CGRect rect = CGRectMake(3+j*letterWidth, 5+i*45, letterWidth-5, 35);
                    MBSKeyButtons *keyBtn = [[MBSKeyButtons alloc] initWithFrame:rect  tag:tagIndex delegate:self];
                    [m_letterBtnsArray addObject:keyBtn];
                    [m_letterKeyView addSubview:keyBtn];
                    tagIndex++;
                }
                break;
            }
                
            case 1:
            {
                
                NSUInteger letterIndex = 9;
                CGFloat edge = (self.frame.size.width - letterWidth*letterIndex)/2;
                for (int j = 0; j < 9; j++) {
                    CGRect rect = CGRectMake(edge+j*letterWidth, 5+i*45, letterWidth-5, 35);
                    MBSKeyButtons *keyBtn = [[MBSKeyButtons alloc] initWithFrame:rect tag:tagIndex delegate:self];
                    [m_letterBtnsArray addObject:keyBtn];
                    [m_letterKeyView addSubview:keyBtn];
                    tagIndex++;
                }
                break;
            }
                
            case 2:
            {
                CGFloat edge = (self.frame.size.width-letterWidth*7)/2;
                for (int j = 0; j < 7; j++) {
                    CGRect rect = CGRectMake(edge+j*letterWidth, 5+i*45, letterWidth-5, 35);
                    MBSKeyButtons *keyBtn = [[MBSKeyButtons alloc] initWithFrame:rect tag:tagIndex delegate:self];
                    [m_letterBtnsArray addObject:keyBtn];
                    [m_letterKeyView addSubview:keyBtn];
                    tagIndex++;
                }
                break;
            }
                
            default:
                break;
        }
        
    }
    
    m_charBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    m_charBtn.frame = CGRectMake(2, 95, 40, 35);
    m_charBtn.tag = 1006;
    [m_charBtn setBackgroundImage:[UIImage imageNamed:@"CPSSDKImages.bundle/key_switch_low.png"] forState:UIControlStateNormal];
    [m_charBtn setBackgroundImage:[UIImage imageNamed:@"CPSSDKImages.bundle/key_switch_caps.png"] forState:UIControlStateHighlighted];
    [m_charBtn addTarget:self action:@selector(changeKeyTypeOfChar:) forControlEvents:UIControlEventTouchUpInside];
    [m_letterKeyView addSubview:m_charBtn];
    
    UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    deleteBtn.frame = CGRectMake(self.frame.size.width-42, 95, 40, 35);
    deleteBtn.tag = 1005;
    [deleteBtn setBackgroundColor:kb_color_rgb(166, 166, 166, 1.0f)];
//    [deleteBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [deleteBtn setTitleColor:kb_color_rgb(128, 128, 128, 1.0f) forState:UIControlStateHighlighted];
    deleteBtn.layer.cornerRadius = 2.0f;
//    [deleteBtn setTitle:@"<---" forState:UIControlStateNormal];
    [deleteBtn setImage:[UIImage imageNamed:@"CPSSDKImages.bundle/key_dig_delete_normal"] forState:UIControlStateNormal];
    [deleteBtn setImage:[UIImage imageNamed:@"CPSSDKImages.bundle/key_dig_delete_clicked"] forState:UIControlStateHighlighted];
    [deleteBtn addTarget:self action:@selector(keyButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [m_letterKeyView addSubview:deleteBtn];
    
    
    UIButton *swithBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    swithBtn.frame = CGRectMake(2, 142, 70, 33);
    swithBtn.tag = 1012;
    [swithBtn setTitle:@".?123" forState:UIControlStateNormal];
    [swithBtn setBackgroundColor:kb_color_rgb(166, 166, 166, 1.0f)];
    [swithBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [swithBtn setTitleColor:kb_color_rgb(128, 128, 128, 1.0f) forState:UIControlStateHighlighted];
    swithBtn.layer.cornerRadius = 2.0f;
    [swithBtn addTarget:self action:@selector(keyButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [m_letterKeyView addSubview:swithBtn];
    
    UIButton *spaceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    spaceBtn.frame = CGRectMake(85, 142, self.frame.size.width-85-72-12, 33);
    spaceBtn.tag = 1014;
    [spaceBtn setBackgroundImage:[UIImage imageNamed:@"CPSSDKImages.bundle/key_blank_normal.png"] forState:UIControlStateNormal];
    [spaceBtn setBackgroundImage:[UIImage imageNamed:@"CPSSDKImages.bundle/key_blank_pressed.png"] forState:UIControlStateHighlighted];
    [spaceBtn addTarget:self action:@selector(keyButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [m_letterKeyView addSubview:spaceBtn];
    
    UIButton *signBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    signBtn.frame = CGRectMake(self.frame.size.width-72, 142, 70, 33);
    signBtn.tag = 1016;
    [signBtn setTitle:@"#+=" forState:UIControlStateNormal];
    [signBtn setBackgroundColor:kb_color_rgb(166, 166, 166, 1.0f)];
    [signBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [signBtn setTitleColor:kb_color_rgb(128, 128, 128, 1.0f) forState:UIControlStateHighlighted];
    signBtn.layer.cornerRadius = 2.0f;
    [signBtn addTarget:self action:@selector(keyButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [m_letterKeyView addSubview:signBtn];
    
}

//初始化数字和字符键盘数据和键盘按钮
- (void)signKeyBoradView{
    NSMutableArray *specialSpchar1 = [[NSMutableArray alloc] initWithObjects:@"[",@"]",@"{",@"}",@"#",@"%",@"^",@"*",@"+",@"=",@"_",@"\"", @"|",@"~",@"<",@">",@"€",@"£",@"¥",@"'",@"-",@"\\",@":",@";",@"(",@")",@"$",@"&",@"11",nil];
    NSArray *sRandomArray = [self randomWithArray:specialSpchar1];
    
    m_specialCharArray = [[NSMutableArray alloc] initWithArray:sRandomArray];
    
    CGFloat signKeyWidth = self.frame.size.width/10;
    NSInteger tagIndex = 100;
    for (int i = 0; i < 3; i++){
        for (int j = 0; j < 10; j++) {
            if (i == 2 && j >=8) {
                break;
            }
            MBSKeyButtons *keyBtn = [[MBSKeyButtons alloc] initWithFrame:CGRectMake(3+j*signKeyWidth, 5+i*45, signKeyWidth-5, 35)
                                                                     tag:tagIndex delegate:self];
            
            [m_signBtnsArray addObject:keyBtn];
            [m_signKeyView addSubview:keyBtn];
            tagIndex++;
        }
        
    }
    
    
    UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    deleteBtn.frame = CGRectMake(self.frame.size.width-signKeyWidth*2+5, 95, signKeyWidth*2-10, 35);
    deleteBtn.tag = 1004;
    [deleteBtn setBackgroundImage:[UIImage imageNamed:@"CPSSDKImages.bundle/key_delete_normal.png"] forState:UIControlStateNormal];
    [deleteBtn setBackgroundImage:[UIImage imageNamed:@"CPSSDKImages.bundle/key_delete_pressed.png"] forState:UIControlStateHighlighted];
    [deleteBtn addTarget:self action:@selector(keyButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [m_signKeyView addSubview:deleteBtn];
    
    UIButton *swithBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    swithBtn.frame = CGRectMake(2, 142, 70, 33);
    swithBtn.tag = 1013;
    [swithBtn setTitle:@".?123" forState:UIControlStateNormal];
    [swithBtn setBackgroundColor:kb_color_rgb(166, 166, 166, 1.0f)];
    [swithBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [swithBtn setTitleColor:kb_color_rgb(128, 128, 128, 1.0f) forState:UIControlStateHighlighted];
    swithBtn.layer.cornerRadius = 2.0f;
    [swithBtn addTarget:self action:@selector(keyButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [m_signKeyView addSubview:swithBtn];
    
    UIButton *spaceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    spaceBtn.frame = CGRectMake(85, 142, self.frame.size.width-85-72-12, 33);
    spaceBtn.tag = 1015;
    [spaceBtn setBackgroundImage:[UIImage imageNamed:@"CPSSDKImages.bundle/key_blank_normal.png"] forState:UIControlStateNormal];
    [spaceBtn setBackgroundImage:[UIImage imageNamed:@"CPSSDKImages.bundle/key_blank_pressed.png"] forState:UIControlStateHighlighted];
    [spaceBtn addTarget:self action:@selector(keyButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [m_signKeyView addSubview:spaceBtn];
    
    UIButton *signBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    signBtn.frame = CGRectMake(self.frame.size.width-72, 142, 70, 33);
    signBtn.tag = 1017;
    [signBtn setTitle:@"abc" forState:UIControlStateNormal];
    [signBtn setBackgroundColor:kb_color_rgb(166, 166, 166, 1.0f)];
    [signBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [signBtn setTitleColor:kb_color_rgb(128, 128, 128, 1.0f) forState:UIControlStateHighlighted];
    signBtn.layer.cornerRadius = 2.0f;
    [signBtn addTarget:self action:@selector(keyButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [m_signKeyView addSubview:signBtn];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIImageView *backgroundView = [[UIImageView alloc] initWithFrame:
                                       CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        backgroundView.image = [UIImage imageNamed:@"CPSSDKImages.bundle/keyboard_bg_down.png"];
        [self addSubview:backgroundView];
        
        
        m_letterKeyView = [[UIView alloc] initWithFrame:CGRectMake(0, 46, self.frame.size.width, self.frame.size.height-46)];
        m_signKeyView = [[UIView alloc] initWithFrame:CGRectMake(0, 46, self.frame.size.width, self.frame.size.height-46)];
        m_numberKeyView = [[UIView alloc] initWithFrame:CGRectMake(0, 46, self.frame.size.width, self.frame.size.height-46)];
        
        m_letterBtnsArray = [[NSMutableArray alloc] init];
        m_signBtnsArray = [[NSMutableArray alloc] init];
        m_numBtnsArray = [[NSMutableArray alloc] init];
        
        [self letterKeyBoradView];   //设置字母键盘
        [self signKeyBoradView];     //设置字符键盘
        [self numberKeyBoardView];    //设置数字键盘
        
        currentKeyType = LOWCHARS;
        [self initKeyBoard];
        m_currentView = m_letterKeyView;//键盘view
        [self addSubview:m_currentView];
        
        UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelBtn.frame = CGRectMake(5, 6, 60, 30);
        cancelBtn.tag = 1007;
        cancelBtn.layer.cornerRadius = 4.0f;
        cancelBtn.layer.borderWidth = 1.0f;
        cancelBtn.layer.borderColor = kb_color_rgb(209, 209, 209, 1.0f).CGColor;
        [cancelBtn setTitle:@"Cancel" forState:UIControlStateNormal];
        [cancelBtn setTitleColor:kb_color_rgb(138, 138, 138, 1.0f) forState:UIControlStateNormal];
        [cancelBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
        [cancelBtn addTarget:self action:@selector(keyButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cancelBtn];
        
        UIButton *doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        doneBtn.frame = CGRectMake(self.frame.size.width-50-5, 6, 50, 30);
        doneBtn.tag = 1009;
        doneBtn.layer.cornerRadius = 4.0f;
        doneBtn.layer.borderWidth = 1.0f;
        doneBtn.layer.borderColor = kb_color_rgb(209, 209, 209, 1.0f).CGColor;
        [doneBtn setTitle:@"OK" forState:UIControlStateNormal];
        [doneBtn setTitleColor:kb_color_rgb(138, 138, 138, 1.0f) forState:UIControlStateNormal];
        [doneBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
        [doneBtn addTarget:self action:@selector(keyButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:doneBtn];
        
        UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, self.frame.size.width, 1.0f)];
        line.backgroundColor = kb_color_rgb(226, 226, 226, 1.0f);
        [self addSubview:line];
        
        zoomBtn = [[UIButton alloc] init];
        [zoomBtn setBackgroundImage:[UIImage imageNamed:@"CPSSDKImages.bundle/按下弹出按钮.png"] forState:UIControlStateNormal];
    }
    return self;
}

- (void)changeKeyType:(MBSKeyBoardType)keyType
{
    [m_currentView removeFromSuperview];
    currentKeyType = NUMBER;
    [self initKeyBoard];
    m_currentView = m_numberKeyView;
    [self addSubview:m_currentView];
    
}


//点击字母时添加放大字母视图
- (void)keyBtnPressedBegin:(MBSKeyButtons *)sender
{
    	[zoomBtn setFrame:CGRectMake(sender.frame.origin.x-4, sender.frame.origin.y-20, 35, 50)];
    	[zoomBtn setTitle:sender.m_character.text forState:UIControlStateNormal];
        [zoomBtn.titleLabel setFont:[UIFont systemFontOfSize:24]];
    	zoomBtn.contentEdgeInsets = UIEdgeInsetsMake(-3, 0, 0, 0);
    	[zoomBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    	[self addSubview:zoomBtn];
}

//移除放大字母视图
- (void)keyBtnPressedEnd
{
    	[zoomBtn removeFromSuperview];
}

-(void)keyPressedBegin:(MBSKeyButtons*)keyButton{
    [self keyBtnPressedBegin:keyButton];
    
    [keyButton.m_character setTextColor:[UIColor whiteColor]];
    [keyButton.m_imageBtn setBackgroundColor:kb_color_rgb(175, 67, 106, 1.0f)];
}

-(void)keyPressed:(MBSKeyButtons*)keyButton tag:(NSInteger)value{
    
    if (m_delegate != nil && [m_delegate respondsToSelector:@selector(didSelectKeyButton:)]) {
        [m_delegate didSelectKeyButton:keyButton.m_character.text];
    }
    [self keyBtnPressedEnd];
    //    [self performSelector:@selector(keyBtnPressedEnd) withObject:nil afterDelay:0.5];
    
    keyButton.m_character.textColor = kb_color_rgb(128, 128, 128, 1.0f);
    [keyButton.m_imageBtn setBackgroundColor:[UIColor clearColor]];
}


- (void)keyBoardBtnPressed:(UIButton *)sender{
    NSString *value = [NSString stringWithFormat:@"%@",sender.titleLabel.text];
    if (m_delegate != nil && [m_delegate respondsToSelector:@selector(didSelectKeyButton:)]) {
        [m_delegate didSelectKeyButton:value];
    }
}

- (void)keyButtonPressed:(UIButton *)sender
{
    switch (sender.tag) {
            
        case 1004:case 1005:case 1019:
        {
            if (m_delegate != nil && [m_delegate respondsToSelector:@selector(didSelectKeyButton:)]) {
                [m_delegate didSelectKeyButton:@""];
            }
            break;
        }
        case 1007:
        {
            if (m_delegate != nil && [m_delegate respondsToSelector:@selector(didCancelKeyBoard)]) {
                [m_delegate didCancelKeyBoard];
            }
            
            break;
        }
        case 1008:
        {
            if (m_delegate != nil && [m_delegate respondsToSelector:@selector(changeToSystemBoard)]) {
                [m_delegate changeToSystemBoard];
            }
            
            break;
        }
        case 1009:
        {
            if (m_delegate != nil && [m_delegate respondsToSelector:@selector(didHiddenKeyBoard)]) {
                [m_delegate didHiddenKeyBoard];
            }
            
            break;
        }
        case 1012:case 1013:
        {
            [m_currentView removeFromSuperview];
            currentKeyType = NUMBER;
            [self initKeyBoard];
            m_currentView = m_numberKeyView;
            [self addSubview:m_currentView];
            break;
        }
        case 1014:case 1015:case 1018:
        {
            if (m_delegate != nil && [m_delegate respondsToSelector:@selector(didSelectKeyButton:)]) {
                [m_delegate didSelectKeyButton:@" "];
            }
            break;
        }
        case 1016:
        {
            [m_currentView removeFromSuperview];
            currentKeyType = SPECIALCHAR;
            [self initKeyBoard];
            m_currentView = m_signKeyView;
            [self addSubview:m_currentView];
            break;
        }
        case 1017:
        {
            [m_currentView removeFromSuperview];
            currentKeyType = LOWCHARS;
            [m_charBtn setBackgroundImage:[UIImage imageNamed:@"CPSSDKImages.bundle/key_switch_low.png"] forState:UIControlStateNormal];
            [self initKeyBoard];
            m_currentView = m_letterKeyView;
            [self addSubview:m_currentView];
            break;
        }
        default:
            break;
    }
}


- (void)changeKeyTypeOfChar:(UIButton *)sender{
    switch (currentKeyType) {
            
        case UPCHARS:
        {
            currentKeyType = LOWCHARS;
            [sender setBackgroundImage:[UIImage imageNamed:@"CPSSDKImages.bundle/key_switch_low.png"] forState:UIControlStateNormal];
            [self initKeyBoard];
            break;
        }
            
        case LOWCHARS:
        {
            currentKeyType = UPCHARS;
            [sender setBackgroundImage:[UIImage imageNamed:@"CPSSDKImages.bundle/key_switch_caps.png"] forState:UIControlStateNormal];
            [self initKeyBoard];
            break;
        }
            
        default:
            break;
    }
}

- (void)changeKeyTypeOfNum:(UIButton *)sender{
    [m_currentView removeFromSuperview];
    switch (sender.tag) {
        case 1010:
        {
            currentKeyType = LOWCHARS;
            [m_charBtn setBackgroundImage:[UIImage imageNamed:@"CPSSDKImages.bundle/key_switch_low.png"] forState:UIControlStateNormal];
            [self initKeyBoard];
            m_currentView = m_letterKeyView;
            [self addSubview:m_currentView];
            break;
        }
            
        case 1011:
        {
            currentKeyType = SPECIALCHAR;
            [self initKeyBoard];
            m_currentView = m_signKeyView;
            [self addSubview:m_signKeyView];
            break;
        }
            
        default:
            break;
    }
}


- (void)initKeyBoard{
    switch (currentKeyType) {
        case NUMBER:
        {
            for (int i = 0; i < [m_numArray count]; i++) {
                if (i < [m_signBtnsArray count]) {
                    UIButton *btn = [m_numBtnsArray objectAtIndex:i];
                    [btn setTitle:[m_numArray objectAtIndex:i] forState:UIControlStateNormal];
                }
            }
            
            break;
        }
            
        case UPCHARS:
        {
            for (int i = 0; i < [m_upcharArray count]; i++) {
                if (i < [m_letterBtnsArray count]) {
                    MBSKeyButtons *btn = [m_letterBtnsArray objectAtIndex:i];
                    btn.m_character.text = [m_upcharArray objectAtIndex:i];
                }
            }
            break;
        }
            
        case LOWCHARS:
        {
            for (int i = 0; i < [m_lowcharArray count]; i++) {
                if (i < [m_letterBtnsArray count]) {
                    MBSKeyButtons *btn = [m_letterBtnsArray objectAtIndex:i];
                    btn.m_character.text = [m_lowcharArray objectAtIndex:i];
                }
            }
            break;
        }
            
        case SPECIALCHAR:
        {
            for (int i = 0; i < [m_specialCharArray count]; i++) {
                if (i < [m_signBtnsArray count]) {
                    MBSKeyButtons *btn = [m_signBtnsArray objectAtIndex:i];
                    btn.m_character.text = [m_specialCharArray objectAtIndex:i];
                }
            }
            break;
        }
            
        default:
            break;
    }
}

- (void)dealloc{
    //    [m_letterBtnsArray release];
    //    [m_signBtnsArray release];
    //    [m_numberKeyView release];
    //    [m_upcharArray release];
    //    [m_lowcharArray release];
    //    [m_numArray release];
    //    [m_specialCharArray release];
    //    [super dealloc];
}


@end
