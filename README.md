# Memory_3D

A 3D game framework based on OpenGL ES 2.0. The project explores a number of concepts needed in order to create a working game framework 

A demo game (Memory Card Game) is shown in `MAGLCardMemoryController.m` demonstrating ways in which a number of different base classes in the framework can be used to create a 3D game in OpenGL. The logic within this game is found in `MACardMemoryLogic.m` and demonstrates a method for using behavior trees to control animations and logic.

Here is a video showing the game in action:

[![3D Memory Card Game](http://i.imgur.com/NFMGiiO.png)](https://www.youtube.com/watch?v=SN3WDzMHgbE "3D Memory Card Game")

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
