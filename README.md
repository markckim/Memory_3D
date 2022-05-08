# Memory_3D

A simple 3D game framework based on OpenGL ES 2.0. The project explores a number of concepts needed in order to create a working game framework 

Also included is a demo game (Memory Card Game) as shown in `MAGLCardMemoryController.m` demonstrating ways in which a number of different base classes in the framework can be used to create a 3D game in OpenGL. The logic within this game is found in `MACardMemoryLogic.m` and demonstrates a method for using behavior trees to control animations and logic.

Video showing the game in action:

[![3D Memory Card Game](http://i.imgur.com/NFMGiiO.png)](https://www.youtube.com/watch?v=SN3WDzMHgbE "3D Memory Card Game")

Video showing slot machine game prototype spring and touch feedback animations:

[![Slot Machine Game Prototype](http://i.imgur.com/a/0WeyHla.png)](https://www.youtube.com/watch?v=TuY5dLuANDs "Slot Machine Demo")


Functionality includes:
* Animation Classes
    * MAAnimation.h
    * MAAnimationConfig.h
    * MAAnimationCache.h
    * MAGLFrame.h
    * MAFrameCache.h
* Sprite Classes
    * MAGLSprite.h
* Texture Atlas Support (parsing TexturePacker JSON files)
    * MAAtlasData.h
    * MAAtlasFrame.h
    * MAAtlasMeta.h
    * MAAtlasPoint.h
    * MAAtlasSize.h
    * MAAtlasSpriteData.h

Animations and game logic classes are built based on the concept of Behavior Trees (https://en.wikipedia.org/wiki/Behavior_tree), and include the following base classes:
* MARoutine.h
* MAComposite.h
* MASequence.h
* MAFrameAnimationRoutine.h

**Other examples using this framework:**
* Slot Machine Mini-Game: 
    * https://www.youtube.com/watch?v=0YxPjhMmldQ
