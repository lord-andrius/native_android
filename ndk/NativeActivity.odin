package ndk

foreign import android {
	"system:android",
}

ANativeActivity :: struct {

	callbacks: ^ANativeActivityCallbacks,

	vm: ^JavaVM,

	env: ^JNIEnv,

	clazz: jobject,

	internalDataPath: cstring,

	externalDataPath: cstring,

	sdkVersion: i32,

	instance: rawptr,

	assetManager: ^AAssetManager,

	obbPath: cstring,
}

ANativeActivityCallbacks :: struct {
	onStart: proc "c" (activity: ^ANativeActivity),
	onResume: proc "c" (activity: ^ANativeActivity),
	onSaveInstanceState: proc "c" (activity: ^ANativeActivity, outSize: ^uintptr),
	onPause: proc "c" (activity: ^ANativeActivity),
	onStop: proc "c" (activity: ^ANativeActivity),
	onDestroy: proc "c" (activity: ^ANativeActivity),
	onWindowFocusChanged: proc "c" (activity: ^ANativeActivity, hasFoucous: i32),
	onNativeWindowCreated: proc "c" (activity: ^ANativeActivity, window: ^ANativeWindow),
	onNativeWindowResized: proc "c" (activity: ^ANativeActivity, window: ^ANativeWindow),
	onNativeWindowRedrawNeeded: proc "c" (activity: ^ANativeActivity, window: ^ANativeWindow),
	onNativeWindowDestroyed: proc "c" (activity: ^ANativeActivity, window: ^ANativeWindow),
	onInputQueueCreated: proc "c" (activity: ^ANativeActivity, queue: ^AInputQueue),
	onInputQueueDestroyed: proc "c" (activity: ^ANativeActivity, queue: ^AInputQueue),
	onContentRectChanged: proc "c" (activity: ^ANativeActivity, rect: ^ARect),
	onConfigurationChanged: proc "c" (activity: ^ANativeActivity),
	onLoewMemory: proc "c" (activity: ^ANativeActivity),
}


showSoftInputFlags :: enum(u32) {
/**
 * Implicit request to show the input window, not as the result
 * of a direct request by the user.
 */
ANATIVEACTIVITY_SHOW_SOFT_INPUT_IMPLICIT = 0x0001,
/**
 * The user has forced the input method open (such as by
 * long-pressing menu) so it should not be closed until they
 * explicitly do so.
 */
ANATIVEACTIVITY_SHOW_SOFT_INPUT_FORCED = 0x0002
}

hideSoftInputFlags :: enum(u32) {
    /**
     * The soft input window should only be hidden if it was not
     * explicitly shown by the user.
     */
    ANATIVEACTIVITY_HIDE_SOFT_INPUT_IMPLICIT_ONLY = 0x0001,
    /**
     * The soft input window should normally be hidden, unless it was
     * originally shown with {@link ANATIVEACTIVITY_SHOW_SOFT_INPUT_FORCED}.
     */
    ANATIVEACTIVITY_HIDE_SOFT_INPUT_NOT_ALWAYS = 0x0002,
};

// é só uma definição de tipo por isso está aqui
ANativeActivity_createFunc :: #type proc "c" (nativeActivity: ^ANativeActivity, saveState: rawptr, savedStateSize: uintptr)

@(default_calling_convention="c")
foreign android {
	@(link_name="ANativeActivity_createFunc")
	ANativeActivity_onCreate: ANativeActivity_createFunc

	ANativeActivity_finish :: proc "c" (activity: ^ANativeActivity) ---
	ANativeActivity_setWindowFormat :: proc "c" (activity: ^ANativeActivity, format: i32) ---
	ANativeActivity_setWindowFlags :: proc "c" (activity: ^ANativeActivity, addFlags, removeFlags: u32) ---
	ANativeActivity_showSoftInput :: proc "c" (activity: ^ANativeActivity, flags: bit_set[showSoftInputFlags; u32]) ---
	ANativeActivity_hideSoftInput :: proc "c" (activity: ^ANativeActivity, flags: bit_set[hideSoftInputFlags; u32]) ---
}
