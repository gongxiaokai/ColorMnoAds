//
//  CoreDataOperations.m
//  ColorM
//
//  Created by gongwenkai on 2017/1/30.
//  Copyright © 2017年 gongwenkai. All rights reserved.
//

#import "CoreDataOperations.h"

@implementation CoreDataOperations
static CoreDataOperations *instance = nil;

+ (instancetype)sharedInstance
{
    return [[CoreDataOperations alloc] init];
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [super allocWithZone:zone];
    });
    return instance;
}

- (instancetype)init
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [super init];
        if (instance) {
            instance.managedObjectContext = ((AppDelegate*)[UIApplication sharedApplication].delegate).persistentContainer.viewContext;
        }
    });
    return instance;
}

//保存颜色 添加到收藏列表
- (void)saveColorOX:(NSString*)oxStr andRGB:(NSString*)rgbStr{
    Fav *fav = [[Fav alloc] initWithContext:self.managedObjectContext];
    fav.colorOX = oxStr;
    fav.colorRGB = rgbStr;
    fav.timestamp = [NSDate date];
    fav.colorID = [NSString stringWithFormat:@"%@", [fav objectID]];
    [self.managedObjectContext save:nil];
}

//列出收藏颜色
- (NSArray*)showFavList{
    NSFetchRequest *fetchRequest = [Fav fetchRequest];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"timestamp"
                                                                   ascending:NO];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObjects:sortDescriptor, nil]];
    
    NSError *error = nil;
    NSArray *fetchedObjects = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    return fetchedObjects;
}


//删除
- (void)deleteWithModel:(ColorFavCellModel*)model{
    
    NSFetchRequest *fetchRequest = [Fav fetchRequest];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"colorID = %@",model.colorID ];
    [fetchRequest setPredicate:predicate];
  
    NSError *error = nil;
    NSArray *fetchedObjects = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    [self.managedObjectContext deleteObject:[fetchedObjects firstObject]];
    [self.managedObjectContext save:nil];

}

- (int)isBuyNoAds {
    NSFetchRequest *fetchRequest = [User fetchRequest];
    NSError *error = nil;
    NSArray *fetchedObjects = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    User *user = [fetchedObjects firstObject];
    
    return user.isBuy;


}


- (void)buyNoAds {
    NSFetchRequest *fetchRequest = [User fetchRequest];
    NSArray *fetchedObjects = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
    User *user;
    if (fetchedObjects.count > 0) {
        user = fetchedObjects.firstObject;
    }else{
        user = [[User alloc] initWithContext:self.managedObjectContext];
    }
    user.isBuy = 1;
    [self.managedObjectContext updatedObjects];

}
@end
