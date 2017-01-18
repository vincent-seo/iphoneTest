//
//  AppDelegate.h
//  iphoneTest
//
//  Created by MANSHENG XU on 1/16/17.
//  Copyright © 2017 MANSHENG XU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

