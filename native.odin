package native

import "ndk"

import "core:math/rand"
import "core:mem"
import "base:runtime"

onStart :: proc "c" (activity: ^ndk.ANativeActivity) {

}
onResume :: proc "c" (activity: ^ndk.ANativeActivity) {}
onSaveInstanceState :: proc "c" (activity: ^ndk.ANativeActivity, outSize: ^uintptr) {}
onPause :: proc "c" (activity: ^ndk.ANativeActivity) {}
onStop :: proc "c" (activity: ^ndk.ANativeActivity) {}
onDestroy :: proc "c" (activity: ^ndk.ANativeActivity) {}
onWindowFocusChanged :: proc "c" (activity: ^ndk.ANativeActivity, hasFoucous: i32) {}
onNativeWindowCreated :: proc "c" (activity: ^ndk.ANativeActivity, window: ^ndk.ANativeWindow) {}
onNativeWindowResized :: proc "c" (activity: ^ndk.ANativeActivity, window: ^ndk.ANativeWindow) {}
onNativeWindowRedrawNeeded :: proc "c" (activity: ^ndk.ANativeActivity, window: ^ndk.ANativeWindow) {
	context = runtime.default_context()
	buffer: ndk.ANativeWindow_Buffer = ---
	inOutDirtyBounds: ndk.ARect = ---
	if ndk.ANativeWindow_lock(window, &buffer, &inOutDirtyBounds) == 0 {
		// consigui pegar o buffer da janela
		defer ndk.ANativeWindow_unlockAndPost(window) // destrava e desenha a tela
		pixels := transmute([^]u8)buffer.bits
		for y in 0..<buffer.height {
			for x in 0..<buffer.width {
				// RGBX
				// XBGR
				pixel := transmute(^u32)pixels
				pixel^ = u32(u8(x)) << 24 | u32(u8(y)) << 8
				pixels = mem.ptr_offset(pixels, 4)
			}
		}
	}

}
onNativeWindowDestroyed :: proc "c" (activity: ^ndk.ANativeActivity, window: ^ndk.ANativeWindow) {}
onInputQueueCreated :: proc "c" (activity: ^ndk.ANativeActivity, queue: ^ndk.AInputQueue) {}
onInputQueueDestroyed :: proc "c" (activity: ^ndk.ANativeActivity, queue: ^ndk.AInputQueue) {}
onContentRectChanged :: proc "c" (activity: ^ndk.ANativeActivity, rect: ^ndk.ARect) {}
onConfigurationChanged :: proc "c" (activity: ^ndk.ANativeActivity) {}
onLoewMemory :: proc "c" (activity: ^ndk.ANativeActivity) {}

@(export=true)
ANativeActivity_onCreate :: proc "c" (nativeActivity: ^ndk.ANativeActivity, saveState: rawptr, savedStateSize: uintptr) {
	ndk.ANativeActivity_setWindowFormat(nativeActivity, i32(ndk.AHardwareBuffer_Format.AHARDWAREBUFFER_FORMAT_R8G8B8X8_UNORM))
	nativeActivity.callbacks.onStart = onStart
	nativeActivity.callbacks.onResume = onResume
	nativeActivity.callbacks.onSaveInstanceState = onSaveInstanceState
	nativeActivity.callbacks.onPause = onPause
	nativeActivity.callbacks.onStop = onStop
	nativeActivity.callbacks.onDestroy = onDestroy
	nativeActivity.callbacks.onWindowFocusChanged = onWindowFocusChanged
	nativeActivity.callbacks.onNativeWindowCreated = onNativeWindowCreated
	nativeActivity.callbacks.onNativeWindowResized = onNativeWindowResized
	nativeActivity.callbacks.onNativeWindowRedrawNeeded = onNativeWindowRedrawNeeded
	nativeActivity.callbacks.onNativeWindowDestroyed = onNativeWindowDestroyed
	nativeActivity.callbacks.onInputQueueCreated = onInputQueueCreated
	nativeActivity.callbacks.onInputQueueDestroyed = onInputQueueDestroyed
	nativeActivity.callbacks.onContentRectChanged = onContentRectChanged
	nativeActivity.callbacks.onConfigurationChanged = onConfigurationChanged
	nativeActivity.callbacks.onLoewMemory = onLoewMemory


	for {}
}
