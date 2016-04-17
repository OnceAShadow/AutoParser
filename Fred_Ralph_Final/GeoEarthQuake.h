//  GeoEarthQuake.h
//  EQ
//
//  Created by admin on 4/14/16.
//  Copyright © 2016 admin. All rights reserved.


#import <Foundation/Foundation.h>

@interface GeoEarthQuake : NSObject

@property(nonatomic, strong) NSString*  id;
@property float longitude;
@property float latitude;
@property float depth;
@property float mag;

@property(nonatomic, strong) NSString*  place;
@property long time;
@property long updated;
@property int tz;
@property(nonatomic, strong) NSString*  url;
@property(nonatomic, strong) NSString*  detail;
@property int felt;
@property float cdi;
@property float mmi;
@property(nonatomic, strong) NSString*  alert;
@property(nonatomic, strong) NSString*  status;
@property int tsunami;
@property int sig;
@property(nonatomic, strong) NSString*  net;
@property(nonatomic, strong) NSString*  code;
@property(nonatomic, strong) NSString*  ids;
@property(nonatomic, strong) NSString*  sources;
@property(nonatomic, strong) NSString*  types;
@property int nst;
@property float dmin;
@property float rms;
@property float gap;
@property(nonatomic, strong) NSString*  magType;
@property(nonatomic, strong) NSString*  type;
@property(nonatomic, strong) NSString*  title;

@end
