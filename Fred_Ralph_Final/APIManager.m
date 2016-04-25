//
//  APIManager.m
//  Fred_Ralph_Final
//
//  Created by Rafael Flores on 4/19/16.
//  Copyright © 2016 MAE. All rights reserved.
//

#import "APIManager.h"



@implementation API


- (NSString *) stringAPIRepresentation{
    
    NSMutableString * stringRepresentation = [NSMutableString new];

    return stringRepresentation;
    
    
}
- (NSString *) jsonAPIRepresentation{
    NSMutableString * jsonRepresentation = [NSMutableString new];
    
    return jsonRepresentation;
}

- (NSData *) serializableAPIRepresentation{
    NSMutableData * dataRepresentation = [NSMutableData new];
    
    return dataRepresentation;

}

@end




@interface APIValue()
@end

@implementation APIValue
- (NSString*) outputAsString{
    
    return @"";
    
}
- (enum APIPropertyType) APIValueType{
    return APIPropertyTypeId;
    
}

- (id) value{
    return nil;
    
}


@end







@interface APIObjectValue()
@end
@implementation APIObjectValue
- (NSString*) outputAsString{
    
    NSString *apiObject;
    
    return apiObject;

}
- (enum APIPropertyType) APIValueType{
    return APIPropertyTypeDictionary;

}

- (id) value{
    return self.objectValue;
    
}


@end


@interface APIArrayValue()
@end

@implementation APIArrayValue
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.arrayValue = [NSMutableArray array];
    }
    return self;
}
- (NSString*) outputAsString{
    
    NSString *apiObject;
    
    return apiObject;
    
}
- (enum APIPropertyType) APIValueType{
    return APIPropertyTypeDictionary;
    
}

- (id) value{
    return self.arrayValue;
    
}


@end







@interface APIStringValue()


@end



@implementation APIStringValue
- (NSString*) outputAsString{
    
    NSString *apiObject;
    
    return apiObject;
    
}
- (enum APIPropertyType) APIValueType{
    return APIPropertyTypeDictionary;
    
}

- (id) value{
    return self.stringValue;
    
}
@end




@interface APIBoolValue ()
@end

@implementation APIBoolValue

- (NSString*) outputAsString{
    
    NSString *apiObject;
    
    return apiObject;
    
}
- (enum APIPropertyType) APIValueType{
    return APIPropertyTypeDictionary;
    
}

- (id) value{
    return self.boolValue;
    
}

@end






@interface APINumberValue ()
@end


@implementation APINumberValue

- (NSString*) outputAsString{
    
    NSString *apiObject;
    
    return apiObject;
    
}
- (enum APIPropertyType) APIValueType{
    return APIPropertyTypeDictionary;
    
}

- (id) value{
    return self.numberValue;
    
}
@end


@interface APIEmptyOrNullValue ()
@end

@implementation APIEmptyOrNullValue

- (NSString*) outputAsString{
    
    NSString *apiObject;
    
    return apiObject;
    
}
- (enum APIPropertyType) APIValueType{
    return APIPropertyTypeString;
    
}

- (id) value{
    return nil;
    
}
@end





