# Memory_Game_3D

A functional 3D game framework based on OpenGL ES 2.0. The framework explores a number of concepts needed to create a working framework including
* Animation Classes
 * MAAnimation.h
 * MAAnimationConfig.h
 * MAAnimationCache.h
 * MAGLFrame.h
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
* MAComposeite.h
* MASequence.h
* MAFrameAnimationRoutine.h

A demo game (Memory Card Game) is shown in `MAGLCardMemoryController.m` which showing how a number of different base classes in the framework can be used to create a 3D game in OpenGL. The logic within this game is found in `MACardMemoryLogic.m` and demonstrates a method for using behavior trees to control animations and logic.

Here is an video showing the game in action:

[![3D Memory Card Game](http://i.imgur.com/NFMGiiO.png)](https://www.youtube.com/watch?v=SN3WDzMHgbE "3D Memory Card Game")
