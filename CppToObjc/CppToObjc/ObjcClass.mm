//
//  ObjcClass.m
//  CppToObjc
//
//  Created by Kai Yin on 4/22/16.
//  Copyright © 2016 kky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ObjcClass.h"
#ifdef __cplusplus
#include "CppInterface.h"
#include "CppClass.hpp"
#endif

/// implement the interface in cpp
/// note: this is an objective c++ file (*.mm, not *.m)
class ObjcImpl : public CppInterface {
public:
    void get(const std::string &url, std::function<void(HttpResponse)> callback) {
        NSURL *URL = [NSURL URLWithString:[NSString stringWithCString:url.c_str() encoding:[NSString defaultCStringEncoding]]];
        NSURLRequest *request = [NSURLRequest requestWithURL:URL];
        
        [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            HttpResponse resp = HttpResponse();
            if (error) {
                resp.error = true;
                callback(resp);
            } else {
                int16_t httpCode = [(NSHTTPURLResponse*) response statusCode];
                NSString *strData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                resp.error = false;
                resp.http_code = httpCode;
                resp.data = std::string([strData UTF8String]);;
                callback(resp);
            }
        }] resume];
    }
};

@interface ObjcClass() {
    std::function<void (HttpResponse)> callback;
    CppClass *m_p_cppClass;
}

@end

@implementation ObjcClass;

- (id)init {
    self = [super init];
    
    if (self) {
        // init the implementation obj
        std::shared_ptr<ObjcImpl> impl = std::make_shared<ObjcImpl>();
        
        // init the cpp obj
        m_p_cppClass = new CppClass(impl);
        
        callback = ^(HttpResponse resp) {

            if (resp.error) {
                NSLog([NSString stringWithFormat:@"http request failed with status code: %d", resp.http_code]);
            }
            else {
                NSLog([NSString stringWithCString:resp.data.c_str() encoding:[NSString defaultCStringEncoding]]);
            }
        };
    }

    return self;
}

- (void)objcMethod {
    // call the cpp test method
    m_p_cppClass->cppTestMethod(callback);
}

- (void)dealloc {
    delete m_p_cppClass;
}

@end










