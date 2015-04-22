//
//  ILJSONData.h
//  ILJSONData
//
//  Created by Edgar Paz on 30/09/14.
//  Copyright (c) 2014 Edgar Paz. All rights reserved.


#import <Foundation/Foundation.h>

@interface ILJSONData : NSObject

/**
 Match Object properties with JSON in dictionary.
 @param dictionary Dictionary with parsed JSON.
 @return Instance of ILJSONData properties contains JSON info.
 **/
- (id) initWithDictionary: (NSDictionary*) dictionary;

/**
 Match Object properties with JSON in data.
 @param data NSData that contains JSON info.
 @return Instance of ILJSONData properties contains JSON info.
 **/
- (id) initWithData: (NSData*) data withError: (NSError**) error;

/**
 Return the match names for JSON properties. You must implement this method if you want to retrieve a JSON with your Data Model info or
 if you define properties with different name than JSON keys.
 @return You must return a dictionary with key name equal to json key and value equal to destiny property name.
 **/
- (NSDictionary*) matchPropertyNames;

/**
 Return the match class for JSON objects and JSON arrays.
 @return You must return a dictionary with key name equal to json key and value equal to parse class.
 **/
- (NSDictionary*) matchPropertyClasses;

/**
 Transform Data Model into NSDictionary structure. You must implement matchPropertyNames method.
 @return Dictionary with Data Model info.
 **/
- (NSDictionary*) convertDataModelToJSON;

/**
 *  Get all properties from class
 *
 *  @return Returns a NSSet with all property names of class.
 */
+ (NSSet *)propertyKeys;

#pragma mark - Error Methods

/**
 Override in your subclass this method to advise errors in JSON-property matching.
 **/
- (void) errorMatchingForKey: (NSString*) key withKeyData: (id) data;

@end
