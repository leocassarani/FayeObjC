//
//  Channels.h
//  FayeObjc
//
//  Created by Leo Cassarani on 19/11/2011.
//  Copyright (c) 2011 Leo Cassarani. All rights reserved.
//

#import <Foundation/Foundation.h>

// Bayeux protocol channels
#define HANDSHAKE_CHANNEL @"/meta/handshake"
#define CONNECT_CHANNEL @"/meta/connect"
#define DISCONNECT_CHANNEL @"/meta/disconnect"
#define SUBSCRIBE_CHANNEL @"/meta/subscribe"
#define UNSUBSCRIBE_CHANNEL @"/meta/unsubscribe"