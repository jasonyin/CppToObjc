//
//  CppInterface.h
//  CppToObjc
//
//  Created by Kai Yin on 4/22/16.
//  Copyright © 2016 kky. All rights reserved.
//

#ifndef CppInterface_h
#define CppInterface_h

#include <functional>
#include <string>

struct HttpResponse {
    bool error;
    int http_code;
    std::string data;
};

/// this is an interface for cpp code to use
/// the impl comes from objc
class CppInterface {
public:
    virtual void get(const std::string &url, std::function<void(HttpResponse)> callback) = 0;
};

#endif /* CppInterface_h */
