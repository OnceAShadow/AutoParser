//  Model File Implementation
//
//  Created by API Crossroads
//  Copyright © 2016 API Crossroads. All rights reserved.

#import "GeoEarthQuake.h"

@implementation GeoEarthQuake

-(instancetype) init {
    self = super.init;
    
    self.id = @"";
    self.longitude = 0;
    self.latitude = 0;
    self.depth = 0;
    self.mag = 0;
    
    self.place = @"";
    self.time = 0;
    self.updated = 0;
    self.tz = 0;
    self.url = @"";
    self.detail = @"";
    self.felt = 0;
    self.cdi = 0;
    self.mmi = 0;
    self.alert = @"";
    
    self.status = @"";
    self.tsunami = 0;
    self.sig = 0;
    self.net = @"";
    self.code = @"";
    self.ids = @"";
    self.sources = @"";
    self.types = @"";
    self.nst = 0;
    self.dmin = 0;
    self.rms = 0;
    self.gap = 0;
    self.magType = @"";
    self.type = @"";
    self.title = @"";
    
    return self;
}

@end
