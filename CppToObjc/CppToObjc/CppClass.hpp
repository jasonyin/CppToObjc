//
//  CppClass.hpp
//  CppToObjc
//
//  Created by Kai Yin on 4/22/16.
//  Copyright © 2016 kky. All rights reserved.
//

#ifndef CppClass_hpp
#define CppClass_hpp

#include <stdio.h>
#include "CppInterface.h"

class CppClass {
public:
    CppClass(const std::shared_ptr<CppInterface> &impl);

    // internally call the interface method which implemented by Objc
    void cppTestMethod(std::function<void (HttpResponse)> callback);

private:
    std::shared_ptr<CppInterface> m_impl;
};


#endif /* CppClass_hpp */
