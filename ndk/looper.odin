package ndk

foreign import android {
	"system:android",
}


ALooper :: struct {}


looperPrepareOptions :: enum(i32) {
	/**
     * This looper will accept calls to ALooper_addFd() that do not
     * have a callback (that is provide NULL for the callback).  In
     * this case the caller of ALooper_pollOnce() or ALooper_pollAll()
     * MUST check the return from these functions to discover when
     * data is available on such fds and process it.
     */
    ALOOPER_PREPARE_ALLOW_NON_CALLBACKS = 1<<0
}

looperPollOnceResult :: enum(i32) {

	/**
     * The poll was awoken using wake() before the timeout expired
     * and no callbacks were executed and no other file descriptors were ready.
     */
    ALOOPER_POLL_WAKE = -1,

    /**
     * Result from ALooper_pollOnce():
     * One or more callbacks were executed. The poll may also have been
     * explicitly woken by ALooper_wake().
     */
    ALOOPER_POLL_CALLBACK = -2,

    /**
     * Result from ALooper_pollOnce() and ALooper_pollAll():
     * The timeout expired. The poll may also have been explicitly woken by
     * ALooper_wake().
     */
    ALOOPER_POLL_TIMEOUT = -3,

    /**
     * Result from ALooper_pollOnce() and ALooper_pollAll():
     * An error occurred. The poll may also have been explicitly woken by
     * ALooper_wake().
     */
    ALOOPER_POLL_ERROR = -4,
}

fileDescriptorFlags :: enum(i32) {
    /**
     * The file descriptor is available for read operations.
     */
    ALOOPER_EVENT_INPUT = 1 << 0,

    /**
     * The file descriptor is available for write operations.
     */
    ALOOPER_EVENT_OUTPUT = 1 << 1,

    /**
     * The file descriptor has encountered an error condition.
     *
     * The looper always sends notifications about errors; it is not necessary
     * to specify this event flag in the requested event set.
     */
    ALOOPER_EVENT_ERROR = 1 << 2,

    /**
     * The file descriptor was hung up.
     * For example, indicates that the remote end of a pipe or socket was closed.
     *
     * The looper always sends notifications about hangups; it is not necessary
     * to specify this event flag in the requested event set.
     */
    ALOOPER_EVENT_HANGUP = 1 << 3,

    /**
     * The file descriptor is invalid.
     * For example, the file descriptor was closed prematurely.
     *
     * The looper always sends notifications about invalid file descriptors; it is not necessary
     * to specify this event flag in the requested event set.
     */
    ALOOPER_EVENT_INVALID = 1 << 4,
}

ALooper_callbackFunc ::  proc"c"(fd: i32, events: i32, data: rawptr) -> i32

@(default_calling_convention="c")
foreign android {
	ALooper_forThread :: proc() -> ^ALooper ---
	ALooper_prepare :: proc(opts: looperPrepareOptions) -> ^ALooper ---
	ALooper_acquire :: proc(looper: ^ALooper) ---
	ALooper_release :: proc(looper: ^ALooper) ---
	ALooper_pollOnce :: proc(timeoutMillis: i32, outFd: ^i32, outEvents: ^i32, outData: ^rawptr) -> i32 ---
	ALooper_pollAll :: proc(timeoutMillis: i32, outFd: ^i32, outData: ^rawptr) -> i32 ---
	ALooper_wake :: proc(looper: ^ALooper) ---
	ALooper_addFd :: proc(looper: ^ALooper, fd: i32, ident: i32, event: i32, callback: ALooper_callbackFunc, data: rawptr) -> i32 ---
	ALooper_removeFd :: proc(looper: ^ALooper, fd: i32) -> i32 ---
}
