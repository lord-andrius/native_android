package ndk

import "core:c"

foreign import android {
	"system:android",
}

/**
 * Legacy window pixel format names, kept for backwards compatibility.
 * New code and APIs should use AHARDWAREBUFFER_FORMAT_*.
 */
ANativeWindow_LegacyFormat :: enum {
    // NOTE: these values must match the values from graphics/common/x.x/types.hal

    /** Red: 8 bits, Green: 8 bits, Blue: 8 bits, Alpha: 8 bits. **/
    WINDOW_FORMAT_RGBA_8888          = int(AHardwareBuffer_Format.AHARDWAREBUFFER_FORMAT_R8G8B8A8_UNORM),
    /** Red: 8 bits, Green: 8 bits, Blue: 8 bits, Unused: 8 bits. **/
    WINDOW_FORMAT_RGBX_8888          = int(AHardwareBuffer_Format.AHARDWAREBUFFER_FORMAT_R8G8B8X8_UNORM),
    /** Red: 5 bits, Green: 6 bits, Blue: 5 bits. **/
    WINDOW_FORMAT_RGB_565            = int(AHardwareBuffer_Format.AHARDWAREBUFFER_FORMAT_R5G6B5_UNORM),
};


/**
 * Transforms that can be applied to buffers as they are displayed to a window.
 *
 * Supported transforms are any combination of horizontal mirror, vertical
 * mirror, and clockwise 90 degree rotation, in that order. Rotations of 180
 * and 270 degrees are made up of those basic transforms.
 */
ANativeWindowTransform :: enum {
    ANATIVEWINDOW_TRANSFORM_IDENTITY            = 0x00,
    ANATIVEWINDOW_TRANSFORM_MIRROR_HORIZONTAL   = 0x01,
    ANATIVEWINDOW_TRANSFORM_MIRROR_VERTICAL     = 0x02,
    ANATIVEWINDOW_TRANSFORM_ROTATE_90           = 0x04,

    ANATIVEWINDOW_TRANSFORM_ROTATE_180          = ANATIVEWINDOW_TRANSFORM_MIRROR_HORIZONTAL |
                                                  ANATIVEWINDOW_TRANSFORM_MIRROR_VERTICAL,
    ANATIVEWINDOW_TRANSFORM_ROTATE_270          = ANATIVEWINDOW_TRANSFORM_ROTATE_180 |
                                                  ANATIVEWINDOW_TRANSFORM_ROTATE_90,
};

ANativeWindow :: struct{}



/**
 * Struct that represents a windows buffer.
 *
 * A pointer can be obtained using {@link ANativeWindow_lock()}.
 */
ANativeWindow_Buffer :: struct {
    /// The number of pixels that are shown horizontally.
    width: i32,

    /// The number of pixels that are shown vertically.
    height: i32,

    /// The number of *pixels* that a line in the buffer takes in
    /// memory. This may be >= width.
    stride: i32,

    /// The format of the buffer. One of AHardwareBuffer_Format.
    format: i32,

    /// The actual bits.
    bits: rawptr,

    /// Do not touch.
    reserved: [6]i32,
}


/** Compatibility value for ANativeWindow_setFrameRate. */
ANativeWindow_FrameRateCompatibility :: enum(i8){
    /**
     * There are no inherent restrictions on the frame rate of this window. When
     * the system selects a frame rate other than what the app requested, the
     * app will be able to run at the system frame rate without requiring pull
     * down. This value should be used when displaying game content.
     */
    ANATIVEWINDOW_FRAME_RATE_COMPATIBILITY_DEFAULT = 0,
    /**
     * This window is being used to display content with an inherently fixed
     * frame rate, e.g.\ a video that has a specific frame rate. When the system
     * selects a frame rate other than what the app requested, the app will need
     * to do pull down or use some other technique to adapt to the system's
     * frame rate. The user experience is likely to be worse (e.g. more frame
     * stuttering) than it would be if the system had chosen the app's requested
     * frame rate. This value should be used for video content.
     */
    ANATIVEWINDOW_FRAME_RATE_COMPATIBILITY_FIXED_SOURCE = 1,

    /**
     * The window requests a frame rate that is at least the specified frame rate.
     * This value should be used for UIs, animations, scrolling, and anything that is not a game
     * or video.
     */
    ANATIVEWINDOW_FRAME_RATE_COMPATIBILITY_AT_LEAST = 2
};

