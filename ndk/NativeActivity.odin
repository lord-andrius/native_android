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
	onStart: proc(activity: ^ANativeActivity),
	onResume: proc(activity: ^ANativeActivity),
	onSaveInstanceState: proc(activity: ^ANativeActivity, outSize: ^uintptr),
	onPause: proc(activity: ^ANativeActivity),
	onStop: proc(activity: ^ANativeActivity),
	onDestroy: proc(activity: ^ANativeActivity),
	onWindowFocusChanged: proc(activity: ^ANativeActivity, hasFoucous: i32),
	onNativeWindowCreated: proc(activity: ^ANativeActivity, window: ^ANativeWindow),
	onNativeWindowResized: proc(activity: ^ANativeActivity, window: ^ANativeWindow),
	onNativeWindowRedrawNeeded: proc(activity: ^ANativeActivity, window: ^ANativeWindow),
	onNativeWindowDestroyed: proc(activity: ^ANativeActivity, window: ^ANativeWindow),
	onInputQueueCreated: proc(activity: ^ANativeActivity, queue: ^AInputQueue),
	onInputQueueDestroyed: proc(activity: ^ANativeActivity, queue: ^AInputQueue),
	onContentRectChanged: proc(activity: ^ANativeActivity, rect: ^ARect),
	onConfigurationChanged: proc(activity: ^ANativeActivity),
	onLoewMemory: proc(activity: ^ANativeActivity),
}

ANativeActivity_createFunc :: proc(nativeActivity: ^ANativeActivity, saveState: rawptr, savedStateSize: uintptr)

@(link_name="ANativeActivity_createFunc")
ANativeActivity_onCreate: ANativeActivity_createFunc


ANativeActivity_finish :: proc(activity: ^ANativeActivity) ---
ANativeActivity_setWindowFormat :: proc(activity: ^ANativeActivity, format: i32) ---
ANativeActivity_setWindowFlags :: proc(activity: ^ANativeActivity, addFlags, removeFlags: u32) ---


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


ANativeActivity_showSoftInput :: proc(activity: ^ANativeActivity, flags: bit_set[showSoftInputFlags; u32]) ---

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

ANativeActivity_hideSoftInput :: proc(activity: ^ANativeActivity, flags: bit_set[hideSoftInputFlags; u32]) ---
