//
//  NGNAbstractService.h
//  ShoppingCart
//
//  Created by Alexey Stafeyev on 28.07.17.
//  Copyright © 2017 Alex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NGNServerSideLayerConstants.h"
#import "NGNBasicService.h"
#import "NGNServiceProtocol.h"

@class NGNBasicService;

/**
 Attention! Class isabstract! dont't try to create instance of class and use it
 */
@interface NGNAbstractService : NSObject <NGNServiceProtocol>

@property (strong, nonatomic) NGNBasicService *basicService;

@end
