//
//  AppDelegate.h
//  MMApp.iOS
//
//  Created by Sam Yu on 3/7/17.
//  Copyright © 2017 LLBT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

