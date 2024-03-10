//
//  SudachiObjC.h
//  Sudachi
//
//  Created by Jarrod Norwell on 1/8/24.
//

#import <Foundation/Foundation.h>
#import <MetalKit/MetalKit.h>

#import "SudachiGameInformation/SudachiGameInformation.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, SudachiVirtualControllerButtonType) {
    SudachiVirtualControllerButtonTypeA = 0,
    SudachiVirtualControllerButtonTypeB = 1,
    SudachiVirtualControllerButtonTypeX = 2,
    SudachiVirtualControllerButtonTypeY = 3,
    SudachiVirtualControllerButtonTypeL = 4,
    SudachiVirtualControllerButtonTypeR = 5,
    SudachiVirtualControllerButtonTypeTriggerL = 6,
    SudachiVirtualControllerButtonTypeTriggerR = 7,
    SudachiVirtualControllerButtonTypeTriggerZL = 8,
    SudachiVirtualControllerButtonTypeTriggerZR = 9,
    SudachiVirtualControllerButtonTypePlus = 10,
    SudachiVirtualControllerButtonTypeMinus = 11,
    SudachiVirtualControllerButtonTypeDirectionalPadLeft = 12,
    SudachiVirtualControllerButtonTypeDirectionalPadUp = 13,
    SudachiVirtualControllerButtonTypeDirectionalPadRight = 14,
    SudachiVirtualControllerButtonTypeDirectionalPadDown = 15,
    SudachiVirtualControllerButtonTypeSL = 16,
    SudachiVirtualControllerButtonTypeSR = 17,
    SudachiVirtualControllerButtonTypeHome = 18,
    SudachiVirtualControllerButtonTypeCapture = 19
};

@interface SudachiObjC : NSObject
@property (nonatomic, strong) SudachiGameInformation *gameInformation;

+(SudachiObjC *) sharedInstance NS_SWIFT_NAME(shared());
-(void) configureLayer:(CAMetalLayer *)layer withSize:(CGSize)size NS_SWIFT_NAME(configure(layer:with:));
-(void) bootOS;
-(void) insertGame:(NSURL *)url NS_SWIFT_NAME(insert(game:));
-(void) insertGames:(NSArray<NSURL *> *)games NS_SWIFT_NAME(insert(games:));
-(void) step;

-(void) touchBeganAtPoint:(CGPoint)point index:(NSUInteger)index NS_SWIFT_NAME(touchBegan(at:for:));
-(void) touchEndedForIndex:(NSUInteger)index;
-(void) touchMovedAtPoint:(CGPoint)point index:(NSUInteger)index NS_SWIFT_NAME(touchMoved(at:for:));

-(void) thumbstickMoved:(SudachiVirtualControllerButtonType)button x:(CGFloat)x y:(CGFloat)y;

-(void) virtualControllerButtonDown:(SudachiVirtualControllerButtonType)button;
-(void) virtualControllerButtonUp:(SudachiVirtualControllerButtonType)button;
@end

NS_ASSUME_NONNULL_END
