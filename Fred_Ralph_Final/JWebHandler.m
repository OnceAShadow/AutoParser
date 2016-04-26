//  JWebHandler.m
//  AutoParser
//
//  Created by admin on 4/18/16.
//  Copyright © 2016 admin. All rights reserved.

#import "JWebHandler.h"
#import "JNode.h"

@implementation JWebHandler
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

+ (id)sharedJWebHandler {
    static JWebHandler *sharedJWebHandler = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedJWebHandler = [[self alloc] init];
    });
    return sharedJWebHandler;
}

JNode* bestArrayLocation;

int bestArraySize;
int bestObjSize;

NSString* nameOfArray;

- (NSError*) autoParse:(NSString*)urlString{
    
    NSURL *url = [NSURL URLWithString:urlString];
    self.webString = urlString;
    
    
    bestArraySize = 0;
    bestObjSize = 0;
    
    self.treeRoot = [JNode new];
    
    NSError* treeError = [NSError new];
    treeError = nil;
    
    NSData* BeerData = [NSData dataWithContentsOfURL:url];
    NSError *error;
    NSDictionary *root = [NSJSONSerialization JSONObjectWithData:BeerData options:NSJSONReadingAllowFragments error:&error];

    if ( error != nil){
        treeError = error;
    }else{
        if( [root isKindOfClass:[NSDictionary class]] ){
            
            self.treeRoot = [[self class] treeBuilder:NULL theData:root keyName: [NSString stringWithFormat:@"root"]];
            
            [[self class] trimTree];
            
        }else if ( [root isKindOfClass:[NSArray class]] ){
            treeError = [NSError errorWithDomain:@"Response is not a Dictionary" code:404 userInfo:nil];

        }else{
            treeError = [NSError errorWithDomain:@"Response is not valid" code:404 userInfo:nil];
        }
        //NSLog(@"Best Array for the job is: %@", nameOfArray );
    }

    return treeError;
}

+(JNode*) treeBuilder:(JNode*)parent theData:(NSObject*)jData keyName:(NSString*)name{
    JNode* newNode = [[JNode alloc] initWithNode:parent];
    newNode.name = name;
    
    if( [jData isKindOfClass:[NSDictionary class]] ){
        newNode.type = @"NSDictionary";
        NSArray* keys = [(NSDictionary*)jData allKeys];
        
        for(int i = 0; i < keys.count; ++i){
            JNode* tempNode = [self treeBuilder:newNode theData:[(NSDictionary*)jData objectForKey:keys[i]] keyName:keys[i]];
            if ( tempNode != NULL ){
                [[newNode children] addObject:tempNode];
            }
        }
        
    }else if ( [jData isKindOfClass:[NSArray class]] ){
        
        newNode.type = @"NSArray";
        
        NSArray* arr = (NSArray*)jData;
        if( arr.count > 0 && [arr[0] isKindOfClass:[NSDictionary class]]){
            
            if( [self validateArray:(NSArray*)jData] ){
                bestArrayLocation = newNode;
                nameOfArray = name;
            }

            if( arr.count == 1){
                [[newNode children] addObject:[self treeBuilder:newNode theData:arr[0] keyName:@"NSDictionary"]];
            }else{
                
                [[newNode children] addObject:[self concatArrayValues:newNode theData:(NSArray*)jData keyName:@"NSDictionary"]];
            }
        }else if (arr.count > 0){
            if( [arr[0] isKindOfClass:[NSNumber class]] ){
                JNode* extraNode = [[JNode alloc] initWithNode:newNode];
                extraNode.name = @"Array Element";
                extraNode.type = @"NSNumber";
                
            }else if ( [arr[0] isKindOfClass:[NSString class]] ){
                JNode* extraNode = [[JNode alloc] initWithNode:newNode];
                extraNode.name = @"Array Element";
                extraNode.type = @"NSString";
            }
        }
        
    }else if( [jData isKindOfClass:[NSNumber class]] ){
        newNode.type = @"NSNumber";
    }else if( [jData isKindOfClass:[NSString class]] ){
        newNode.type = @"NSString";
    }else{
        return NULL;
    }

    return newNode;
}

+(BOOL) validateArray:(NSArray*)array {
    
    if( array.count > 0 ){
        if( [array[0] isKindOfClass:[NSDictionary class]] ){
            if ( array.count >= bestArraySize ){
                
                NSArray* keys = [(NSDictionary*)array[0] allKeys];
                if( keys.count > bestObjSize ){
                    
                    bestArraySize = (int)array.count;
                    bestObjSize = (int)keys.count;
                    
                    return true;
                }
            }
        }
    }
    return false;
}

+(JNode*) concatArrayValues: (JNode*)parent theData:(NSArray*)array keyName:(NSString*)name {

    JNode* newNode = [[JNode alloc] initWithNode:parent];
    newNode = [self treeBuilder:parent theData:array[0] keyName:@"NSDictionary"];
    
    return newNode;
}

+(void) trimTree{
    bool finished = false;
    bestArrayLocation.name = @"MainArray";
    
    JNode* nodePointer = bestArrayLocation;
    
    while (!finished){
        JNode* tempNode = nodePointer;
        nodePointer = nodePointer.parent;
        
        if( [nodePointer.type isEqualToString:@"NSDictionary"]){
            [nodePointer.children removeAllObjects];
            [nodePointer.children addObject:tempNode];
        }
        if ( nodePointer.parent == NULL ) finished = true;
    }
}

@end