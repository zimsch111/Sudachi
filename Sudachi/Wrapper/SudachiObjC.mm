//
//  SudachiObjC.mm
//  Sudachi
//
//  Created by Jarrod Norwell on 1/8/24.
//

#import "SudachiObjC.h"

#import "EmulationSession/EmulationSession.h"
#import "DirectoryManager/DirectoryManager.h"

#include "common/fs/fs.h"
#include "common/fs/path_util.h"
#include "common/settings.h"

#import <mach/mach.h>

@implementation SudachiObjC
-(SudachiObjC *) init {
    if (self = [super init]) {
        _gameInformation = [SudachiGameInformation sharedInstance];
        
        Common::FS::SetAppDirectory(DirectoryManager::SudachiDirectory());
        
        EmulationSession::GetInstance().System().Initialize();
        EmulationSession::GetInstance().InitializeSystem(false);
        EmulationSession::GetInstance().InitializeGpuDriver();
        
        YuzuSettings::values.use_asynchronous_shaders.SetValue(true);
        YuzuSettings::values.astc_recompression.SetValue(YuzuSettings::AstcRecompression::Bc1);
        YuzuSettings::values.shader_backend.SetValue(YuzuSettings::ShaderBackend::SpirV);
    } return self;
}

+(SudachiObjC *) sharedInstance {
    static SudachiObjC *sharedInstance = NULL;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

-(void) configureLayer:(CAMetalLayer *)layer {
    EmulationSession::GetInstance().SetNativeWindow((__bridge CA::MetalLayer*)layer, layer.frame.size);
}

-(void) insertGame:(NSURL *)url {
    EmulationSession::GetInstance().InitializeEmulation([url.path UTF8String], [_gameInformation informationForGame:url].programID, true);
}

-(void) step {
    void(EmulationSession::GetInstance().System().Run());
}

-(void) touchBeganAtPoint:(CGPoint)point index:(NSUInteger)index {
    EmulationSession::GetInstance().Window().OnTouchPressed(index, point.x, point.y);
}

-(void) touchEndedForIndex:(NSUInteger)index {
    EmulationSession::GetInstance().Window().OnTouchReleased(index);
}

-(void) touchMovedAtPoint:(CGPoint)point index:(NSUInteger)index {
    EmulationSession::GetInstance().Window().OnTouchMoved(index, point.x, point.y);
}

-(void) virtualControllerButtonDown:(SudachiVirtualControllerButtonType)button {
    EmulationSession::GetInstance().OnGamepadConnectEvent(0);
    EmulationSession::GetInstance().Window().OnGamepadButtonEvent(0, [[NSNumber numberWithUnsignedInteger:button] intValue], true);
}

-(void) virtualControllerButtonUp:(SudachiVirtualControllerButtonType)button {
    EmulationSession::GetInstance().OnGamepadConnectEvent(0);
    EmulationSession::GetInstance().Window().OnGamepadButtonEvent(0, [[NSNumber numberWithUnsignedInteger:button] intValue], false);
}

-(void) orientationChanged:(UIInterfaceOrientation)orientation {
    // EmulationSession::GetInstance().Window().OrientationChanged(orientation);
}
@end
