package ndk

import "core:c"

jboolean :: b8
jbool :: b8
jbyte :: u8
jchar :: u16
jshort :: i16
jint :: i32
jlong :: i64
jfloat :: f32
jdouble :: f64

jobject       :: rawptr
jclass        :: jobject
jstring       :: jobject
jarray        :: jobject
jobjectArray  :: jarray
jbooleanArray :: jarray
jbyteArray    :: jarray
jcharArray    :: jarray
jshortArray   :: jarray
jintArray     :: jarray
jlongArray    :: jarray
jfloatArray   :: jarray
jdoubleArray  :: jarray
jthrowable    :: jobject
jweak         :: jobject
jsize 		  :: jint


_jfieldID :: struct{}
jfieldID :: ^_jfieldID

_jmethodID :: struct{}
jmethodID :: ^_jmethodID

jvalue :: struct #raw_union {
	z: jboolean,
	b: jbyte,
	c: jchar,
	s: jshort,
	i: jint,
	j: jlong,
	f: jfloat,
	d: jdouble,
	l: jobject
}

jobjectRefType :: enum(u32) {
	JNIInvalidRefType = 0,
	JNILocalRefType = 1,
	JNIGlobalRefType = 2,
	JNIWeakGlobalRefType = 3
}

arrayReleaseMode ::enum(jint) {
	COPY_ELEMENTS_AND_FREE_BUFFER = 0, /*copy back the content and free the elems buffer*/
	JNI_COMMIT, /*copy back the content but do not free the elems buffer*/
	JNI_ABORT, /*free the buffer without copying back the possible changes*/
}

JNINativeMethod :: struct {
	name: cstring,
	signature: cstring,
	fnPtr: rawptr,
}

JNIEnv :: ^JNINativeInterface
JavaVM :: ^JNIInvokeInterface

