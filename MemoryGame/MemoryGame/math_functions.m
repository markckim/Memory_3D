//
//  math_functions.m
//  a5
//
//  Created by Mark Kim on 2/1/16.
//  Copyright © 2016 Mark Kim. All rights reserved.
//

#import "math_functions.h"
#import "UIScreen+ScreenSize.h"

double modCircularDegrees(double degrees)
{
    double circularDegrees = degrees;
    while (circularDegrees >= 360.0) {
        circularDegrees -= 360.0;
    }
    while (circularDegrees < 0.0) {
        circularDegrees += 360.0;
    }
    return circularDegrees;
}

GLKVector2 glPositionForScreenLocation(CGPoint screenLocation)
{
    CGSize screenSize = [UIScreen screenSize];
    float glX = screenLocation.x - 0.5 * screenSize.width;
    float glY = -1.0 * (screenLocation.y - 0.5 * screenSize.height);
    return GLKVector2Make(glX, glY);
}

GLKVector2 unitVector2(GLKVector2 vector)
{
    float length = GLKVector2Length(vector);
    return GLKVector2DivideScalar(vector, length);
}

GLKVector3 unitVector3(GLKVector3 vector)
{
    float length = GLKVector3Length(vector);
    return GLKVector3DivideScalar(vector, length);
}

GLKVector3 directionVector3(CGPoint screenLocation, float originScreenZ)
{
    GLKVector2 glPosition = glPositionForScreenLocation(screenLocation);
    float glX = glPosition.x;
    float glY = glPosition.y;
    float glZ = originScreenZ;
    return GLKVector3Make(glX, glY, glZ);
}

double originScreenZ(CGSize screenSize, double degreesVerticalFieldOfView)
{
    CGFloat tanFOV_V_over_2 = tanf(GLKMathDegreesToRadians(0.5 * degreesVerticalFieldOfView));
    CGFloat distanceToZ = (0.5 * screenSize.height) / tanFOV_V_over_2;
    return -1.0 * distanceToZ;
}

BOOL isLineIntersectingSimpleRectangle(GLKVector3 origin, GLKVector3 direction, GLKVector3 center, CGSize size)
{
    GLKVector3 unitDirection = unitVector3(direction);
    float distance = (center.z - origin.z) / unitDirection.z;
    float epsilon = 0.001;
    
    // x
    float lineX = origin.x + distance * unitDirection.x;
    float leftX = center.x - 0.5 * size.width - epsilon;
    float rightX = center.x + 0.5 * size.width + epsilon;
    
    // y
    float lineY = origin.y + distance * unitDirection.y;
    float lowerY = center.y - 0.5 * size.height - epsilon;
    float upperY = center.y + 0.5 * size.height + epsilon;
    
    if (lineX > leftX && lineX < rightX && lineY > lowerY && lineY < upperY) {
        return YES;
    }
    return NO;
}

BOOL isLineIntersectingSphere(GLKVector3 origin, GLKVector3 direction, GLKVector3 center, double radius)
{
    GLKVector3 unitDirection = unitVector3(direction);
    GLKVector3 originMinusCenter = GLKVector3Subtract(origin, center);
    float rightSideResultSquared = pow(GLKVector3DotProduct(unitDirection, originMinusCenter), 2.0) - pow(GLKVector3Length(originMinusCenter), 2.0) + pow(radius, 2.0);
    float epsilon = 0.001;
    NSLog(@"rightSideResultSquared: %f", rightSideResultSquared);
    if (rightSideResultSquared > -epsilon) {
        // assume at least one intersection
        return YES;
    } else {
        // assume no intersections
        return NO;
    }
}

NSArray* distancesOfLineIntersectingCircle(GLKVector2 origin, GLKVector2 direction, GLKVector2 center, double radius)
{
    GLKVector2 unitDirection = unitVector2(direction);
    GLKVector2 originMinusCenter = GLKVector2Subtract(origin, center);
    float parameterB = GLKVector2DotProduct(unitDirection, originMinusCenter);
    float rightSideResultSquared = pow(parameterB, 2.0) - pow(GLKVector2Length(originMinusCenter), 2.0) + pow(radius, 2.0);
    float epsilon = 0.001;
    if (rightSideResultSquared > epsilon) {
        // two intersections
        float rightSideResult = sqrtf(rightSideResultSquared);
        float result1 = -parameterB + rightSideResult;
        float result2 = -parameterB - rightSideResult;
        return @[@(result1), @(result2)];
    } else if (rightSideResultSquared > -epsilon && rightSideResultSquared <= epsilon) {
        // tangent (one intersection)
        return @[@(-parameterB)];
    }
    return nil;
}

double degreesFromFacingFront(NSUInteger index, NSUInteger numberOfSymbols)
{
    if (index >= numberOfSymbols) {
        NSLog(@"warn: index (%ld) is >= numberOfSymbols (%ld)", (long)index, (long)numberOfSymbols);
        index = index % numberOfSymbols;
    }
    double numIndex = (double)index;
    double numSymbols = (double)numberOfSymbols;
    double degreesPerIndex = 360.0 / numSymbols;
    double symbolDegrees = numIndex * degreesPerIndex;
    double degreesFromFacingFront = 360.0 - symbolDegrees;
    if (degreesFromFacingFront >= 360.0) {
        degreesFromFacingFront -= 360.0;
    }
    if (degreesFromFacingFront < 0.0) {
        degreesFromFacingFront += 360.0;
    }
    return degreesFromFacingFront;
}

