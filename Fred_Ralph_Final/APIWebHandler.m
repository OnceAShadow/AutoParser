//  APIWebHandler.m
//  EQ
//
//  Created by admin on 4/14/16.
//  Copyright © 2016 admin. All rights reserved.

#import "APIWebHandler.h"
#import "GeoEarthQuake.h"

static NSString * const EQ_URL = @"http://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_week.geojson";

@implementation APIWebHandler

+(NSMutableArray*) requestEQList{
    
    NSMutableArray *earthQuakes = [NSMutableArray new];
    
    NSString* strURL = [NSString stringWithFormat:EQ_URL];
    NSURL *url = [NSURL URLWithString:strURL];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        NSData* EQData = [NSData dataWithContentsOfURL:url];
        NSError *error;
        NSDictionary *root = [NSJSONSerialization JSONObjectWithData:EQData options:NSJSONReadingAllowFragments error:&error];
        
        if(error){
            NSLog(@"Error With Serialization!!");
        }else{
            NSDictionary *array = root[@"features"];
            
            for (NSDictionary* f in array){
                GeoEarthQuake* eq = [GeoEarthQuake new];
                
                [eq setId: f[@"id"]];
                
                NSDictionary* geo = f[@"geometry"];
                NSArray* coords = geo[@"coordinates"];
                
                [eq setLongitude: [coords[0] floatValue]];
                [eq setLatitude: [coords[1] floatValue]];
                [eq setDepth: [coords[2] floatValue]];
                
                NSDictionary* prop = f[@"properties"];
                
                // Extracting mag
                if (![[prop valueForKey:@"mag"] isEqual:[NSNull null]]){
                    [eq setMag:[[prop valueForKey:@"mag"]floatValue]];
                }
                
                // Extracting place
                if (![[prop valueForKey:@"place"] isEqual:[NSNull null]]){
                    [eq setPlace:[prop valueForKey:@"place"]];
                }
                
                // Extracting time
                if (![[prop valueForKey:@"time"] isEqual:[NSNull null]]){
                    [eq setTime:[[prop valueForKey:@"time"]longValue]];
                }
                
                // Extracting updated
                if (![[prop valueForKey:@"updated"] isEqual:[NSNull null]]){
                    [eq setUpdated:[[prop valueForKey:@"updated"]longValue]];
                }
                
                // Extracting tz
                if (![[prop valueForKey:@"tz"] isEqual:[NSNull null]]){
                    [eq setTz:[[prop valueForKey:@"tz"]intValue]];
                }
                
                // Extracting url
                if (![[prop valueForKey:@"url"] isEqual:[NSNull null]]){
                    [eq setUrl:[prop valueForKey:@"url"]];
                }
                
                // Extracting detail
                if (![[prop valueForKey:@"detail"] isEqual:[NSNull null]]){
                    [eq setDetail:[prop valueForKey:@"detail"]];
                }
                
                // Extracting felt
                if (![[prop valueForKey:@"felt"] isEqual:[NSNull null]]){
                    [eq setFelt:[[prop valueForKey:@"felt"]intValue]];
                }
                
                // Extracting cdi
                if (![[prop valueForKey:@"cdi"] isEqual:[NSNull null]]){
                    [eq setCdi:[[prop valueForKey:@"cdi"]floatValue]];
                }

                // Extracting mmi
                if (![[prop valueForKey:@"mmi"] isEqual:[NSNull null]]){
                    [eq setMmi:[[prop valueForKey:@"mmi"]floatValue]];
                }
                
                // Extracting alert
                if (![[prop valueForKey:@"alert"] isEqual:[NSNull null]]){
                    [eq setAlert:[prop valueForKey:@"alert"]];
                }
                
                // Extracting status
                if (![[prop valueForKey:@"status"] isEqual:[NSNull null]]){
                    [eq setStatus:[prop valueForKey:@"status"]];
                }
                
                // Extracting tsunami
                if (![[prop valueForKey:@"tsunami"] isEqual:[NSNull null]]){
                    [eq setTsunami:[[prop valueForKey:@"tsunami"]intValue]];
                }
                
                // Extracting sig
                if (![[prop valueForKey:@"sig"] isEqual:[NSNull null]]){
                    [eq setSig:[[prop valueForKey:@"sig"]intValue]];
                }
        
                // Extracting net
                if (![[prop valueForKey:@"net"] isEqual:[NSNull null]]){
                    [eq setNet:[prop valueForKey:@"net"]];
                }
                
                // Extracting code
                if (![[prop valueForKey:@"code"] isEqual:[NSNull null]]){
                    [eq setCode:[prop valueForKey:@"code"]];
                }
                
                // Extracting ids
                if (![[prop valueForKey:@"ids"] isEqual:[NSNull null]]){
                    [eq setIds:[prop valueForKey:@"ids"]];
                }
                
                // Extracting sources
                if (![[prop valueForKey:@"sources"] isEqual:[NSNull null]]){
                    [eq setSources:[prop valueForKey:@"sources"]];
                }
                
                // Extracting types
                if (![[prop valueForKey:@"types"] isEqual:[NSNull null]]){
                    [eq setTypes:[prop valueForKey:@"types"]];
                }
                
                // Extracting nts
                if (![[prop valueForKey:@"nts"] isEqual:[NSNull null]]){
                    [eq setNst:[[prop valueForKey:@"nts"]intValue]];
                }
                
                // Extracting dmin
                if (![[prop valueForKey:@"dmin"] isEqual:[NSNull null]]){
                    [eq setDmin:[[prop valueForKey:@"dmin"]floatValue]];
                }
                
                // Extracting rms
                if (![[prop valueForKey:@"rms"] isEqual:[NSNull null]]){
                    [eq setRms:[[prop valueForKey:@"rms"]floatValue]];
                }
                
                // Extracting gap
                if (![[prop valueForKey:@"gap"] isEqual:[NSNull null]]){
                    [eq setGap:[[prop valueForKey:@"gap"]floatValue]];
                }
                
                // Extracting sources
                if (![[prop valueForKey:@"sources"] isEqual:[NSNull null]]){
                    [eq setSources:[prop valueForKey:@"sources"]];
                }
                
                // Extracting magType
                if (![[prop valueForKey:@"magType"] isEqual:[NSNull null]]){
                    [eq setMagType:[prop valueForKey:@"magType"]];
                }
                
                // Extracting type
                if (![[prop valueForKey:@"type"] isEqual:[NSNull null]]){
                    [eq setType:[prop valueForKey:@"type"]];
                }
                
                // Extracting title
                if (![[prop valueForKey:@"title"] isEqual:[NSNull null]]){
                    [eq setTitle:[prop valueForKey:@"title"]];
                }
                
                [earthQuakes addObject:eq];
            }
        }
    });
    
    return earthQuakes;
}

@end