//
//  Menu.h
//  GestureRecorder
//
//  Created by bastien girschig on 28/09/2014.
//
//

#ifndef GestureRecorder_Menu_h
#define GestureRecorder_Menu_h
#include "Settings.h"
#include <ofMain.h>

class Menu{
    public:
    Menu();
    void draw();
    Boolean click(int mouseY);
    void gotoStage(int _stage);
    ofTrueTypeFont font;
    string btnText;
    Boolean hasTouch;
    int stage;
    
};

#endif
