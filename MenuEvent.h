#pragma once
#include "ofMain.h"

class MenuEvent : public ofEventArgs {
public:

    string   message;
    
    MenuEvent() {
    }
    
    static ofEvent <MenuEvent> events;
};