double transformedStopRotationVelocity(double inputVelocity, double radius)
{
    double maxRotationSpeed = 2.0 * 2.0 * M_PI * radius;
    double transformedVeloctiy = 0.35 * inputVelocity;
    if (inputVelocity > 0.0) {
        return MIN((transformedVeloctiy / 360.0) * 2.0 * M_PI * radius, 1.0 * maxRotationSpeed);
    } else {
        return MAX((transformedVeloctiy / 360.0) * 2.0 * M_PI * radius, -1.0 * maxRotationSpeed);
    }
}

double transformedRotationOffset(double inputOffset)
{
    /**
     * interpreted as:
     * atan(x) goes to M_PI/2 (1.57...) as x -> infinite and -M_PI/2 (-1.57...) as x -> negative infinite
     *
     * we can normalize by multiplying by (2.0 / M_PI):
     * (2.0 / M_PI) * atan(2.0 * M_PI * x) which goes to 1 as x -> infinite and -1 as x -> negative infinite
     */
    return (2.0 / M_PI) * 45.0 * atan((1.0 / 300.0) * 2.0 * M_PI * inputOffset);
}

double transformedOffset(double inputOffset)
{
    return (2.0 / M_PI) * 0.045 * atan((1.0 / 300.0) * 2.0 * M_PI * inputOffset);
}

double thresholdedRotationInDegrees(double inputRotationInDegrees, double thresholdInDegrees)
{
    return ABS(inputRotationInDegrees > 0.0) ? MAX(0.0, inputRotationInDegrees - thresholdInDegrees) : MIN(inputRotationInDegrees + thresholdInDegrees, 0.0);
}

double thresholdedRotationVelocity(double inputRotationOffset, double inputRotationVelocity)
{
    return ABS(inputRotationOffset) > 0.0 ? inputRotationVelocity : 0.0;
}

double rotationVelocity(double degreesPerSecond, double radius)
{
    double cir = 2.0 * M_PI * radius;
    return -1.0 * degreesPerSecond * (cir / 360.0);
}

double rotationInDegreesWithDisplacement(double initialRotationInDegrees, double displacement, double radius)
{
    double cir = 2.0 * M_PI * radius;
    return -1.0 * displacement * (360.0 / cir) + initialRotationInDegrees;
}

double displacementWithRotationInDegrees(double initialDisplacement, double rotationInDegrees, double radius)
{
    double cir = 2.0 * M_PI * radius;
    return -1.0 * (rotationInDegrees / 360.0) * cir + initialDisplacement;
}

double rotationDegreesPerSecond(double rotationVelocity, double radius)
{
    double cir = 2.0 * M_PI * radius;
    return -1.0 * rotationVelocity * (360.0 / cir);
}

double dampedDisplacement(double initialPosition, double initialVelocity, double dampingRatio, double naturalFrequency, double dampedFrequency, double timeElapsed)
{
    return exp(-1.0 * dampingRatio * naturalFrequency * timeElapsed) * (initialPosition * cos(dampedFrequency * timeElapsed) + (initialVelocity / naturalFrequency) * sin(dampedFrequency * timeElapsed));
}

double funcDampedFrequency(double naturalFrequency, double dampingRatio)
{
    return naturalFrequency * sqrt(1.0 - pow(dampingRatio, 2.0));
}

void updateWithVertices(Vertex *vertices, const Vertex *shortVertices, const Vertex *tallVertices, NSUInteger numberOfVertices, double percent)
{
    for (NSUInteger i=0; i<numberOfVertices; ++i) {
        double diffX = shortVertices[i].Position[0] - tallVertices[i].Position[0];
        double diffY = shortVertices[i].Position[1] - tallVertices[i].Position[1];
        double diffZ = shortVertices[i].Position[2] - tallVertices[i].Position[2];
        vertices[i].Position[0] = tallVertices[i].Position[0] + (percent * diffX);
        vertices[i].Position[1] = tallVertices[i].Position[1] + (percent * diffY);
        vertices[i].Position[2] = tallVertices[i].Position[2] + (percent * diffZ);
    }
}

void updateJellyWithVertices(Vertex *vertices, const Vertex *shortVertices, const Vertex *tallVertices, NSUInteger numberOfVertices,
                             double stopPosition, double initialVelocity, double dampingRatio, double naturalFrequency, double dampedFrequency, double timeElapsed)
{
    double offset = dampedDisplacement(0.0, initialVelocity, dampingRatio, naturalFrequency, dampedFrequency, timeElapsed);
    double percent = (stopPosition + offset - 0.4) / 0.2; // TODO: the way percent is calculated must be refactored for other cylinders in the future
    updateWithVertices(vertices, shortVertices, tallVertices, numberOfVertices, percent);
}
