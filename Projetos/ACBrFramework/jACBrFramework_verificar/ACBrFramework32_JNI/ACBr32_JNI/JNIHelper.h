#ifndef _jACBr_JNIHelper_H_
#define _jACBr_JNIHelper_H_

#include <stdlib.h>

#include "jni.h"
#include "ACBr.h"

typedef int(*GetStringEntryPoint)(const ACBR_HANDLE, PCHAR, int);
typedef int(*GetIntEntryPoint)(const ACBR_HANDLE);
typedef int(*GetDoubleEntryPoint)(const ACBR_HANDLE, double*);

typedef int(*SetStringEntryPoint)(const ACBR_HANDLE, const PCHAR);
typedef int(*SetIntEntryPoint)(const ACBR_HANDLE, const int);
typedef int(*SetBoolEntryPoint)(const ACBR_HANDLE, const BOOL);
typedef int(*SetDoubleEntryPoint)(const ACBR_HANDLE, const double);

const int BUFF_SIZE = 256;

ACBR_HANDLE GetACBrHandle(JNIEnv *env, jobject obj);
void SetACBrHandle(JNIEnv *env, jobject obj, ACBR_HANDLE handle);

jstring GetString(GetStringEntryPoint function, JNIEnv *env, jobject obj);
jbyteArray GetByteArray(GetStringEntryPoint function, JNIEnv *env, jobject obj);
void SetString(SetStringEntryPoint function, JNIEnv *env, jobject obj, jstring value);

jint GetInt(GetIntEntryPoint function, JNIEnv *env, jobject obj);
void SetInt(SetIntEntryPoint function, JNIEnv *env, jobject obj, jint value);

jboolean GetBool(GetIntEntryPoint function, JNIEnv *env, jobject obj);
void SetBool(SetBoolEntryPoint function, JNIEnv *env, jobject obj, jboolean value);

jdouble GetDouble(GetDoubleEntryPoint function, JNIEnv *env, jobject obj);
void SetDouble(SetDoubleEntryPoint function, JNIEnv *env, jobject obj, jdouble value);

jobject GetDate(GetDoubleEntryPoint function, JNIEnv *env, jobject obj);

void CheckResult(JNIEnv *env, const ACBR_HANDLE handle, const int ret);
void ThrowJavaException(JNIEnv *env, const ACBR_HANDLE handle);

#endif