//
//  ILJSONData.m
//  ILJSONData
//
//  Created by Edgar Paz on 30/09/14.
//  Copyright (c) 2014 Edgar Paz. All rights reserved.
//

#import "ILJSONData.h"

@interface ILJSONData ()

@end

@implementation ILJSONData

- (id) initWithDictionary: (NSDictionary*) dictionary
{
    self = [super init];
    if (self){
        //Inicializar las variables con método init
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
                    
                    //Vigilar que pasa si en vez de q los elementos del array sean objetos sean tipos primitivos
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

#pragma mark - Error Methods

- (void) errorMatchingForKey: (NSString*) key withKeyData: (id) data{
    
}




@end
