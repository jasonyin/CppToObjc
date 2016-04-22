//
//  CppClass.cpp
//  CppToObjc
//
//  Created by Kai Yin on 4/22/16.
//  Copyright © 2016 kky. All rights reserved.
//

#include "CppClass.hpp"

CppClass::CppClass(const std::shared_ptr<CppInterface> &impl) {
    this->m_impl = impl;
}

void CppClass::cppTestMethod(std::function<void (HttpResponse)> callback) {    
    this->m_impl->get("https://itunes.apple.com/search?media=music&entity=song&term=test", callback);
}