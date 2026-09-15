package ndk

foreign import android {
	"system:android",
}


AHardwareBuffer_Format :: enum(i32) {
    /**
     * Corresponding formats:
     *   Vulkan: VK_FORMAT_R8G8B8A8_UNORM
     *   OpenGL ES: GL_RGBA8
     */
    AHARDWAREBUFFER_FORMAT_R8G8B8A8_UNORM           = 1,

    /**
     * 32 bits per pixel, 8 bits per channel format where alpha values are
     * ignored (always opaque).
     * Corresponding formats:
     *   Vulkan: VK_FORMAT_R8G8B8A8_UNORM
     *   OpenGL ES: GL_RGB8
     */
    AHARDWAREBUFFER_FORMAT_R8G8B8X8_UNORM           = 2,

    /**
     * Corresponding formats:
     *   Vulkan: VK_FORMAT_R8G8B8_UNORM
     *   OpenGL ES: GL_RGB8
     */
    AHARDWAREBUFFER_FORMAT_R8G8B8_UNORM             = 3,

    /**
     * Corresponding formats:
     *   Vulkan: VK_FORMAT_R5G6B5_UNORM_PACK16
     *   OpenGL ES: GL_RGB565
     */
    AHARDWAREBUFFER_FORMAT_R5G6B5_UNORM             = 4,

    /**
     * Corresponding formats:
     *   Vulkan: VK_FORMAT_R16G16B16A16_SFLOAT
     *   OpenGL ES: GL_RGBA16F
     */
    AHARDWAREBUFFER_FORMAT_R16G16B16A16_FLOAT       = 0x16,

    /**
     * Corresponding formats:
     *   Vulkan: VK_FORMAT_A2B10G10R10_UNORM_PACK32
     *   OpenGL ES: GL_RGB10_A2
     */
    AHARDWAREBUFFER_FORMAT_R10G10B10A2_UNORM        = 0x2b,

    /**
     * Opaque binary blob format.
     * Must have height 1 and one layer, with width equal to the buffer
     * size in bytes. Corresponds to Vulkan buffers and OpenGL buffer
     * objects. Can be bound to the latter using GL_EXT_external_buffer.
     */
    AHARDWAREBUFFER_FORMAT_BLOB                     = 0x21,

    /**
     * Corresponding formats:
     *   Vulkan: VK_FORMAT_D16_UNORM
     *   OpenGL ES: GL_DEPTH_COMPONENT16
     */
    AHARDWAREBUFFER_FORMAT_D16_UNORM                = 0x30,

    /**
     * Corresponding formats:
     *   Vulkan: VK_FORMAT_X8_D24_UNORM_PACK32
     *   OpenGL ES: GL_DEPTH_COMPONENT24
     */
    AHARDWAREBUFFER_FORMAT_D24_UNORM                = 0x31,

    /**
     * Corresponding formats:
     *   Vulkan: VK_FORMAT_D24_UNORM_S8_UINT
     *   OpenGL ES: GL_DEPTH24_STENCIL8
     */
    AHARDWAREBUFFER_FORMAT_D24_UNORM_S8_UINT        = 0x32,

    /**
     * Corresponding formats:
     *   Vulkan: VK_FORMAT_D32_SFLOAT
     *   OpenGL ES: GL_DEPTH_COMPONENT32F
     */
    AHARDWAREBUFFER_FORMAT_D32_FLOAT                = 0x33,

    /**
     * Corresponding formats:
     *   Vulkan: VK_FORMAT_D32_SFLOAT_S8_UINT
     *   OpenGL ES: GL_DEPTH32F_STENCIL8
     */
    AHARDWAREBUFFER_FORMAT_D32_FLOAT_S8_UINT        = 0x34,

    /**
     * Corresponding formats:
     *   Vulkan: VK_FORMAT_S8_UINT
     *   OpenGL ES: GL_STENCIL_INDEX8
     */
    AHARDWAREBUFFER_FORMAT_S8_UINT                  = 0x35,

    /**
     * YUV 420 888 format.
     * Must have an even width and height. Can be accessed in OpenGL
     * shaders through an external sampler. Does not support mip-maps
     * cube-maps or multi-layered textures.
     */
    AHARDWAREBUFFER_FORMAT_Y8Cb8Cr8_420             = 0x23,

    /**
     * YUV P010 format.
     * Must have an even width and height. Can be accessed in OpenGL
     * shaders through an external sampler. Does not support mip-maps
     * cube-maps or multi-layered textures.
     */
    AHARDWAREBUFFER_FORMAT_YCbCr_P010               = 0x36,

    /**
     * YUV P210 format.
     * Must have an even width and height. Can be accessed in OpenGL
     * shaders through an external sampler. Does not support mip-maps
     * cube-maps or multi-layered textures.
     */
    AHARDWAREBUFFER_FORMAT_YCbCr_P210               = 0x3c,

    /**
     * Corresponding formats:
     *   Vulkan: VK_FORMAT_R8_UNORM
     *   OpenGL ES: GR_GL_R8
     */
    AHARDWAREBUFFER_FORMAT_R8_UNORM                 = 0x38,

    /**
     * Corresponding formats:
     *   Vulkan: VK_FORMAT_R16_UINT
     *   OpenGL ES: GL_R16UI
     */
    AHARDWAREBUFFER_FORMAT_R16_UINT                 = 0x39,

    /**
     * Corresponding formats:
     *   Vulkan: VK_FORMAT_R16G16_UINT
     *   OpenGL ES: GL_RG16UI
     */
    AHARDWAREBUFFER_FORMAT_R16G16_UINT              = 0x3a,

    /**
     * Corresponding formats:
     *   Vulkan: VK_FORMAT_R10X6G10X6B10X6A10X6_UNORM_4PACK16
     *   OpenGL ES: N/A
     */
    AHARDWAREBUFFER_FORMAT_R10G10B10A10_UNORM       = 0x3b,

    /**
     * Corresponding formats:
     *   Vulkan: VK_FORMAT_R12X4_UINT
     *   OpenGL ES: N/A
     */
    AHARDWAREBUFFER_FORMAT_R12_UINT       	    = 0x3d,

    /**
     * Corresponding formats:
     *   Vulkan: VK_FORMAT_R14X2_UINT
     *   OpenGL ES: N/A
     */
    AHARDWAREBUFFER_FORMAT_R14_UINT               = 0x3e,

    /**
     * Corresponding formats:
     *   Vulkan: VK_FORMAT_R12X4G12X4_UINT
     *   OpenGL ES: N/A
     */
    AHARDWAREBUFFER_FORMAT_R12G12_UINT          = 0x3f,

    /**
     * Corresponding formats:
     *   Vulkan: VK_FORMAT_R14X2G14X2_UINT
     *   OpenGL ES: N/A
     */
    AHARDWAREBUFFER_FORMAT_R14G14_UINT          = 0x40,

    /**
     * Corresponding formats:
     *   Vulkan: VK_FORMAT_R12X4G12X4B12X4A12X4_UINT
     *   OpenGL ES: N/A
     */
    AHARDWAREBUFFER_FORMAT_R12G12B12A12_UINT= 0x41,

    /**
     * Corresponding formats:
     *   Vulkan: VK_FORMAT_R14X2G14X2B14X2A14X2_UINT
     *   OpenGL ES: N/A
     */
    AHARDWAREBUFFER_FORMAT_R14G14B14A14_UINT= 0x42,

    /**
     * Corresponding formats:
     *   Vulkan: VK_FORMAT_A2R10G10B10_UNORM_PACK32
     *   OpenGL ES: N/A
     */
    AHARDWAREBUFFER_FORMAT_B10G10R10A2_UNORM        = 0x43,

    /**
     * Corresponding formats:
     *   Vulkan: VK_FORMAT_A2R10G10B10_UNORM_PACK32
     *   OpenGL ES: N/A
     */
    AHARDWAREBUFFER_FORMAT_B10G10R10X2_UNORM        = 0x44,
}

