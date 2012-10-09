#ifndef _jACBrFramework_JNIHelper_H_
#define _jACBrFramework_JNIHelper_H_

#include <stdlib.h>

#include "jni.h"
#include "ACBrECF.h"

typedef int(*GetStringEntryPoint)(const INTPTR, PCHAR, int);
typedef int(*GetIntEntryPoint)(const INTPTR);
typedef int(*GetDoubleEntryPoint)(const INTPTR, double*);

typedef int(*SetStringEntryPoint)(const INTPTR, const PCHAR);
typedef int(*SetIntEntryPoint)(const INTPTR, const int);
typedef int(*SetBoolEntryPoint)(const INTPTR, const BOOL);
typedef int(*SetDoubleEntryPoint)(const INTPTR, const double);

const int BUFF_SIZE = 256;

INTPTR GetACBrHandle(JNIEnv *env, jobject obj);
void SetACBrHandle(JNIEnv *env, jobject obj, INTPTR handle);

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

void CheckResult(JNIEnv *env, const INTPTR handle, const int ret);
void ThrowJavaException(JNIEnv *env, const INTPTR handle);

#endif