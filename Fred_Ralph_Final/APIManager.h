//
//  APIManager.h
//  Fred_Ralph_Final
//
//  Created by Rafael Flores on 4/19/16.
//  Copyright © 2016 MAE. All rights reserved.
//

#import <Foundation/Foundation.h>




/**
 *  API
 *  represents the root level and information regarding the API
 *  the api root (type ID) can be of any type value
 */
@interface API: NSObject
@property (nonatomic, assign) NSNumber *apiID;
@property (nonatomic, copy) NSString* apiName;
@property (nonatomic, copy) NSString* apiURL;

@property (nonatomic, strong) NSDictionary * arrAPIAdaptersEnabled;
@property (nonatomic, strong) id jsonRoot;

- (NSString *) stringAPIRepresentation;
- (NSString *) jsonAPIRepresentation;
- (NSData *) serializableAPIRepresentation;


@end


/**
 *  Enum to identify the type of value an object has
 */
NS_ENUM(NSInteger, APIPropertyType) {
    /**
     *  value string empty or string null
     */
    APIPropertyTypeNullorEmpty,
    /**
     *  double quoted string
     */
    APIPropertyTypeDictionary, //objects
    /**
     *  double quoted string
     */
    APIPropertyTypeArray,  //arrays
    /**
     *  double quoted string
     */
    APIPropertyTypeString,
    /**
     *  numerical value of type int
     */
    APIPropertyTypeInteger,
    /**
     *  numerical value of of type float
     */
    APIPropertyTypeFloat,
    /**
     *  numerical value of type double
     */
    APIPropertyTypeDouble,
    /**
     *  numerical value represented as NSNumber
     */
    APIPropertyTypeNumber,
    /**
     *  numerical value represented as NSDecimalNumber
     */
    APIPropertyTypeDecimalNumber,
    /**
     *  generic type of object
     */
    APIPropertyTypeId
};




/**
 *  APIValue
 *  A value can be a string in double quotes, or a number, or true or false or null, or an object or an array. These structures can be nested.
 */

@interface APIValue : NSObject

- (NSString*) outputAsString;
- (enum APIPropertyType) APIValueType;
- (id) value;

@end




#pragma mark - APIElements

/**
 *  APIObject -> Dictionary
    
    An object is an unordered set of name/value pairs. An object begins with { (left brace) and ends with } (right brace). Each name is followed by : (colon) and the name/value pairs are separated by , (comma).
 */
@interface APIObjectValue : APIValue

@property (nonatomic, strong) NSMutableDictionary *objectValue;

@end

/**
 *  APIArray -> Array
 
 An object is an unordered set of name/value pairs. An object begins with { (left brace) and ends with } (right brace). Each name is followed by : (colon) and the name/value pairs are separated by , (comma).
 */
@interface APIArrayValue : APIValue
@property (nonatomic, strong) NSMutableArray *arrayValue;


@end


/**
 *  APIString -> Array
 
 An object is an unordered set of name/value pairs. An object begins with { (left brace) and ends with } (right brace). Each name is followed by : (colon) and the name/value pairs are separated by , (comma).
 */
@interface APIStringValue : APIValue

@property (nonatomic, copy) NSMutableString *stringValue;

@end



/**
 *  APIBool -> Array
 
 An object is an unordered set of name/value pairs. An object begins with { (left brace) and ends with } (right brace). Each name is followed by : (colon) and the name/value pairs are separated by , (comma).
 */
@interface APIBoolValue : APIValue
@property (nonatomic, strong) NSNumber *boolValue; //@0 NO, @1 YES

@end


/**
 *  APINumber -> Array
 
 An object is an unordered set of name/value pairs. An object begins with { (left brace) and ends with } (right brace). Each name is followed by : (colon) and the name/value pairs are separated by , (comma).
 */
@interface APINumberValue : APIValue
@property (nonatomic, strong) NSNumber *numberValue;
@end


/**
 *  APIEmptyOrNull -> Array
 
 An object is an unordered set of name/value pairs. An object begins with { (left brace) and ends with } (right brace). Each name is followed by : (colon) and the name/value pairs are separated by , (comma).
 */
@interface APIEmptyOrNullValue : APIValue


@end








@interface APIManager : NSObject

@property (nonatomic, strong) NSMutableArray *arrAPIs;

@end