AHardwareBuffer_UsageFlags :: enum(u64) {
    /**
     * The buffer will never be locked for direct CPU reads using the
     * AHardwareBuffer_lock() function. Note that reading the buffer
     * using OpenGL or Vulkan functions or memory mappings is still
     * allowed.
     */
    AHARDWAREBUFFER_USAGE_CPU_READ_NEVER        = 0,
    /**
     * The buffer will sometimes be locked for direct CPU reads using
     * the AHardwareBuffer_lock() function. Note that reading the
     * buffer using OpenGL or Vulkan functions or memory mappings
     * does not require the presence of this flag.
     */
    AHARDWAREBUFFER_USAGE_CPU_READ_RARELY       = 2,
    /**
     * The buffer will often be locked for direct CPU reads using
     * the AHardwareBuffer_lock() function. Note that reading the
     * buffer using OpenGL or Vulkan functions or memory mappings
     * does not require the presence of this flag.
     */
    AHARDWAREBUFFER_USAGE_CPU_READ_OFTEN        = 3,

    /** CPU read value mask. */
    AHARDWAREBUFFER_USAGE_CPU_READ_MASK         = 0xF,
    /**
     * The buffer will never be locked for direct CPU writes using the
     * AHardwareBuffer_lock() function. Note that writing the buffer
     * using OpenGL or Vulkan functions or memory mappings is still
     * allowed.
     */
    AHARDWAREBUFFER_USAGE_CPU_WRITE_NEVER       = 0 << 4,
    /**
     * The buffer will sometimes be locked for direct CPU writes using
     * the AHardwareBuffer_lock() function. Note that writing the
     * buffer using OpenGL or Vulkan functions or memory mappings
     * does not require the presence of this flag.
     */
    AHARDWAREBUFFER_USAGE_CPU_WRITE_RARELY      = 2 << 4,
    /**
     * The buffer will often be locked for direct CPU writes using
     * the AHardwareBuffer_lock() function. Note that writing the
     * buffer using OpenGL or Vulkan functions or memory mappings
     * does not require the presence of this flag.
     */
    AHARDWAREBUFFER_USAGE_CPU_WRITE_OFTEN       = 3 << 4,
    /** CPU write value mask. */
    AHARDWAREBUFFER_USAGE_CPU_WRITE_MASK        = 0xF << 4,
    /** The buffer will be read from by the GPU as a texture. */
    AHARDWAREBUFFER_USAGE_GPU_SAMPLED_IMAGE     = 1 << 8,
    /** The buffer will be written to by the GPU as a framebuffer attachment.*/
    AHARDWAREBUFFER_USAGE_GPU_FRAMEBUFFER       = 1 << 9,
    /**
     * The buffer will be written to by the GPU as a framebuffer
     * attachment.
     *
     * Note that the name of this flag is somewhat misleading: it does
     * not imply that the buffer contains a color format. A buffer with
     * depth or stencil format that will be used as a framebuffer
     * attachment should also have this flag. Use the equivalent flag
     * AHARDWAREBUFFER_USAGE_GPU_FRAMEBUFFER to avoid this confusion.
     */
    AHARDWAREBUFFER_USAGE_GPU_COLOR_OUTPUT      = AHARDWAREBUFFER_USAGE_GPU_FRAMEBUFFER,
    /**
     * The buffer will be used as a composer HAL overlay layer.
     *
     * This flag is currently only needed when using ASurfaceTransaction_setBuffer
     * to set a buffer. In all other cases, the framework adds this flag
     * internally to buffers that could be presented in a composer overlay.
     * ASurfaceTransaction_setBuffer is special because it uses buffers allocated
     * directly through AHardwareBuffer_allocate instead of buffers allocated
     * by the framework.
     */
    AHARDWAREBUFFER_USAGE_COMPOSER_OVERLAY      = 1 << 11,
    /**
     * The buffer is protected from direct CPU access or being read by
     * non-secure hardware, such as video encoders.
     *
     * This flag is incompatible with CPU read and write flags. It is
     * mainly used when handling DRM video. Refer to the EGL extension
     * EGL_EXT_protected_content and GL extension
     * GL_EXT_protected_textures for more information on how these
     * buffers are expected to behave.
     */
    AHARDWAREBUFFER_USAGE_PROTECTED_CONTENT     = 1 << 14,
    /** The buffer will be read by a hardware video encoder. */
    AHARDWAREBUFFER_USAGE_VIDEO_ENCODE          = 1 << 16,
    /**
     * The buffer will be used for direct writes from sensors.
     * When this flag is present, the format must be AHARDWAREBUFFER_FORMAT_BLOB.
     */
    AHARDWAREBUFFER_USAGE_SENSOR_DIRECT_DATA    = 1 << 23,
    /**
     * The buffer will be used as a shader storage or uniform buffer object.
     * When this flag is present, the format must be AHARDWAREBUFFER_FORMAT_BLOB.
     */
    AHARDWAREBUFFER_USAGE_GPU_DATA_BUFFER       = 1 << 24,
    /**
     * The buffer will be used as a cube map texture.
     * When this flag is present, the buffer must have a layer count
     * that is a multiple of 6. Note that buffers with this flag must be
     * bound to OpenGL textures using the extension
     * GL_EXT_EGL_image_storage instead of GL_KHR_EGL_image.
     */
    AHARDWAREBUFFER_USAGE_GPU_CUBE_MAP          = 1 << 25,
    /**
     * The buffer contains a complete mipmap hierarchy.
     * Note that buffers with this flag must be bound to OpenGL textures using
     * the extension GL_EXT_EGL_image_storage instead of GL_KHR_EGL_image.
     */
    AHARDWAREBUFFER_USAGE_GPU_MIPMAP_COMPLETE   = 1 << 26,

    /**
     * Usage: The buffer is used for front-buffer rendering. When
     * front-buffering rendering is specified, different usages may adjust their
     * behavior as a result. For example, when used as GPU_COLOR_OUTPUT the buffer
     * will behave similar to a single-buffered window. When used with
     * COMPOSER_OVERLAY, the system will try to prioritize the buffer receiving
     * an overlay plane & avoid caching it in intermediate composition buffers.
     */
    AHARDWAREBUFFER_USAGE_FRONT_BUFFER = 1 << 32,

    AHARDWAREBUFFER_USAGE_VENDOR_0  = 1 << 28,
    AHARDWAREBUFFER_USAGE_VENDOR_1  = 1 << 29,
    AHARDWAREBUFFER_USAGE_VENDOR_2  = 1 << 30,
    AHARDWAREBUFFER_USAGE_VENDOR_3  = 1 << 31,
    AHARDWAREBUFFER_USAGE_VENDOR_4  = 1 << 48,
    AHARDWAREBUFFER_USAGE_VENDOR_5  = 1 << 49,
    AHARDWAREBUFFER_USAGE_VENDOR_6  = 1 << 50,
    AHARDWAREBUFFER_USAGE_VENDOR_7  = 1 << 51,
    AHARDWAREBUFFER_USAGE_VENDOR_8  = 1 << 52,
    AHARDWAREBUFFER_USAGE_VENDOR_9  = 1 << 53,
    AHARDWAREBUFFER_USAGE_VENDOR_10 = 1 << 54,
    AHARDWAREBUFFER_USAGE_VENDOR_11 = 1 << 55,
    AHARDWAREBUFFER_USAGE_VENDOR_12 = 1 << 56,
    AHARDWAREBUFFER_USAGE_VENDOR_13 = 1 << 57,
    AHARDWAREBUFFER_USAGE_VENDOR_14 = 1 << 58,
    AHARDWAREBUFFER_USAGE_VENDOR_15 = 1 << 59,
    AHARDWAREBUFFER_USAGE_VENDOR_16 = 1 << 60,
    AHARDWAREBUFFER_USAGE_VENDOR_17 = 1 << 61,
    AHARDWAREBUFFER_USAGE_VENDOR_18 = 1 << 62,
    AHARDWAREBUFFER_USAGE_VENDOR_19 = 1 << 63,
}

