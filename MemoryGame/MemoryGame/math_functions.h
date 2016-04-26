//
//  math_functions.h
//  a5
//
//  Created by Mark Kim on 2/1/16.
//  Copyright © 2016 Mark Kim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GLKit/GLKit.h>
#import "vertex_constants.h"

/**
 * keep degrees limited to 0.0 - 359.99999999 degrees
 */
double modCircularDegrees(double degrees);

/**
 * convert screen location to a "glPosition"; a "glPosition" defines the center of the screen as (0.0, 0.0), the x-axis positive direction is right, and the y-axis positive direction is up
 */
GLKVector2 glPositionForScreenLocation(CGPoint screenLocation);

/**
 * returns unit vector
 */
GLKVector2 unitVector2(GLKVector2 vector);

/**
 * returns unit vector
 */
GLKVector3 unitVector3(GLKVector3 vector);

/**
 * determine gl coordinates based on screen location and originScreenZ
 */
GLKVector3 directionVector3(CGPoint screenLocation, float originScreenZ);

/**
 * determine the z value of the virtual screen that is set up based on screenSize and degreesVerticalFieldOfView
 */
double originScreenZ(CGSize screenSize, double degreesVerticalFieldOfView);

/**
 * assumes that the rectangle is not rotated and is perfectly aligned with the x and y axes
 */
BOOL isLineIntersectingSimpleRectangle(GLKVector3 origin, GLKVector3 direction, GLKVector3 center, CGSize size);

/**
 * direction is not necessarily a unit vector, but the implementation will convert it to a unit vector
 */
BOOL isLineIntersectingSphere(GLKVector3 origin, GLKVector3 direction, GLKVector3 center, double radius);

/**
 * returns an array of distance values
 * + if array is nil, the line does not intersect the circle
 * + if array has one distance value, the line is tangent to the circle (intersects the circle at 1 point)
 * + if array has two distance values, the line intersects the circle at 2 points
 */
NSArray* distancesOfLineIntersectingCircle(GLKVector2 origin, GLKVector2 direction, GLKVector2 center, double radius);

/**
 * this function is used to give the absolute angle of a symbol facing front and center (i.e., face points at 180 degrees, which is facing the user)
 * given an index assuming index 0 in the first symbol starting at 0 degrees and ending at 360/(# of symbols) degrees with a midpoint
 * at 180/(# of symbols) degrees
 */
double degreesFromFacingFront(NSUInteger index, NSUInteger numberOfSymbols);

/**
 * used to cap the velocity (points (on the screen) per second), when transforming it to rotations per second
 */
double transformedStopRotationVelocity(double inputVelocity, double radius);

/**
 * use to cap offset, when transforming it to rotation; makes reel appear to have a "bounce" effect
 * TODO: improve this formula; make it more generalized for different sized reels
 */
double transformedRotationOffset(double inputOffset);

/**
 * uses similar formula as transformedRotationOffset
 */
double transformedOffset(double inputOffset);

/**
 * used as a minimum threshold in degrees that a reel needs to pass before neighboring reels will start moving
 */
double thresholdedRotationInDegrees(double inputRotationInDegrees, double thresholdInDegrees);

/**
 * thresholded counterpart to thresholdedRotationInDegrees
 */
double thresholdedRotationVelocity(double inputRotationOffset, double inputRotationVelocity);

/**
 * this function returns y-velocity facing front and center (i.e., the center point facing the user)
 * if degreesPerSecond is positive (i.e., rotating counter-clockwise), the returned velocity will be negative
 * (think of the y-axis with positive values going up and negative values going down)
 */
double rotationVelocity(double degreesPerSecond, double radius);

/**
 * counterpart to rotationVelocity function
 */
double rotationDegreesPerSecond(double rotationVelocity, double radius);

/**
 * rotationInDegrees given initialRotationInDegrees, displacement, and radius
 */
double rotationInDegreesWithDisplacement(double initialRotationInDegrees, double displacement, double radius);

/**
 * the counterpart to rotationInDegreesWithDisplacement
 */
double displacementWithRotationInDegrees(double initialDisplacement, double rotationInDegrees, double radius);

/**
 * this is the solution to a 1-DOF spring damper system
 */
double dampedDisplacement(double initialPosition, double initialVelocity, double dampingRatio, double naturalFrequency, double dampedFrequency, double timeElapsed);

/**
 * damped frequency based on natural frequency and damping ratio
 */
double funcDampedFrequency(double naturalFrequency, double dampingRatio);

/**
 * keyframe animations
 */
void updateWithVertices(Vertex *vertices, const Vertex *shortVertices, const Vertex *tallVertices, NSUInteger numberOfVertices, double percent);

/**
 * jelly animations (uses dampedDisplacement() and updateWithVertices())
 */
void updateJellyWithVertices(Vertex *vertices, const Vertex *shortVertices, const Vertex *tallVertices, NSUInteger numberOfVertices,
                             double stopPosition, double initialVelocity, double dampingRatio, double naturalFrequency, double dampedFrequency, double timeElapsed);