/**
 * Same as ANativeWindow_setFrameRateWithChangeStrategy(window, frameRate, compatibility,
 * ANATIVEWINDOW_CHANGE_FRAME_RATE_ONLY_IF_SEAMLESS).
 *
 * See ANativeWindow_setFrameRateWithChangeStrategy().
 *
 * Available since API level 30.
 */

/** Change frame rate strategy value for ANativeWindow_setFrameRate. */
ANativeWindow_ChangeFrameRateStrategy :: enum(i8){
    /**
     * Change the frame rate only if the transition is going to be seamless.
     */
    ANATIVEWINDOW_CHANGE_FRAME_RATE_ONLY_IF_SEAMLESS = 0,
    /**
     * Change the frame rate even if the transition is going to be non-seamless,
     * i.e. with visual interruptions for the user.
     */
    ANATIVEWINDOW_CHANGE_FRAME_RATE_ALWAYS = 1
}

@(default_calling_convention="c")
foreign android {
	ANativeWindow_acquire :: proc(window: ^ANativeWindow) ---
	ANativeWindow_release :: proc(window: ^ANativeWindow) ---
	ANativeWindow_getWidth :: proc(window: ^ANativeWindow) -> i32 ---
	ANativeWindow_getHeight :: proc(window: ^ANativeWindow) -> i32 ---
	ANativeWindow_getFormat :: proc(window: ^ANativeWindow) -> AHardwareBuffer_Format ---
	ANativeWindow_setBuffersGeometry :: proc(window: ^ANativeWindow, width, height: i32, format: AHardwareBuffer_Format) -> i32 ---
	ANativeWindow_lock :: proc(window: ^ANativeWindow, outBuffer: ^ANativeWindow_Buffer, inOutDirtyBounds: ^ARect) -> i32 ---
	ANativeWindow_unlockAndPost :: proc(window: ^ANativeWindow) -> i32 ---
	ANativeWindow_setBuffersTransform :: proc(window: ^ANativeWindow, transform: i32) -> i32 ---
	ANativeWindow_setBuffersDataSpace :: proc(window: ^ANativeWindow, dataSpace: i32) -> i32 ---
	ANativeWindow_getBuffersDataSpace :: proc(window: ^ANativeWindow) -> i32 ---
	ANativeWindow_getBuffersDefaultDataSpace :: proc(window: ^ANativeWindow) -> i32 ---
	ANativeWindow_setFrameRate :: proc(window: ^ANativeWindow, frameRate: f32, compatibility: ANativeWindow_FrameRateCompatibility) -> i32 ---
	ANativeWindow_tryAllocateBuffers :: proc(window: ^ANativeWindow) ---
	ANativeWindow_setFrameRateWithChangeStrategy :: proc(window: ^ANativeWindow, frameRate: f32, compatibility: ANativeWindow_FrameRateCompatibility, changeFrameRateStategy: ANativeWindow_ChangeFrameRateStrategy) -> i32 ---
	ANativeWindow_setProducerThrottlingEnabled :: proc(window: ^ANativeWindow, enabled: c.bool) -> i32 ---
	ANativeWindow_isProducerThrottlingEnabled :: proc(window: ^ANativeWindow, outEnabled: ^c.bool) -> i32 ---
}


ANativeWindow_clearFrameRate :: proc"c"(window: ^ANativeWindow ) -> i32 {
    return ANativeWindow_setFrameRateWithChangeStrategy(window, 0,
            ANativeWindow_FrameRateCompatibility.ANATIVEWINDOW_FRAME_RATE_COMPATIBILITY_DEFAULT,
            ANativeWindow_ChangeFrameRateStrategy.ANATIVEWINDOW_CHANGE_FRAME_RATE_ONLY_IF_SEAMLESS);
}