AHardwareBuffer_Desc :: struct {
	width: u32, // height in pixels
	height: u32, // width in pixels

	/**
     * Number of images in an image array. AHardwareBuffers with one
     * layer correspond to regular 2D textures. AHardwareBuffers with
     * more than layer correspond to texture arrays. If the layer count
     * is a multiple of 6 and the usage flag
     * AHARDWAREBUFFER_USAGE_GPU_CUBE_MAP is present, the buffer is
     * a cube map or a cube map array.
     */
    layers  : u32,
    format  : u32, ///< One of AHardwareBuffer_Format.
    usage   : u32, ///< Combination of AHardwareBuffer_UsageFlags.
    stride  : u32, ///< Row stride in pixels, ignored for AHardwareBuffer_allocate()
    rfu0    : u32,///< Initialize to zero, reserved for future use.
    rfu1    : u32, ///< Initialize to zero, reserved for future use.
}


/**
 * Holds data for a single image plane.
 */
AHardwareBuffer_Plane :: struct {
    data: rawptr, ///< Points to first byte in plane
    pixelStride: u32,    ///< Distance in bytes from the color channel of one pixel to the next
    rowStride: u32     ///< Distance in bytes from the first value of one row of the image to
                             ///  the first value of the next row.
}


/**
 * Holds all image planes that contain the pixel data.
 */
