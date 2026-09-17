package native

import "ndk"

import "core:fmt"
import "core:mem"
import "base:runtime"

process_input :: proc"c"(app: ^ndk.android_app, event: ^ndk.AInputEvent) -> i32 {
	return 0
}

process_command :: proc"c"(app: ^ndk.android_app, cmd: ndk.app_comand) {
	#partial switch cmd {
	case .APP_CMD_WINDOW_REDRAW_NEEDED:
		draw_screen(app.activity, app.window)
	case .APP_CMD_INIT_WINDOW:
		draw_screen(app.activity, app.window)
	}
}

draw_screen :: proc "c" (activity: ^ndk.ANativeActivity, window: ^ndk.ANativeWindow) {
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
				pixel^ = u32(u8(x)) | u32(u8(y)) << 16

				pixels = mem.ptr_offset(pixels, 4)
			}
		}
	}

}

@(export=true)
android_main :: proc "c" (app: ^ndk.android_app) {

	context = runtime.default_context()
	fmt.println("iniciando android_main")

	ndk.ANativeActivity_setWindowFormat(app.activity, i32(ndk.AHardwareBuffer_Format.AHARDWAREBUFFER_FORMAT_R8G8B8X8_UNORM))

	app.onAppCmd = process_command
	app.onInputEvent = process_input

	for app.destroyRequested == 0 {
		events: i32
		pool_source: ^ndk.android_poll_source
		ident := ndk.ALooper_pollOnce(
	        0,
	        nil,
	        &events,
			cast(^rawptr)&pool_source
	    )
		if ident >= 0 && pool_source != nil {
			pool_source.process(app, pool_source)
		}
	}
}
