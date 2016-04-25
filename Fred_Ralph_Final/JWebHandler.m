//  JWebHandler.m
//  AutoParser
//
//  Created by admin on 4/18/16.
//  Copyright © 2016 admin. All rights reserved.

#import "JWebHandler.h"
#import "JNode.h"

@implementation JWebHandler

JNode* treeRoot;
JNode* bestArrayLocation;

int bestArraySize;
int bestObjSize;

NSString* nameOfArray;

+(void) autoParse:(NSString*)urlString{
    
    NSURL *url = [NSURL URLWithString:urlString];
    bestArraySize = 0;
    bestObjSize = 0;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        NSData* BeerData = [NSData dataWithContentsOfURL:url];
        NSError *error;
        NSDictionary *root = [NSJSONSerialization JSONObjectWithData:BeerData options:NSJSONReadingAllowFragments error:&error];
        
        if( [root isKindOfClass:[NSDictionary class]] ){
            NSLog(@"root is a NSDictionary");
            
            treeRoot = [self treeBuilder:NULL theData:root keyName: [NSString stringWithFormat:@"root"]];
            
            [self trimTree];
            
        }else if ( [root isKindOfClass:[NSArray class]] ){
            NSLog(@"root is a NSArray");
            
        }else{
            NSLog(@"Something is wrong with root!!");
        }
        NSLog(@"Best Array for the job is: %@", nameOfArray );
    });
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
        }
        
    }else if( [jData isKindOfClass:[NSNumber class]] ){
        newNode.type = @"NSNumber";
    }else if( [jData isKindOfClass:[NSString class]] ){
        newNode.type = @"NSString";
    }else{
        NSLog(@"-= %@ Is not being recognized!!=-", name);
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
    [[newNode children] addObject:[self treeBuilder:newNode theData:array[0] keyName:@"NSDictionary"]];
    
    //for(int i = 1; i < array.count ; ++i){
        
    //}
    
    return newNode;
}

+(void) trimTree{
    bool finished = false;
    
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