JNINativeInterface :: struct {
	reserved0: rawptr,
	reserved1: rawptr,
	reserved2: rawptr,
	reserved3: rawptr,

	GetVersion: proc "c" (env: ^^JNINativeInterface) -> jint,
	DefineClass: proc "c" (env: ^^JNINativeInterface, object: jobject, buffer: [^]jbyte, buffer_size: jsize) -> jclass,
	FindClass: proc "c" (env: ^^JNINativeInterface, classname: cstring) -> jclass,

	FromReflectMethod: proc "c" (env: ^^JNINativeInterface, object: jobject) -> jmethodID,
	FromReflectedField: proc "c" (env: ^^JNINativeInterface, object: jobject) -> jfieldID,
	ToReflectedMethod: proc "c" (env: ^^JNINativeInterface, class: jclass, method: jmethodID, boolean: jboolean) -> jobject,

	GetSuperClass: proc "c" (env: ^^JNINativeInterface, class: jclass) -> jclass,
	IsAssignableFrom: proc "c" (env: ^^JNINativeInterface, class1: jclass, class2: jclass) -> jboolean,

	ToReflectedField: proc "c" (env: ^^JNINativeInterface, class: jclass, field: jfieldID, boolean: jboolean) -> jobject,

	Throw: proc "c" (env: ^^JNINativeInterface, throwable: jthrowable) -> jint,
	ThrowNew: proc "c" (env: ^^JNINativeInterface, class: jclass, message: cstring) -> jint,
	ExceptionOcurred: proc "c" (env: ^^JNINativeInterface) -> jthrowable,
	ExceptionDescribe: proc "c" (env: ^^JNINativeInterface),
	ExceptionClear: proc "c" (env: ^^JNINativeInterface),
	FatalError: proc "c" (env: ^^JNINativeInterface, message: cstring),

	PushLocalFrame: proc "c" (env: ^^JNINativeInterface, capacity: jint) -> jint,
	PopLocalFrame: proc "c" (env: ^^JNINativeInterface, result: jobject) -> jint,


	NewGlobalRef: proc "c" (env: ^^JNINativeInterface, object: jobject) -> jobject,
	DeleteGlobalRef: proc "c" (env: ^^JNINativeInterface, object: jobject),
	DeleteLocalRef: proc "c" (env: ^^JNINativeInterface, object: jobject),
	IsSameObject: proc "c" (env: ^^JNINativeInterface, object1, object2: jobject) -> jboolean,

	NewLocalRef: proc "c" (env: ^^JNINativeInterface, object: jobject) -> jobject,
	EnsureLocalCapacity: proc "c" (env: ^^JNINativeInterface, capacity: jint) -> jint,

	AllocObject: proc "c" (env: ^^JNINativeInterface, class: jclass) -> jobject,
	NewObject: proc "c" (env: ^^JNINativeInterface, calss: jclass, method: jmethodID, #c_vararg args: ..any) -> jobject,
	NewObjectV: proc "c" (env: ^^JNINativeInterface, class: jclass, method: jmethodID, va_list: ^c.va_list) -> jobject,
	NewObjectA: proc "c" (env: ^^JNINativeInterface, class: jclass, methos: jmethodID, value: ^jvalue) -> jobject,

	GetObjectClass: proc "c" (env: ^^JNINativeInterface, object: jobject) -> jclass,
	IsInstanceOf: proc "c" (env: ^^JNINativeInterface, object: jobject, class: jclass) -> jboolean,
	GetMethodId: proc "c" (env: ^^JNINativeInterface, classs: jclass, name, signature: cstring) -> jmethodID,

	CallObjectMethod: proc "c" (env: ^^JNINativeInterface, object: jobject, method: jmethodID, #c_vararg args: ..any) -> jobject,
	CallObjectMethodV: proc "c" (env: ^^JNINativeInterface, object: jobject, method: jmethodID, args: ^c.va_list) -> jobject,
	CallObjectMethodA: proc "c" (env: ^^JNINativeInterface, object: jobject, method: jmethodID, valur: ^jvalue) -> jobject,

	CallBooleanMethod: proc "c" (env: ^^JNINativeInterface, object: jobject, method: jmethodID, #c_vararg args: ..any) -> jobject,
	CallBooleanMethodV: proc "c" (env: ^^JNINativeInterface, object: jobject, method: jmethodID, args: ^c.va_list) -> jobject,
	CallBooleanMethodA: proc "c" (env: ^^JNINativeInterface, object: jobject, method: jmethodID, valur: ^jvalue) -> jobject,


	//CallBooleanMethod: proc "c" (env: ^^JNINativeInterface, object: jobject, method: jmethodID, #c_vararg args: ..any) -> jobject,
	//CallBooleanMethodV: proc "c" (env: ^^JNINativeInterface, object: jobject, method: jmethodID, args: ^c.va_list) -> jobject,
	//CallBooleanMethodA: proc "c" (env: ^^JNINativeInterface, object: jobject, method: jmethodID, valur: ^jvalue) -> jobject,

	CallByteMethod: proc "c" (env: ^^JNINativeInterface, object: jobject, method: jmethodID, #c_vararg args: ..any) -> jboolean,
	CallByteMethodV: proc "c" (env: ^^JNINativeInterface, object: jobject, method: jmethodID, args: ^c.va_list) -> jboolean,
	CallByteMethodA: proc "c" (env: ^^JNINativeInterface, object: jobject, method: jmethodID, valur: ^jvalue) -> jboolean,

	CallCharMethod: proc "c" (env: ^^JNINativeInterface, object: jobject, method: jmethodID, #c_vararg args: ..any) -> jchar,
	CallCharMethodV: proc "c" (env: ^^JNINativeInterface, object: jobject, method: jmethodID, args: ^c.va_list) -> jchar,
	CallCharMethodA: proc "c" (env: ^^JNINativeInterface, object: jobject, method: jmethodID, valur: ^jvalue) -> jchar,

	CallShortMethod: proc "c" (env: ^^JNINativeInterface, object: jobject, method: jmethodID, #c_vararg args: ..any) -> jshort,
	CallShortMethodV: proc "c" (env: ^^JNINativeInterface, object: jobject, method: jmethodID, args: ^c.va_list) -> jshort,
	CallShortMethodA: proc "c" (env: ^^JNINativeInterface, object: jobject, method: jmethodID, valur: ^jvalue) -> jshort,

	CallIntMethod: proc "c" (env: ^^JNINativeInterface, object: jobject, method: jmethodID, #c_vararg args: ..any) -> jint,
	CallIntMethodV: proc "c" (env: ^^JNINativeInterface, object: jobject, method: jmethodID, args: ^c.va_list) -> jint,
	CallIntMethodA: proc "c" (env: ^^JNINativeInterface, object: jobject, method: jmethodID, valur: ^jvalue) -> jint,

	CallLongMethod: proc "c" (env: ^^JNINativeInterface, object: jobject, method: jmethodID, #c_vararg args: ..any) -> jlong,
	CallLongMethodV: proc "c" (env: ^^JNINativeInterface, object: jobject, method: jmethodID, args: ^c.va_list) -> jlong,
	CallLongMethodA: proc "c" (env: ^^JNINativeInterface, object: jobject, method: jmethodID, valur: ^jvalue) -> jlong,

	CallFloatMethod: proc "c" (env: ^^JNINativeInterface, object: jobject, method: jmethodID, #c_vararg args: ..any) -> jfloat,
	CallFloatMethodV: proc "c" (env: ^^JNINativeInterface, object: jobject, method: jmethodID, args: ^c.va_list) -> jfloat,
	CallFloatMethodA: proc "c" (env: ^^JNINativeInterface, object: jobject, method: jmethodID, valur: ^jvalue) -> jfloat,

	CallDoubleMethod: proc "c" (env: ^^JNINativeInterface, object: jobject, method: jmethodID, #c_vararg args: ..any) -> jdouble,
	CallDoubleMethodV: proc "c" (env: ^^JNINativeInterface, object: jobject, method: jmethodID, args: ^c.va_list) -> jdouble,
	CallDoubleMethodA: proc "c" (env: ^^JNINativeInterface, object: jobject, method: jmethodID, valur: ^jvalue) -> jdouble,

	CallVoidMethod: proc "c" (env: ^^JNINativeInterface, object: jobject, method: jmethodID, #c_vararg args: ..any),
	CallVoidMethodV: proc "c" (env: ^^JNINativeInterface, object: jobject, method: jmethodID, args: ^c.va_list),
	CallVoidMethodA: proc "c" (env: ^^JNINativeInterface, object: jobject, method: jmethodID, valur: ^jvalue),

	CallNonvirtualObjectMethod: proc "c" (env: ^^JNINativeInterface, object: jobject, method: jmethodID, #c_vararg args: ..any) -> jobject,
	CallNonvirtualObjectMethodV: proc "c" (env: ^^JNINativeInterface, object: jobject, method: jmethodID, args: ^c.va_list) -> jobject,
	CallNonvirtualObjectMethodA: proc "c" (env: ^^JNINativeInterface, object: jobject, method: jmethodID, args: [^]jvalue) -> jobject,

	CallNonvirtualBooleanMethod: proc "c" (env: ^^JNINativeInterface, object: jobject, method: jmethodID, #c_vararg args: ..any) -> jboolean,
	CallNonvirtualBooleanMethodV: proc "c" (env: ^^JNINativeInterface, object: jobject, method: jmethodID, args: ^c.va_list) -> jboolean,
	CallNonvirtualBooleanMethodA: proc "c" (env: ^^JNINativeInterface, object: jobject, method: jmethodID, args: [^]jvalue) -> jboolean,

	CallNonvirtualByteMethod: proc "c" (env: ^^JNINativeInterface, object: jobject, method: jmethodID, #c_vararg args: ..any) -> jbyte,
	CallNonvirtualByteMethodV: proc "c" (env: ^^JNINativeInterface, object: jobject, method: jmethodID, args: ^c.va_list) -> jbyte,
	CallNonvirtualByteMethodA: proc "c" (env: ^^JNINativeInterface, object: jobject, method: jmethodID, args: [^]jvalue) -> jbyte,

	CallNonvirtualCharMethod: proc "c" (env: ^^JNINativeInterface, object: jobject, method: jmethodID, #c_vararg args: ..any) -> jchar,
	CallNonvirtualCharMethodV: proc "c" (env: ^^JNINativeInterface, object: jobject, method: jmethodID, args: ^c.va_list) -> jchar,
	CallNonvirtualCharMethodA: proc "c" (env: ^^JNINativeInterface, object: jobject, method: jmethodID, args: [^]jvalue) -> jchar,

	CallNonvirtualShortMethod: proc "c" (env: ^^JNINativeInterface, object: jobject, method: jmethodID, #c_vararg args: ..any) -> jshort,
	CallNonvirtualShortMethodV: proc "c" (env: ^^JNINativeInterface, object: jobject, method: jmethodID, args: ^c.va_list) -> jshort,
	CallNonvirtualShortMethodA: proc "c" (env: ^^JNINativeInterface, object: jobject, method: jmethodID, args: [^]jvalue) -> jshort,

	CallNonvirtualIntMethod: proc "c" (env: ^^JNINativeInterface, object: jobject, method: jmethodID, #c_vararg args: ..any) -> jint,
	CallNonvirtualIntMethodV: proc "c" (env: ^^JNINativeInterface, object: jobject, method: jmethodID, args: ^c.va_list) -> jint,
	CallNonvirtualIntMethodA: proc "c" (env: ^^JNINativeInterface, object: jobject, method: jmethodID, args: [^]jvalue) -> jint,

	CallNonvirtualLongMethod: proc "c" (env: ^^JNINativeInterface, object: jobject, method: jmethodID, #c_vararg args: ..any) -> jlong,
	CallNonvirtualLongMethodV: proc "c" (env: ^^JNINativeInterface, object: jobject, method: jmethodID, args: ^c.va_list) -> jlong,
	CallNonvirtualLongMethodA: proc "c" (env: ^^JNINativeInterface, object: jobject, method: jmethodID, args: [^]jvalue) -> jlong,

	CallNonvirtualFloatMethod: proc "c" (env: ^^JNINativeInterface, object: jobject, method: jmethodID, #c_vararg args: ..any) -> jfloat,
	CallNonvirtualFloatMethodV: proc "c" (env: ^^JNINativeInterface, object: jobject, method: jmethodID, args: ^c.va_list) -> jfloat,
	CallNonvirtualFloatMethodA: proc "c" (env: ^^JNINativeInterface, object: jobject, method: jmethodID, args: [^]jvalue) -> jfloat,

	CallNonvirtualDoubleMethod: proc "c" (env: ^^JNINativeInterface, object: jobject, method: jmethodID, #c_vararg args: ..any) -> jdouble,
	CallNonvirtualDoubleMethodV: proc "c" (env: ^^JNINativeInterface, object: jobject, method: jmethodID, args: ^c.va_list) -> jdouble,
	CallNonvirtualDoubleMethodA: proc "c" (env: ^^JNINativeInterface, object: jobject, method: jmethodID, args: [^]jvalue) -> jdouble,

	CallNonvirtualVoidMethod: proc "c" (env: ^^JNINativeInterface, object: jobject, method: jmethodID, #c_vararg args: ..any),
	CallNonvirtualVoidMethodV: proc "c" (env: ^^JNINativeInterface, object: jobject, method: jmethodID, args: ^c.va_list),
	CallNonvirtualVoidMethodA: proc "c" (env: ^^JNINativeInterface, object: jobject, method: jmethodID, args: [^]jvalue),

	GetFieldID: proc "c" (env: ^^JNINativeInterface, class: jclass, name, signature: cstring) -> jfieldID,

	GetObjectField: proc "c" (env: ^^JNINativeInterface, object: jobject, jfieldId: jfieldID) -> jobject,
	GetBooleanField: proc "c" (env: ^^JNINativeInterface, object: jobject, jfieldId: jfieldID) -> jboolean,
	GetByteField: proc "c" (env: ^^JNINativeInterface, object: jobject, jfieldId: jfieldID) -> jbyte,
	GetCharField: proc "c" (env: ^^JNINativeInterface, object: jobject, jfieldId: jfieldID) -> jchar,
	GetShortField: proc "c" (env: ^^JNINativeInterface, object: jobject, jfieldId: jfieldID) -> jshort,
	GetIntField: proc "c" (env: ^^JNINativeInterface, object: jobject, jfieldId: jfieldID) -> jint,
	GetLongField: proc "c" (env: ^^JNINativeInterface, object: jobject, jfieldId: jfieldID) -> jlong,
	GetFloatField: proc "c" (env: ^^JNINativeInterface, object: jobject, jfieldId: jfieldID) -> jfloat,
	GetDoubleField: proc "c" (env: ^^JNINativeInterface, object: jobject, jfieldId: jfieldID) -> jdouble,

	SetObjectField: proc "c" (env: ^^JNINativeInterface, object: jobject, jfieldId: jfieldID, value: jobject),
	SetBooleanField: proc "c" (env: ^^JNINativeInterface, object: jobject, jfieldId: jfieldID, value: jboolean),
	SetByteField: proc "c" (env: ^^JNINativeInterface, object: jobject, jfieldId: jfieldID, value: jbyte),
	SetCharField: proc "c" (env: ^^JNINativeInterface, object: jobject, jfieldId: jfieldID, value: jchar),
	SetShortField: proc "c" (env: ^^JNINativeInterface, object: jobject, jfieldId: jfieldID, value: jshort),
	SetIntField: proc "c" (env: ^^JNINativeInterface, object: jobject, jfieldId: jfieldID, value: jint),
	SetLongField: proc "c" (env: ^^JNINativeInterface, object: jobject, jfieldId: jfieldID, value: jlong),
	SetFloatField: proc "c" (env: ^^JNINativeInterface, object: jobject, jfieldId: jfieldID, value: jfloat),
	SetDoubleField: proc "c" (env: ^^JNINativeInterface, object: jobject, jfieldId: jfieldID, value: jdouble),

	GetStaticMethodId: proc "c" (env: ^^JNINativeInterface, class: jclass, name, signature: cstring) -> jmethodID,

	CallStaticObjectMethod: proc "c" (env: ^^JNINativeInterface, class: jclass, method: jmethodID, #c_vararg args: ..any) -> jobject,
	CallStaticObjectMethodV: proc "c" (env: ^^JNINativeInterface, class: jclass, method: jmethodID, args: ^c.va_list) -> jobject,
	CallStaticObjectMethodA: proc "c" (env: ^^JNINativeInterface, class: jclass, method: jmethodID, args: [^]jvalue) -> jobject,

	CallStaticBooleanMethod: proc "c" (env: ^^JNINativeInterface, class: jclass, method: jmethodID, #c_vararg args: ..any) -> jboolean,
	CallStaticBooleanMethodV: proc "c" (env: ^^JNINativeInterface, class: jclass, method: jmethodID, args: ^c.va_list) -> jboolean,
	CallStaticBooleanMethodA: proc "c" (env: ^^JNINativeInterface, class: jclass, method: jmethodID, args: [^]jvalue) -> jboolean,

	CallStaticByteMethod: proc "c" (env: ^^JNINativeInterface, class: jclass, method: jmethodID, #c_vararg args: ..any) -> jbyte,
	CallStaticByteMethodV: proc "c" (env: ^^JNINativeInterface, class: jclass, method: jmethodID, args: ^c.va_list) -> jbyte,
	CallStaticByteMethodA: proc "c" (env: ^^JNINativeInterface, class: jclass, method: jmethodID, args: [^]jvalue) -> jbyte,

	CallStaticCharMethod: proc "c" (env: ^^JNINativeInterface, class: jclass, method: jmethodID, #c_vararg args: ..any) -> jchar,
	CallStaticCharMethodV: proc "c" (env: ^^JNINativeInterface, class: jclass, method: jmethodID, args: ^c.va_list) -> jchar,
	CallStaticCharMethodA: proc "c" (env: ^^JNINativeInterface, class: jclass, method: jmethodID, args: [^]jvalue) -> jchar,

	CallStaticShortMethod: proc "c" (env: ^^JNINativeInterface, class: jclass, method: jmethodID, #c_vararg args: ..any) -> jshort,
	CallStaticShortMethodV: proc "c" (env: ^^JNINativeInterface, class: jclass, method: jmethodID, args: ^c.va_list) -> jshort,
	CallStaticShortMethodA: proc "c" (env: ^^JNINativeInterface, class: jclass, method: jmethodID, args: [^]jvalue) -> jshort,

	CallStaticIntMethod: proc "c" (env: ^^JNINativeInterface, class: jclass, method: jmethodID, #c_vararg args: ..any) -> jint,
	CallStaticIntMethodV: proc "c" (env: ^^JNINativeInterface, class: jclass, method: jmethodID, args: ^c.va_list) -> jint,
	CallStaticIntMethodA: proc "c" (env: ^^JNINativeInterface, class: jclass, method: jmethodID, args: [^]jvalue) -> jint,

	CallStaticFloatMethod: proc "c" (env: ^^JNINativeInterface, class: jclass, method: jmethodID, #c_vararg args: ..any) -> jfloat,
	CallStaticFloatMethodV: proc "c" (env: ^^JNINativeInterface, class: jclass, method: jmethodID, args: ^c.va_list) -> jfloat,
	CallStaticFloatMethodA: proc "c" (env: ^^JNINativeInterface, class: jclass, method: jmethodID, args: [^]jvalue) -> jfloat,

	CallStaticDoubleMethod: proc "c" (env: ^^JNINativeInterface, class: jclass, method: jmethodID, #c_vararg args: ..any) -> jdouble,
	CallStaticDoubleMethodV: proc "c" (env: ^^JNINativeInterface, class: jclass, method: jmethodID, args: ^c.va_list) -> jdouble,
	CallStaticDoubleMethodA: proc "c" (env: ^^JNINativeInterface, class: jclass, method: jmethodID, args: [^]jvalue) -> jdouble,

	CallStaticVoidMethod: proc "c" (env: ^^JNINativeInterface, class: jclass, method: jmethodID, #c_vararg args: ..any),
	CallStaticVoidMethodV: proc "c" (env: ^^JNINativeInterface, class: jclass, method: jmethodID, args: ^c.va_list),
	CallStaticVoidMethodA: proc "c" (env: ^^JNINativeInterface, class: jclass, method: jmethodID, args: [^]jvalue),

	GetStaticFieldID: proc "c" (env: ^^JNINativeInterface, class: jclass, name, signature: cstring) -> jfieldID,

	GetStaticObjectField: proc "c" (env: ^^JNINativeInterface, class: jclass, field: jfieldID) -> jobject,
	GetStaticBooleanField: proc "c" (env: ^^JNINativeInterface, class: jclass, field: jfieldID) -> jboolean,
	GetStaticByteField: proc "c" (env: ^^JNINativeInterface, class: jclass, field: jfieldID) -> jbyte,
	GetStaticCharField: proc "c" (env: ^^JNINativeInterface, class: jclass, field: jfieldID) -> jchar,
	GetStaticShortField: proc "c" (env: ^^JNINativeInterface, class: jclass, field: jfieldID) -> jshort,
	GetStaticIntField: proc "c" (env: ^^JNINativeInterface, class: jclass, field: jfieldID) -> jint,
	GetStaticLongField: proc "c" (env: ^^JNINativeInterface, class: jclass, field: jfieldID) -> jlong,
	GetStaticFloatField: proc "c" (env: ^^JNINativeInterface, class: jclass, field: jfieldID) -> jfloat,
	GetStaticDoubleField: proc "c" (env: ^^JNINativeInterface, class: jclass, field: jfieldID) -> jdouble,

	SetStaticObjectField: proc "c" (env: ^^JNINativeInterface, class: jclass, field: jfieldID, value: jobject),
	SetStaticBooleanField: proc "c" (env: ^^JNINativeInterface, class: jclass, field: jfieldID, value: jboolean),
	SetStaticByteField: proc "c" (env: ^^JNINativeInterface, class: jclass, field: jfieldID, value: jbyte),
	SetStaticCharField: proc "c" (env: ^^JNINativeInterface, class: jclass, field: jfieldID, value: jchar),
	SetStaticShortField: proc "c" (env: ^^JNINativeInterface, class: jclass, field: jfieldID, value: jshort),
	SetStaticIntField: proc "c" (env: ^^JNINativeInterface, class: jclass, field: jfieldID, value: jint),
	SetStaticLongField: proc "c" (env: ^^JNINativeInterface, class: jclass, field: jfieldID, value: jlong),
	SetStaticFloatField: proc "c" (env: ^^JNINativeInterface, class: jclass, field: jfieldID, value: jfloat),
	SetStaticDoubleField: proc "c" (env: ^^JNINativeInterface, class: jclass, field: jfieldID, value: jdouble),

	NewString: proc "c" (env: ^^JNINativeInterface, message: [^]jchar, message_length: jsize) -> jstring,
	GetStringLength: proc "c" (env: ^^JNINativeInterface, str: jstring) -> jsize,
	GetStringsChars: proc "c" (env: ^^JNINativeInterface, str: jstring, isCopy: ^jboolean) -> [^]jchar,
	ReleaseStringChars: proc "c" (env: ^^JNINativeInterface, str: jstring, chars: [^]jchar),
	NewStringUTF:  proc "c" (env: ^^JNINativeInterface, str: cstring) -> jstring,
	GetStringUTFLength: proc "c" (env: ^^JNINativeInterface, str: jstring) -> jsize,

	GetStringUTFChars: proc "c" (env: ^^JNINativeInterface, str: jstring, isCopy: ^jboolean) -> cstring,
	ReleaseStringUTFChars: proc "c" (env: ^^JNINativeInterface, str: jstring, utf: cstring),

	GetArrayLength: proc "c" (env: ^^JNINativeInterface, array: jarray) -> jsize,
	NewObjectArray: proc "c" (env: ^^JNINativeInterface, size: jsize, class: jclass, initalElement: jobject) -> jobjectArray,
	GetObjectArrayElement: proc "c" (env: ^^JNINativeInterface, array: jobjectArray, index: jsize) -> jobject,
	SetObjectArrayElement: proc "c" (env: ^^JNINativeInterface, array: jobjectArray, index: jsize, destinationObject: jobject),


	NewBooleanArray: proc "c" (env: ^^JNINativeInterface, size: jsize) -> jbooleanArray,
	NewByteArray: proc "c" (env: ^^JNINativeInterface, size: jsize) -> jbyteArray,
	NewCharArray: proc "c" (env: ^^JNINativeInterface, size: jsize) -> jcharArray,
	NewShortArray: proc "c" (env: ^^JNINativeInterface, size: jsize) -> jshortArray,
	NewIntArray: proc "c" (env: ^^JNINativeInterface, size: jsize) -> jintArray,
	NewLongArray: proc "c" (env: ^^JNINativeInterface, size: jsize) -> jlongArray,
	NewFlaotArray: proc "c" (env: ^^JNINativeInterface, size: jsize) -> jfloatArray,
	NewDoubleArray: proc "c" (env: ^^JNINativeInterface, size: jsize) -> jdoubleArray,

	GetBooleanArrayElements: proc "c" (env: ^^JNINativeInterface, array: jbooleanArray, ok: ^jboolean) -> [^]jboolean,
	GetByteArrayElements: proc "c" (env: ^^JNINativeInterface, array: jbooleanArray, ok: ^jboolean) -> [^]jbyte,
	GetCharArrayElements: proc "c" (env: ^^JNINativeInterface, array: jbooleanArray, ok: ^jboolean) -> [^]jchar,
	GetShortArrayElements: proc "c" (env: ^^JNINativeInterface, array: jbooleanArray, ok: ^jboolean) -> [^]jshort,
	GetIntArrayElements: proc "c" (env: ^^JNINativeInterface, array: jbooleanArray, ok: ^jboolean) -> [^]jint,
	GetLongArrayElements: proc "c" (env: ^^JNINativeInterface, array: jbooleanArray, ok: ^jboolean) -> [^]jlong,
	GetFloatArrayElements: proc "c" (env: ^^JNINativeInterface, array: jbooleanArray, ok: ^jboolean) -> [^]jfloat,
	GetDoubleArrayElements: proc "c" (env: ^^JNINativeInterface, array: jbooleanArray, ok: ^jboolean) -> [^]jdouble,

	ReleaseBooleanArrayElements: proc "c" (env: ^^JNINativeInterface, array: jbooleanArray, elems: [^]jboolean, mode: arrayReleaseMode),
	ReleaseByteArrayElements: proc "c" (env: ^^JNINativeInterface, array: jbooleanArray, elems: [^]jbyte, mode: arrayReleaseMode),
	ReleaseCharArrayElements: proc "c" (env: ^^JNINativeInterface, array: jbooleanArray, elems: [^]jchar, mode: arrayReleaseMode),
	ReleaseShortArrayElements: proc "c" (env: ^^JNINativeInterface, array: jbooleanArray, elems: [^]jshort, mode: arrayReleaseMode),
	ReleaseIntArrayElements: proc "c" (env: ^^JNINativeInterface, array: jbooleanArray, elems: [^]jint, mode: arrayReleaseMode),
	ReleaseLongArrayElements: proc "c" (env: ^^JNINativeInterface, array: jbooleanArray, elems: [^]jlong, mode: arrayReleaseMode),
	ReleaseFloatArrayElements: proc "c" (env: ^^JNINativeInterface, array: jbooleanArray, elems: [^]jfloat, mode: arrayReleaseMode),
	ReleaseDoubleArrayElements: proc "c" (env: ^^JNINativeInterface, array: jbooleanArray, elems: [^]jdouble, mode: arrayReleaseMode),

	GetBooleanArrayRegion: proc "c" (env: ^^JNINativeInterface, array: jbooleanArray, start, length: jsize, buffer: [^]jboolean),
	GetByteArrayRegion: proc "c" (env: ^^JNINativeInterface, array: jbyteArray, start, length: jsize, buffer: [^]jbyte),
	GetCharArrayRegion: proc "c" (env: ^^JNINativeInterface, array: jcharArray, start, length: jsize, buffer: [^]jchar),
	GetShortArrayRegion: proc "c" (env: ^^JNINativeInterface, array: jshortArray, start, length: jsize, buffer: [^]jshort),
	GetIntArrayRegion: proc "c" (env: ^^JNINativeInterface, array: jintArray, start, length: jsize, buffer: [^]jint),
	GetLongArrayRegion: proc "c" (env: ^^JNINativeInterface, array: jlongArray, start, length: jsize, buffer: [^]jlong),
	GetFloatArrayRegion: proc "c" (env: ^^JNINativeInterface, array: jfloatArray, start, length: jsize, buffer: [^]jfloat),
	GetDoubleArrayRegion: proc "c" (env: ^^JNINativeInterface, array: jdoubleArray, start, length: jsize, buffer: [^]jdouble),

	SetBooleanArrayRegion: proc "c" (env: ^^JNINativeInterface, array: jbooleanArray, start, length: jsize, buffer: [^]jboolean),
	SetByteArrayRegion: proc "c" (env: ^^JNINativeInterface, array: jbyteArray, start, length: jsize, buffer: [^]jbyte),
	SetCharArrayRegion: proc "c" (env: ^^JNINativeInterface, array: jcharArray, start, length: jsize, buffer: [^]jchar),
	SetShortArrayRegion: proc "c" (env: ^^JNINativeInterface, array: jshortArray, start, length: jsize, buffer: [^]jshort),
	SetIntArrayRegion: proc "c" (env: ^^JNINativeInterface, array: jintArray, start, length: jsize, buffer: [^]jint),
	SetLongArrayRegion: proc "c" (env: ^^JNINativeInterface, array: jlongArray, start, length: jsize, buffer: [^]jlong),
	SetFloatArrayRegion: proc "c" (env: ^^JNINativeInterface, array: jfloatArray, start, length: jsize, buffer: [^]jfloat),
	SetDoubleArrayRegion: proc "c" (env: ^^JNINativeInterface, array: jdoubleArray, start, length: jsize, buffer: [^]jdouble),

	RegisterNatives: proc "c" (env: ^^JNINativeInterface, class: jclass, native_methods: [^]JNINativeMethod, native_methods_count: jint) -> jint,
	UnregisterNatives: proc "c" (env: ^^JNINativeInterface, class: jclass) -> jint,
	MonitorEnter: proc "c" (env: ^^JNINativeInterface, object: jobject) -> jint,
	MonitorExit: proc "c" (env: ^^JNINativeInterface, object: jobject) -> jint,
	GetJavaVM: proc "c" (env: ^^JNINativeInterface, vm: ^^^JNIInvokeInterface) -> jint, // parece que o ols está achando um erro que não existe kkkk

	GetStringRegion: proc "c" (env: ^^JNINativeInterface, str: jstring, start, length: jsize, buffer: [^]jchar),
	GetStringUTFRegion: proc "c" (env: ^^JNINativeInterface, str: jstring, start, length: jsize, buffer: [^]u8),

	GetPrimitiveArrayCritical: proc "c" (env: ^^JNINativeInterface, array: jarray, is_copy: ^jbool) -> rawptr,
	ReleasePrimitiveArrayCritical: proc "c" (env: ^^JNINativeInterface, array: jarray, c_array: [^]rawptr, mode: arrayReleaseMode),

	GetStringCritical: proc "c" (env: ^^JNINativeInterface, str: jstring, is_copy: ^jbool) -> [^]jchar,
	ReleaseStringCritical: proc "c" (env: ^^JNINativeInterface, str: jstring, c_array: [^]jchar),

	NewWeakGlobalRef: proc "c" (env: ^^JNINativeInterface, object: jobject)  -> jweak,
	DeleteWeakGlobalRef: proc "c" (env: ^^JNINativeInterface, weak_ref: jweak),

	ExceptionCheck: proc "c" (env: ^^JNINativeInterface) -> jboolean,

	NewDirectByteBuffer: proc "c" (env: ^^JNINativeInterface, address: rawptr, capacity: jlong) -> jobject,
	GetDirectBufferAddress: proc "c" (env: ^^JNINativeInterface, object: jobject) -> rawptr,
	GetDirectBufferCapacity: proc "c" (env: ^^JNINativeInterface, object: jobject) -> jlong,

	GetObjectRefType: proc "c" (env: ^^JNINativeInterface, object: jobject) -> jobjectRefType
}

JNIInvokeInterface :: struct {
	reserverd0: rawptr,
	reserverd1: rawptr,
	reserverd2: rawptr,

	DestroyJavaVm: proc "c" (vm: ^^JNIInvokeInterface) -> jint,
	AttachCurrentThread: proc "c" (vm: ^^JNIInvokeInterface, env: ^^^JNINativeInterface, thr_args: rawptr) -> jint,
	DetachCurrentThread: proc "c" (vm: ^^JNIInvokeInterface) -> jint,
	GetEnv: proc "c" (vm: ^^JNIInvokeInterface, env: ^^rawptr, version: jint) -> jint,
	AttachCurrentThreadAsDaemon: proc "c" (vm: ^^JNIInvokeInterface, env: ^^^JNINativeInterface, args: rawptr) -> jint,
}


JavaVMAttachArgs :: struct {
	version: jint,
	name: cstring,
	group: jobject,
}

JavaVMOption :: struct {
	optionString: cstring,
	extraInfo: rawptr,
}

JavaVMInitArgs :: struct {
	version: jint,
	nOptions: jint,
	options: [^]JavaVMOption,
	ignoreUnrecognized: jboolean,
}

JNI_FALSE :: false
JNI_TRUE :: true

JNI_VERSION_1_1 :: 0x00010001
JNI_VERSION_1_2 :: 0x00010002
JNI_VERSION_1_4 :: 0x00010004
JNI_VERSION_1_6 :: 0x00010006

JNI_OK        ::  0         /* no error */
JNI_ERR       ::  -1        /* generic error */
JNI_EDETACHED ::  -2        /* thread detached from the VM */
JNI_EVERSION  ::  -3        /* JNI version error */
JNI_ENOMEM    ::  -4        /* Out of memory */
JNI_EEXIST    ::  -5        /* VM already created */
JNI_EINVAL    ::  -6        /* Invalid argument */