AHardwareBuffer_Planes :: struct {
	planeCount: u32, ///< Number of distinct planes
    planes: [4]AHardwareBuffer_Plane ,  ///< Array of image planes
}

AHardwareBuffer :: struct {}

@(default_calling_convention="c")
foreign android {
	AHardwareBuffer_allocate :: proc(desc: ^AHardwareBuffer_Desc, outBuffer: ^^AHardwareBuffer) -> i32 ---
	AHardwareBuffer_acquire :: proc(buffer: ^AHardwareBuffer) ---
	AHardwareBuffer_release :: proc(buffer: ^AHardwareBuffer) ---
	AHardwareBuffer_describe :: proc(buffer: ^AHardwareBuffer, desc: ^^AHardwareBuffer_Desc) ---
	AHardwareBuffer_lock :: proc(buffer: ^AHardwareBuffer, usage: u64, fence: i32, rect: ^ARect, outVirtualAddress: ^^rawptr) -> i32 ---
	AHardwareBuffer_unlock :: proc(buffer: ^AHardwareBuffer,fence: i32) -> i32 ---
	AHardwareBuffer_sendHandleToUnixSocket :: proc(buffer: ^AHardwareBuffer, socket_fd: i32) -> i32 ---
	AHardwareBuffer_recvHandleFromUnixSocket :: proc(bsocket_fd: i32, buffer: ^AHardwareBuffer) -> i32 ---
	AHardwareBuffer_lockPlanes :: proc(buffer: ^AHardwareBuffer, usage: u64, rect: ^ARect, planes: ^AHardwareBuffer_Planes) -> i32 ---
	AHardwareBuffer_isSupported :: proc(buffer: ^AHardwareBuffer) -> i32 ---
	AHardwareBuffer_lockAndGetInfo :: proc(buffer: ^AHardwareBuffer, usage: u64, fence: i32, rect: ^ARect, outVirtualAddress: ^^rawptr, bytesPerPixel: ^i32, bytesPerStride: ^i32) -> i32 ---
	AHardwareBuffer_getId :: proc(buffer: ^AHardwareBuffer, outId: ^u64) -> i32 ---
}
