//
//  HCKeyPath.h
//  iOS
//
//  Created by aStudyer on 2019/9/10.
//  Copyright © 2019 com.aStudyer. All rights reserved.
//

#ifndef HCKeyPath_h
#define HCKeyPath_h

////////////////////////////////////////
////                                ////
////    Key Path creation Macros    ////
////                                ////
////////////////////////////////////////

/**
 *  Convenience macros for creating keypaths. An invalid keypath will throw a compile-time error when compiling in debug mode.
 *
 *  The first parameter of these macros is used only for compile-time validation of the keypath.
 *
 *  @return An NSString containing the keypath.
 *
 *  @example HC_KP(NSObject, description.length) -> @"description.length"
 *           HC_KP_OBJ(MyLabel, text)            -> @"text"
 *           HC_KP_SELF(user.firstName)          -> @"user.firstName"
 */
#if DEBUG
#define HC_KP(Classname, keypath) ({\
Classname *_XM_keypath_obj; \
__unused __typeof(_XM_keypath_obj.keypath) _XM_keypath_prop; \
@#keypath; \
})

#define HC_KP_OBJ(object, keypath) ({\
__typeof(object) _XM_keypath_obj; \
__unused __typeof(_XM_keypath_obj.keypath) _XM_keypath_prop; \
@#keypath; \
})

#define HC_KP_PROTOCOL(ProtocolName, keypath) ({\
id<ProtocolName> _XM_keypath_obj; \
__unused __typeof(_XM_keypath_obj.keypath) _XM_keypath_prop; \
@#keypath; \
})
#else
#define HC_KP(Classname, keypath) (@#keypath)
#define HC_KP_OBJ(self, keypath) (@#keypath)
#define HC_KP_PROTOCOL(ProtocolName, keypath) (@#keypath)
#endif

/**
 *  @note This macro will implicitly retain self from within blocks while running in debug mode.
 *  The safe way to generate a keypath on self from  within a block
 *  is to define a weak reference to self outside the block, and then use HC_KP_OBJ(weakSelf, keypath).
 */
#define HC_KP_SELF(keypath) HC_KP_OBJ(self, keypath)

/**
 *  Concatenate two keypath strings.
 *
 *  keypath1 and keypath2 must be NSStrings like, for example, the ones created by the other HC keypath generation macros.
 *  The result is another NSString concatenating the two keypaths, but there is no implicit check that the key path exists.
 */
#define HC_KP_CONCAT(keypath1, keypath2) [keypath1 stringByAppendingFormat:@".%@", keypath2]

#endif /* HCKeyPath_h */
