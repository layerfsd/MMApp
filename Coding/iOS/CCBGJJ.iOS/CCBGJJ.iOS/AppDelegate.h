//
//  AppDelegate.h
//  CCBGJJ.iOS
//
//  Created by Sam Yu on 2/20/17.
//  Copyright © 2017 CCB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

