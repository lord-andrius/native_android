package ndk

import "core:c"

jboolean :: b8
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

_JNIEnv :: struct{}
_JavaVM :: struct{}
C_JNIEnv :: ^JNINativeInterface

JNIEnv :: ^JNINativeInterface
JavaVM :: ^JNINativeInterface

JNINativeInterface :: struct {
	reserved0: rawptr,
	reserved1: rawptr,
	reserved2: rawptr,
	reserved3: rawptr,

	GetVersion: proc(env: ^JNIEnv) -> jint,
	DefineClass: proc(env: ^JNIEnv, object: jobject, buffer: [^]jbyte, buffer_size: jsize) -> jclass,
	FindClass: proc(env: ^JNIEnv, classname: cstring) -> jclass,

	FromReflectMethod: proc(env: ^JNIEnv, object: jobject) -> jmethodID,
	FromReflectedField: proc(env: ^JNIEnv, object: jobject) -> jfieldID,
	ToReflectedMethod: proc(env: ^JNIEnv, class: jclass, method: jmethodID, boolean: jboolean) -> jobject,

	GetSuperClass: proc(env: ^JNIEnv, class: jclass) -> jclass,
	IsAssignableFrom: proc(env: ^JNIEnv, class1: jclass, class2: jclass) -> jboolean,

	ToReflectedField: proc(env: ^JNIEnv, class: jclass, field: jfieldID, boolean: jboolean) -> jobject,

	Throw: proc(env: ^JNIEnv, throwable: jthrowable) -> jint,
	ThrowNew: proc(env: ^JNIEnv, class: jclass, message: cstring) -> jint,
	ExceptionOcurred: proc(env: ^JNIEnv) -> jthrowable,
	ExceptionDescribe: proc(env: ^JNIEnv),
	ExceptionClear: proc(env: ^JNIEnv),
	FatalError: proc(env: ^JNIEnv, message: cstring)

	PushLocalFrame: proc(env: ^JNIEnv, capacity: jint) -> jint,
	PopLocalFrame: proc(env: ^JNIEnv, result: jobject) -> jint,


	NewGlobalRef: proc(env: ^JNIEnv, object: jobject) -> jobject,
	DeleteGlobalRef: proc(env: ^JNIEnv, object: jobject),
	DeleteLocalRef: proc(env: ^JNIEnv, object: jobject),
	IsSameObject: proc(env: ^JNIEnv, object1, object2: jobject) -> jboolean,

	NewLocalRef: proc(env: ^JNIEnv, object: jobject) -> jobject,
	EnsureLocalCapacity: proc(env: ^JNIEnv, capacity: jint) -> jint,

	AllocObject: proc(env: ^JNIEnv, class: jclass) -> jobject,
	NewObject: proc(env: ^JNIEnv, calss: jclass, method: jmethodID, #c_vararg args: ..any) -> jobject,
	NewObjectV: proc(env: ^JNIEnv, class: jclass, method: jmethodID, va_list: ^c.va_list) -> jobject,
	NewObjectA: proc(env: ^JNIEnv, class: jclass, methos: jmethodID, value: ^jvalue) -> jobject,

	GetObjectClass: proc(env: ^JNIEnv, object: jobject) -> jclass,
	IsInstanceOf: proc(env: ^JNIEnv, object: jobject, class: jclass) -> jboolean,
	GetMethodId: proc(env: ^JNIEnv, classs: jclass, name, signature: cstring) -> jmethodID,

	CallObjectMethod: proc(env: ^JNIEnv, object: jobject, method: jmethodID, #c_vararg args: ..any) -> jobject,
	CallObjectMethodV: proc(env: ^JNIEnv, object: jobject, method: jmethodID, args: ^c.va_list) -> jobject,
	CallObjectMethodA: proc(env: ^JNIEnv, object: jobject, method: jmethodID, valur: ^jvalue) -> jobject,

	CallBooleanMethod: proc(env: ^JNIEnv, object: jobject, method: jmethodID, #c_vararg args: ..any) -> jobject,
	CallBooleanMethodV: proc(env: ^JNIEnv, object: jobject, method: jmethodID, args: ^c.va_list) -> jobject,
	CallBooleanMethodA: proc(env: ^JNIEnv, object: jobject, method: jmethodID, valur: ^jvalue) -> jobject,

	CallBooleanMethod: proc(env: ^JNIEnv, object: jobject, method: jmethodID, #c_vararg args: ..any) -> jobject,
	CallBooleanMethodV: proc(env: ^JNIEnv, object: jobject, method: jmethodID, args: ^c.va_list) -> jobject,
	CallBooleanMethodA: proc(env: ^JNIEnv, object: jobject, method: jmethodID, valur: ^jvalue) -> jobject,

	CallByteMethod: proc(env: ^JNIEnv, object: jobject, method: jmethodID, #c_vararg args: ..any) -> jboolean,
	CallByteMethodV: proc(env: ^JNIEnv, object: jobject, method: jmethodID, args: ^c.va_list) -> jboolean,
	CallByteMethodA: proc(env: ^JNIEnv, object: jobject, method: jmethodID, valur: ^jvalue) -> jboolean,

	CallCharMethod: proc(env: ^JNIEnv, object: jobject, method: jmethodID, #c_vararg args: ..any) -> jchar,
	CallCharMethodV: proc(env: ^JNIEnv, object: jobject, method: jmethodID, args: ^c.va_list) -> jchar,
	CallCharMethodA: proc(env: ^JNIEnv, object: jobject, method: jmethodID, valur: ^jvalue) -> jchar,

	CallShortMethod: proc(env: ^JNIEnv, object: jobject, method: jmethodID, #c_vararg args: ..any) -> jshort,
	CallShortMethodV: proc(env: ^JNIEnv, object: jobject, method: jmethodID, args: ^c.va_list) -> jshort,
	CallShortMethodA: proc(env: ^JNIEnv, object: jobject, method: jmethodID, valur: ^jvalue) -> jshort,

	CallIntMethod: proc(env: ^JNIEnv, object: jobject, method: jmethodID, #c_vararg args: ..any) -> jint,
	CallIntMethodV: proc(env: ^JNIEnv, object: jobject, method: jmethodID, args: ^c.va_list) -> jint,
	CallIntMethodA: proc(env: ^JNIEnv, object: jobject, method: jmethodID, valur: ^jvalue) -> jint,

	CallLongMethod: proc(env: ^JNIEnv, object: jobject, method: jmethodID, #c_vararg args: ..any) -> jlong,
	CallLongMethodV: proc(env: ^JNIEnv, object: jobject, method: jmethodID, args: ^c.va_list) -> jlong,
	CallLongMethodA: proc(env: ^JNIEnv, object: jobject, method: jmethodID, valur: ^jvalue) -> jlong,

	CallFloatMethod: proc(env: ^JNIEnv, object: jobject, method: jmethodID, #c_vararg args: ..any) -> jfloat,
	CallFloatMethodV: proc(env: ^JNIEnv, object: jobject, method: jmethodID, args: ^c.va_list) -> jfloat,
	CallFloatMethodA: proc(env: ^JNIEnv, object: jobject, method: jmethodID, valur: ^jvalue) -> jfloat,

	CallDoubleMethod: proc(env: ^JNIEnv, object: jobject, method: jmethodID, #c_vararg args: ..any) -> jdouble,
	CallDoubleMethodV: proc(env: ^JNIEnv, object: jobject, method: jmethodID, args: ^c.va_list) -> jdouble,
	CallDoubleMethodA: proc(env: ^JNIEnv, object: jobject, method: jmethodID, valur: ^jvalue) -> jdouble,

	CallVoidMethod: proc(env: ^JNIEnv, object: jobject, method: jmethodID, #c_vararg args: ..any),
	CallVoidMethodV: proc(env: ^JNIEnv, object: jobject, method: jmethodID, args: ^c.va_list),
	CallVoidMethodA: proc(env: ^JNIEnv, object: jobject, method: jmethodID, valur: ^jvalue),

	CallNonvirtualObjectMethod: proc(env: ^JNIEnv, object: jobject, method: jmethodID, #c_vararg args: ..any) -> jobject,
	CallNonvirtualObjectMethod: proc(env: ^JNIEnv, object: jobject, method: jmethodID, args: ^c.va_list) -> jobject,
	CallNonvirtualObjectMethod: proc(env: ^JNIEnv, object: jobject, method: jmethodID, args: [^]jvalue) -> jobject,

	CallNonvirtualBooleanMethod: proc(env: ^JNIEnv, object: jobject, method: jmethodID, #c_vararg args: ..any) -> jboolean,
	CallNonvirtualBooleanMethod: proc(env: ^JNIEnv, object: jobject, method: jmethodID, args: ^c.va_list) -> jboolean,
	CallNonvirtualBooleanMethod: proc(env: ^JNIEnv, object: jobject, method: jmethodID, args: [^]jvalue) -> jboolean,

	CallNonvirtualByteMethod: proc(env: ^JNIEnv, object: jobject, method: jmethodID, #c_vararg args: ..any) -> jbyte,
	CallNonvirtualByteMethod: proc(env: ^JNIEnv, object: jobject, method: jmethodID, args: ^c.va_list) -> jbyte,
	CallNonvirtualByteMethod: proc(env: ^JNIEnv, object: jobject, method: jmethodID, args: [^]jvalue) -> jbyte,

	CallNonvirtualCharMethod: proc(env: ^JNIEnv, object: jobject, method: jmethodID, #c_vararg args: ..any) -> jchar,
	CallNonvirtualCharMethod: proc(env: ^JNIEnv, object: jobject, method: jmethodID, args: ^c.va_list) -> jchar,
	CallNonvirtualCharMethod: proc(env: ^JNIEnv, object: jobject, method: jmethodID, args: [^]jvalue) -> jchar,

	CallNonvirtualShortMethod: proc(env: ^JNIEnv, object: jobject, method: jmethodID, #c_vararg args: ..any) -> jshort,
	CallNonvirtualShortMethod: proc(env: ^JNIEnv, object: jobject, method: jmethodID, args: ^c.va_list) -> jshort,
	CallNonvirtualShortMethod: proc(env: ^JNIEnv, object: jobject, method: jmethodID, args: [^]jvalue) -> jshort,

	CallNonvirtualIntMethod: proc(env: ^JNIEnv, object: jobject, method: jmethodID, #c_vararg args: ..any) -> jint,
	CallNonvirtualIntMethod: proc(env: ^JNIEnv, object: jobject, method: jmethodID, args: ^c.va_list) -> jint,
	CallNonvirtualIntMethod: proc(env: ^JNIEnv, object: jobject, method: jmethodID, args: [^]jvalue) -> jint,

	CallNonvirtualLongMethod: proc(env: ^JNIEnv, object: jobject, method: jmethodID, #c_vararg args: ..any) -> jlong,
	CallNonvirtualLongMethod: proc(env: ^JNIEnv, object: jobject, method: jmethodID, args: ^c.va_list) -> jlong,
	CallNonvirtualLongMethod: proc(env: ^JNIEnv, object: jobject, method: jmethodID, args: [^]jvalue) -> jlong,

	CallNonvirtualFloatMethod: proc(env: ^JNIEnv, object: jobject, method: jmethodID, #c_vararg args: ..any) -> jfloat,
	CallNonvirtualFloatMethod: proc(env: ^JNIEnv, object: jobject, method: jmethodID, args: ^c.va_list) -> jfloat,
	CallNonvirtualFloatMethod: proc(env: ^JNIEnv, object: jobject, method: jmethodID, args: [^]jvalue) -> jfloat,

	CallNonvirtualDoubleMethod: proc(env: ^JNIEnv, object: jobject, method: jmethodID, #c_vararg args: ..any) -> jdouble,
	CallNonvirtualDoubleMethod: proc(env: ^JNIEnv, object: jobject, method: jmethodID, args: ^c.va_list) -> jdouble,
	CallNonvirtualDoubleMethod: proc(env: ^JNIEnv, object: jobject, method: jmethodID, args: [^]jvalue) -> jdouble,

	CallNonvirtualVoidMethod: proc(env: ^JNIEnv, object: jobject, method: jmethodID, #c_vararg args: ..any),
	CallNonvirtualVoidMethod: proc(env: ^JNIEnv, object: jobject, method: jmethodID, args: ^c.va_list),
	CallNonvirtualVoidMethod: proc(env: ^JNIEnv, object: jobject, method: jmethodID, args: [^]jvalue),

	GetFieldID: proc(env: ^JNIEnv, class: jclass, name, signature: cstring) -> jfieldID,

	GetObjectField: proc(env: ^JNIEnv, object: jobject, jfieldId: jfieldID) -> jobject,
	GetBooleanField: proc(env: ^JNIEnv, object: jobject, jfieldId: jfieldID) -> jboolean,
	GetByteField: proc(env: ^JNIEnv, object: jobject, jfieldId: jfieldID) -> jbyte,
	GetCharField: proc(env: ^JNIEnv, object: jobject, jfieldId: jfieldID) -> jchar,
	GetShortField: proc(env: ^JNIEnv, object: jobject, jfieldId: jfieldID) -> jshort,
	GetIntField: proc(env: ^JNIEnv, object: jobject, jfieldId: jfieldID) -> jint,
	GetLongField: proc(env: ^JNIEnv, object: jobject, jfieldId: jfieldID) -> jlong,
	GetFloatField: proc(env: ^JNIEnv, object: jobject, jfieldId: jfieldID) -> jfloat,
	GetDoubleField: proc(env: ^JNIEnv, object: jobject, jfieldId: jfieldID) -> jdouble,

	SetObjectField: proc(env: ^JNIEnv, object: jobject, jfieldId: jfieldID, value: jobject),
	SetBooleanField: proc(env: ^JNIEnv, object: jobject, jfieldId: jfieldID, value: jboolean),
	SetByteField: proc(env: ^JNIEnv, object: jobject, jfieldId: jfieldID, value: jbyte),
	SetCharField: proc(env: ^JNIEnv, object: jobject, jfieldId: jfieldID, value: jchar),
	SetShortField: proc(env: ^JNIEnv, object: jobject, jfieldId: jfieldID, value: jshort),
	SetIntField: proc(env: ^JNIEnv, object: jobject, jfieldId: jfieldID, value: jint),
	SetLongField: proc(env: ^JNIEnv, object: jobject, jfieldId: jfieldID, value: jlong),
	SetFloatField: proc(env: ^JNIEnv, object: jobject, jfieldId: jfieldID, value: jfloat),
	SetDoubleField: proc(env: ^JNIEnv, object: jobject, jfieldId: jfieldID, value: jdouble),

	GetStaticMethodId: proc(env: ^JNIEnv, class: jclass, name, signature: cstring) -> jmethodID,

	CallStaticObjectMethod: proc(env: ^JNIEnv, class: jclass, method: jmethodID, #c_vararg args: ..any) -> jobject,
	CallStaticObjectMethodV: proc(env: ^JNIEnv, class: jclass, method: jmethodID, args: ^c.va_list) -> jobject,
	CallStaticObjectMethodV: proc(env: ^JNIEnv, class: jclass, method: jmethodID, args: [^]jvalue) -> jobject,

	CallStaticBooleanMethod: proc(env: ^JNIEnv, class: jclass, method: jmethodID, #c_vararg args: ..any) -> jboolean,
	CallStaticBooleanMethodV: proc(env: ^JNIEnv, class: jclass, method: jmethodID, args: ^c.va_list) -> jboolean,
	CallStaticBooleanMethodV: proc(env: ^JNIEnv, class: jclass, method: jmethodID, args: [^]jvalue) -> jboolean,

	CallStaticByteMethod: proc(env: ^JNIEnv, class: jclass, method: jmethodID, #c_vararg args: ..any) -> jbyte,
	CallStaticByteMethodV: proc(env: ^JNIEnv, class: jclass, method: jmethodID, args: ^c.va_list) -> jbyte,
	CallStaticByteMethodV: proc(env: ^JNIEnv, class: jclass, method: jmethodID, args: [^]jvalue) -> jbyte,

	CallStaticCharMethod: proc(env: ^JNIEnv, class: jclass, method: jmethodID, #c_vararg args: ..any) -> jchar,
	CallStaticCharMethodV: proc(env: ^JNIEnv, class: jclass, method: jmethodID, args: ^c.va_list) -> jchar,
	CallStaticCharMethodV: proc(env: ^JNIEnv, class: jclass, method: jmethodID, args: [^]jvalue) -> jchar,

	CallStaticShortMethod: proc(env: ^JNIEnv, class: jclass, method: jmethodID, #c_vararg args: ..any) -> jshort,
	CallStaticShortMethodV: proc(env: ^JNIEnv, class: jclass, method: jmethodID, args: ^c.va_list) -> jshort,
	CallStaticShortMethodV: proc(env: ^JNIEnv, class: jclass, method: jmethodID, args: [^]jvalue) -> jshort,

	CallStaticIntMethod: proc(env: ^JNIEnv, class: jclass, method: jmethodID, #c_vararg args: ..any) -> jint,
	CallStaticIntMethodV: proc(env: ^JNIEnv, class: jclass, method: jmethodID, args: ^c.va_list) -> jint,
	CallStaticIntMethodV: proc(env: ^JNIEnv, class: jclass, method: jmethodID, args: [^]jvalue) -> jint,

	CallStaticFloatMethod: proc(env: ^JNIEnv, class: jclass, method: jmethodID, #c_vararg args: ..any) -> jfloat,
	CallStaticFloatMethodV: proc(env: ^JNIEnv, class: jclass, method: jmethodID, args: ^c.va_list) -> jfloat,
	CallStaticFloatMethodV: proc(env: ^JNIEnv, class: jclass, method: jmethodID, args: [^]jvalue) -> jfloat,

	CallStaticDoubleMethod: proc(env: ^JNIEnv, class: jclass, method: jmethodID, #c_vararg args: ..any) -> jdouble,
	CallStaticDoubleMethodV: proc(env: ^JNIEnv, class: jclass, method: jmethodID, args: ^c.va_list) -> jdouble,
	CallStaticDoubleMethodV: proc(env: ^JNIEnv, class: jclass, method: jmethodID, args: [^]jvalue) -> jdouble,

	CallStaticVoidMethod: proc(env: ^JNIEnv, class: jclass, method: jmethodID, #c_vararg args: ..any),
	CallStaticVoidMethodV: proc(env: ^JNIEnv, class: jclass, method: jmethodID, args: ^c.va_list),
	CallStaticVoidMethodV: proc(env: ^JNIEnv, class: jclass, method: jmethodID, args: [^]jvalue),

	GetStaticFieldID: proc(env: ^JNIEnv, class: jclass, name, signature: cstring) -> jfieldID,

	GetStaticObjectField: proc(env: ^JNIEnv, class: class, field: jfieldID) -> jobject,
	GetStaticBooleanField: proc(env: ^JNIEnv, class: class, field: jfieldID) -> jboolean,
	GetStaticByteField: proc(env: ^JNIEnv, class: class, field: jfieldID) -> jbyte,
	GetStaticCharField: proc(env: ^JNIEnv, class: class, field: jfieldID) -> jchar,
	GetStaticShortField: proc(env: ^JNIEnv, class: class, field: jfieldID) -> jshort,
	GetStaticIntField: proc(env: ^JNIEnv, class: class, field: jfieldID) -> jint,
	GetStaticLongField: proc(env: ^JNIEnv, class: class, field: jfieldID) -> jlong,
	GetStaticFloatField: proc(env: ^JNIEnv, class: class, field: jfieldID) -> jfloat,
	GetStaticDoubleField: proc(env: ^JNIEnv, class: class, field: jfieldID) -> jdouble,

	SetStaticObjectField: proc(env: ^JNIEnv, class: jclass, field: jfieldID, value: jobject),
	SetStaticBooleanField: proc(env: ^JNIEnv, class: jclass, field: jfieldID, value: jboolean),
	SetStaticByteField: proc(env: ^JNIEnv, class: jclass, field: jfieldID, value: jbyte),
	SetStaticCharField: proc(env: ^JNIEnv, class: jclass, field: jfieldID, value: jChar),
	SetStaticShortField: proc(env: ^JNIEnv, class: jclass, field: jfieldID, value: jshort),
	SetStaticIntField: proc(env: ^JNIEnv, class: jclass, field: jfieldID, value: jint),
	SetStaticLongField: proc(env: ^JNIEnv, class: jclass, field: jfieldID, value: jlong),
	SetStaticFloatField: proc(env: ^JNIEnv, class: jclass, field: jfieldID, value: jfloat),
	SetStaticDoubleField: proc(env: ^JNIEnv, class: jclass, field: jfieldID, value: jdouble),

	NewString: proc(env: ^JNIEnv, message: [^]jchar, message_length: jsize) -> jstring,
	GetStringLength: proc(env: ^JNIEnv, str: jstring) -> jsize,
	GetStringsChars: proc(env: ^JNIEnv, str: jstring, isCopy: ^jboolean) -> [^]jchar,
	ReleaseStringChars: proc(env: ^JNIEnv, str: jstring, chars: [^]jchar),
	NewStringUTF:  proc(env: ^JNIEnv, str: cstring) -> jstring,
	GetStringUTFLength: proc(env: ^JNIEnv, str: jstring) -> jsize,

	GetStringUTFChars: proc(env: ^JNIEnv, str: jstring, isCopy: ^jboolean) -> cstring,
	ReleaseStringUTFChars: proc(env: ^JNIEnv, str: jstring, utf: cstring),

	GetArrayLength: proc(env: ^JNIEnv, array: jarray) -> jsize,
	NewObjectArray: proc(env: ^JNIEnv, size: jsize, class: jclass, initalElement: jobject) -> jobjectArray,
	GetObjectArrayElement: proc(env: ^JNIEnv, array: jobjectArray, index: jsize) -> jobject,
	SetObjectArrayElement: proc(env: ^JNIEnv, array: jobjectArray, index: jsize, destinationObject: jobject)


	NewBooleanArray: proc(env: ^JNIEnv, size: jsize) -> jbooleanArray,
	NewByteArray: proc(env: ^JNIEnv, size: jsize) -> jbyteArray,
	NewCharArray: proc(env: ^JNIEnv, size: jsize) -> jcharArray,
	NewShortArray: proc(env: ^JNIEnv, size: jsize) -> jshortArray,
	NewIntArray: proc(env: ^JNIEnv, size: jsize) -> jintArray,
	NewLongArray: proc(env: ^JNIEnv, size: jsize) -> jlongArray,
	NewFlaotArray: proc(env: ^JNIEnv, size: jsize) -> jfloatArray,
	NewDoubleArray: proc(env: ^JNIEnv, size: jsize) -> jdoubleArray,

	GetBooleanArrayElements: proc(env: ^JNIEnv, array: jbooleanArray, ok: ^jboolean) -> [^]jboolean,
	GetByteArrayElements: proc(env: ^JNIEnv, array: jbooleanArray, ok: ^jboolean) -> [^]jbyte,
	GetCharArrayElements: proc(env: ^JNIEnv, array: jbooleanArray, ok: ^jboolean) -> [^]jchar,
	GetShortArrayElements: proc(env: ^JNIEnv, array: jbooleanArray, ok: ^jboolean) -> [^]jshort,
	GetIntArrayElements: proc(env: ^JNIEnv, array: jbooleanArray, ok: ^jboolean) -> [^]jint,
	GetLongArrayElements: proc(env: ^JNIEnv, array: jbooleanArray, ok: ^jboolean) -> [^]jlong,
	GetFloatArrayElements: proc(env: ^JNIEnv, array: jbooleanArray, ok: ^jboolean) -> [^]jfloat,
	GetDoubleArrayElements: proc(env: ^JNIEnv, array: jbooleanArray, ok: ^jboolean) -> [^]jdouble,

	ReleaseBooleanArrayElements: proc(env: ^JNIEnv, array: jbooleanArray, elems: [^]jboolean, mode: arrayReleaseMode),
	ReleaseByteArrayElements: proc(env: ^JNIEnv, array: jbooleanArray, elems: [^]jbyte, mode: arrayReleaseMode),
	ReleaseCharArrayElements: proc(env: ^JNIEnv, array: jbooleanArray, elems: [^]jchar, mode: arrayReleaseMode),
	ReleaseShortArrayElements: proc(env: ^JNIEnv, array: jbooleanArray, elems: [^]jshor, mode: arrayReleaseMode),
	ReleaseIntArrayElements: proc(env: ^JNIEnv, array: jbooleanArray, elems: [^]jint, mode: arrayReleaseMode),
	ReleaseLongArrayElements: proc(env: ^JNIEnv, array: jbooleanArray, elems: [^]jlong, mode: arrayReleaseMode),
	ReleaseFloatArrayElements: proc(env: ^JNIEnv, array: jbooleanArray, elems: [^]jflaot, mode: arrayReleaseMode),
	ReleaseDoubleArrayElements: proc(env: ^JNIEnv, array: jbooleanArray, elems: [^]jdouble, mode: arrayReleaseMode),

	GetBooleanArrayRegion: proc(env: ^JNIEnv, array: jbooleanArray, start, length: jsize, buffer: [^]jboolean),
	GetByteArrayRegion: proc(env: ^JNIEnv, array: jbyteArray, start, length: jsize, buffer: [^]jbyte),
	GetCharArrayRegion: proc(env: ^JNIEnv, array: jcharArray, start, length: jsize, buffer: [^]jchar),
	GetShortArrayRegion: proc(env: ^JNIEnv, array: jshortArray, start, length: jsize, buffer: [^]jshort),
	GetIntArrayRegion: proc(env: ^JNIEnv, array: jintArray, start, length: jsize, buffer: [^]jint),
	GetLongArrayRegion: proc(env: ^JNIEnv, array: jlongArray, start, length: jsize, buffer: [^]jlong),
	GetFloatArrayRegion: proc(env: ^JNIEnv, array: jfloatArray, start, length: jsize, buffer: [^]jfloat),
	GetDoubleArrayRegion: proc(env: ^JNIEnv, array: jdoubleArray, start, length: jsize, buffer: [^]jdouble),

	SetBooleanArrayRegion: proc(env: ^JNIEnv, array: jbooleanArray, start, length: jsize, buffer: [^]jboolean),
	SetByteArrayRegion: proc(env: ^JNIEnv, array: jbyteArray, start, length: jsize, buffer: [^]jbyte),
	SetCharArrayRegion: proc(env: ^JNIEnv, array: jcharArray, start, length: jsize, buffer: [^]jchar),
	SetShortArrayRegion: proc(env: ^JNIEnv, array: jshortArray, start, length: jsize, buffer: [^]jshort),
	SetIntArrayRegion: proc(env: ^JNIEnv, array: jintArray, start, length: jsize, buffer: [^]jint),
	SetLongArrayRegion: proc(env: ^JNIEnv, array: jlongArray, start, length: jsize, buffer: [^]jlong),
	SetFloatArrayRegion: proc(env: ^JNIEnv, array: jfloatArray, start, length: jsize, buffer: [^]jfloat),
	SetDoubleArrayRegion: proc(env: ^JNIEnv, array: jdoubleArray, start, length: jsize, buffer: [^]jdouble),

	RegisterNatives: proc(env: ^JNIEnv, class: jclass, native_methods: [^]JNINativeMethod, native_methods_count: jint) -> jint,
	UnregisterNatives: proc(env: ^JNIJNIEnv, class: jclass) -> jint,
	MonitorEnter: proc(env: ^JNIEnv, object: jobject) -> jint,
	MonitorExit: proc(env: ^JNIEnv, object: jobject) -> jint,
	GetJavaVM: proc(env: ^JNIEnv, vm: ^^JavaVM) -> jint,

	GetStringRegion: proc(env: ^JNIEnv, str: jstring, start, length: jsize, buffer: [^]jchar),
	GetStringUTFRegion: proc(env: ^JNIEnv, str: jstring, start, length: jsize, buffer: [^]char),

	GetPrimitiveArrayCritical: proc(env: ^JNIEnv, array: jarray, is_copy: ^jbool) -> rawptr,
	ReleasePrimitiveArrayCritical: proc(env: ^JNIEnv, array: jarray, c_array: [^]rawptr, mode: arrayReleaseMode),

	GetStringCritical: proc(env: ^JNIEnv, str: jstring, is_copy: ^jbool) -> [^]jchar,
	ReleaseStringCritical: proc(env: ^JNIEnv, str: jstring, c_array: [^]jchar),

	NewWeakGlobalRef: proc(env: ^JNIEnv, object: jobject)  -> jweak,
	DeleteWeakGlobalRef: proc(env: ^JNIEnv, weak_ref: jwejweak),

	ExceptionCheck: proc(env: ^JNIEnv) -> jboolean,

	NewDirectByteBuffer: proc(env: ^JNIEnv, address: rawptr, capacity: jlong) -> jobject,
	GetDirectBufferAddress: proc(env: ^JNIEnv, object: jobject) -> rawptr,
	GetDirectBufferCapacity: proc(env: ^JNIEnv, object: jobject) -> jlong,

	GetObjectRefType: proc(env: ^JNIEnv, object: jobject) -> jobjectRefType
}

JNIInvokeInterface :: struct {
	reserverd0: rawptr,
	reserverd1: rawptr,
	reserverd2: rawptr,

	DestroyJavaVm: proc(vm: ^JavaVM) -> jint,
	AttachCurrentThread: proc(vm: ^JavaVM, env: ^^JNIEnv, thr_args: rawptr) -> jint,
	DetachCurrentThread: proc(vm: ^JavaVM) -> jint,
	GetEnv: proc(vm: ^JavaVM, env: ^^rawptr, version: jint) -> jint,
	AttachCurrentThreadAsDaemon: proc(vm: ^JavaVM, env: ^^JNIEnv, args: rawptr) -> jint,
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
	options: [^]JavaVmOption,
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
