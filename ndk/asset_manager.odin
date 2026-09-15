package ndk

foreign import android {
	"system:android",
}

AAssetManager :: struct{}

AAssetDir :: struct{}

AAsset :: struct{}

opening_asset_mode :: enum(i32) {
	/** No specific information about how data will be accessed. **/
    AASSET_MODE_UNKNOWN      = 0,
    /** Read chunks, and seek forward and backward. */
    AASSET_MODE_RANDOM       = 1,
    /** Read sequentially, with an occasional forward seek. */
    AASSET_MODE_STREAMING    = 2,
    /** Caller plans to ask for a read-only buffer with all data. */
    AASSET_MODE_BUFFER       = 3
}

@(default_calling_convention="c")
foreign android {
	AssetManager_openDir :: proc(mgr: ^AAssetManager, dirName: cstring) -> ^AAssetDir ---
	AssetManager_open :: proc(mgr: ^AAssetManager, filename: cstring, mode: opening_asset_mode) -> ^AAsset ---
	AAssetDir_getNextFileName :: proc(assetDir: ^AAssetDir) -> cstring ---
	AAssetDir_rewind :: proc(assetDir: ^AAssetDir) ---
	AAssetDir_close :: proc(assetDir: ^AAssetDir) ---
	AAsset_read :: proc(asset: ^AAsset, buf: rawptr, count: uintptr) -> i32 ---
	AAsset_seek :: proc(asset: ^AAsset, offset: int, whence: i32) -> int ---
	AAsset_seek64 :: proc(asset: ^AAsset, offset: i64, whence: i32) -> i64 ---
	AAsst_close :: proc(asset: ^AAsset) -> rawptr ---
	AAsst_getBuffer :: proc(asset: ^AAsset) -> rawptr ---
	AAsst_getLength :: proc(asset: ^AAsset) -> int ---
	AAsst_getLength64 :: proc(asset: ^AAsset) -> i64 ---
	AAsst_getRemainingLength :: proc(asset: ^AAsset) -> int ---
	AAsst_getRemainingLength64 :: proc(asset: ^AAsset) -> i64 ---
	AAsst_openFileDescriptor :: proc(asset: ^AAsset, outStart, outLength: int) -> i32 ---
	AAsst_openFileDescriptor64 :: proc(asset: ^AAsset, outStart, outLength: i64) -> i32 ---
	AAsst_isAllocated :: proc(asset: ^AAsset) -> i32 ---
}
