//
//  Profile.h
//  Footbook
//
//  Created by ETC ComputerLand on 8/13/14.
//  Copyright (c) 2014 cmeats. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Comment;

@interface Profile : NSManagedObject

@property (nonatomic, retain) NSString * feet;
@property (nonatomic, retain) NSString * hairiness;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSData * photo;
@property (nonatomic, retain) NSString * shoeSize;
@property (nonatomic, retain) NSString * smelliness;
@property (nonatomic, retain) NSSet *comments;
@end

@interface Profile (CoreDataGeneratedAccessors)

- (void)addCommentsObject:(Comment *)value;
- (void)removeCommentsObject:(Comment *)value;
- (void)addComments:(NSSet *)values;
- (void)removeComments:(NSSet *)values;

@end
