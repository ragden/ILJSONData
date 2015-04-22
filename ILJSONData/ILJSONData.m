//
//  ILJSONData.m
//  ILJSONData
//
//  Created by Edgar Paz on 30/09/14.
//  Copyright (c) 2014 Edgar Paz. All rights reserved.
//

#import "ILJSONData.h"
#import <objc/runtime.h>

static void *ILJSONDataKey = &ILJSONDataKey;

@interface ILJSONData ()

@end

@implementation ILJSONData

- (id) initWithDictionary: (NSDictionary*) dictionary
{
    self = [super init];
    if (self){
        NSDictionary* matchNames = [self matchPropertyNames];
        for (NSString* key in dictionary.allKeys){
            NSString* Key = key;
            @try{
                if (matchNames && [matchNames.allKeys containsObject:key]) Key = [matchNames objectForKey:key];
                if ([[dictionary objectForKey:key] isKindOfClass:[NSDictionary class]]){
                    if ([[[self matchPropertyClasses] allKeys] containsObject:Key])
                        [self setValue:[[[[self matchPropertyClasses] objectForKey:Key] alloc] initWithDictionary:[dictionary objectForKey:key]] forKey:Key];
                }
                else if ([[dictionary objectForKey:key] isKindOfClass:[NSArray class]]){
                    NSArray* array = [dictionary objectForKey:key];
                    NSMutableArray *result = [[NSMutableArray alloc] init];
                    for (int i = 0; i < array.count; ++i) {
                        if ([[[self matchPropertyClasses] allKeys] containsObject:Key])
                            [result addObject:[[[[self matchPropertyClasses] objectForKey:Key] alloc] initWithDictionary:[array objectAtIndex:i]]];
                    }
                    [self setValue:result.copy forKey:Key];
                }
                else if (![[dictionary objectForKey:Key] isEqual:[NSNull null]]){
                    [self setValue:[dictionary objectForKey:key] forKey:Key];
                }
            }
            @catch (NSException* e){
                if (DEBUG)
                    NSLog(@"Property %@ doesn't exists in Data Model", key);
                [self errorMatchingForKey:key withKeyData:[dictionary objectForKey:key]];
            }
            
            
            
        }
    }
    return self;
}

- (id) initWithData:(NSData *)data withError:(NSError *__autoreleasing *)error{
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data //1
                                                         options:kNilOptions
                                                           error:error];
    
    self = [self initWithDictionary:json];
    
    return self;
}

- (NSDictionary*) matchPropertyNames{
    return nil;
}

- (NSDictionary*) matchPropertyClasses{
    return nil;
}

- (NSDictionary *)convertDataModelToJSON{
    NSDictionary* matchNames = [self matchPropertyNames];
    if (!matchNames) return nil;
    NSMutableDictionary* result = [[NSMutableDictionary alloc] init];
    for (NSString* key in matchNames.allKeys){
        @try {
            id object = [self valueForKey:[matchNames objectForKey:key]];
            if (!object) [result setObject:@"" forKey:key];
            else {
                if ([[object class] isSubclassOfClass:[ILJSONData class]]){
                    [result setObject:[object convertDataModelToJSON] forKey:key];
                }
                else if ([object isKindOfClass:[NSArray class]]){
                    NSMutableArray* array = [[NSMutableArray alloc] init];
                    for (id element in object) {
                        if ([[element class] isSubclassOfClass:[ILJSONData class]]){
                            [array addObject:[element convertDataModelToJSON]];
                        }
                        else{
                            [array addObject:element];
                        }
                    }
                    [result setObject:array forKey:key];
                }
                else{
                    [result setObject:object forKey:key];
                }
            }
        }
        @catch (NSException *exception) {
            NSLog(@"Property %@ can't be inserted in JSON", key);
        }
        @finally {
            
        }
        
    }
    
    return result.copy;
}

+ (NSSet *)propertyKeys{
    //cacheamos las propiedades
    NSSet *cachedKeys = objc_getAssociatedObject(self, ILJSONDataKey);
    if (cachedKeys != nil) return cachedKeys;
    
    NSMutableSet *keys = [NSMutableSet set];
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    for(i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        const char *propName = property_getName(property);
        if(propName){
            NSString *propertyName = [NSString stringWithCString:propName
                                                        encoding:[NSString defaultCStringEncoding]];
            [keys addObject:propertyName];
        }
    }
    
    free(properties);
    
    // It doesn't really matter if we replace another thread's work, since we do
    // it atomically and the result should be the same.
    objc_setAssociatedObject(self, ILJSONDataKey, keys, OBJC_ASSOCIATION_COPY);
    return keys;
}

#pragma mark - Error Methods

- (void) errorMatchingForKey: (NSString*) key withKeyData: (id) data{
    
}




@end
