#include <stdlib.h>

#include "jni.h"
#include "ACBr.h"
#include "JNIHelper.h";


ACBR_HANDLE GetACBrHandle(JNIEnv *env, jobject obj)
{
	jclass clazz = env->GetObjectClass(obj);
	jfieldID field = env->GetFieldID(clazz, "handle", "I");
	return (ACBR_HANDLE)env->GetIntField(obj, field);
}

void SetACBrHandle(JNIEnv *env, jobject obj, ACBR_HANDLE handle)
{
	jclass clazz = env->GetObjectClass(obj);
	jfieldID field = env->GetFieldID(clazz, "handle", "I");
	env->SetIntField(obj, field, (jint)handle);
}

jstring GetString(GetStringEntryPoint function, JNIEnv *env, jobject obj)
{
	ACBR_HANDLE handle = GetACBrHandle(env, obj);
	PCHAR nBuff = NULL;

	nBuff = new char[BUFF_SIZE];
	int ret = function(handle, nBuff, BUFF_SIZE);

	if (ret < 0)
	{
		if (nBuff != NULL) delete nBuff;
		ThrowJavaException(env, handle);
	}
	else
	{
		jstring str = env->NewStringUTF(nBuff);
		if (nBuff != NULL) delete nBuff;
		return str;
	}
}

jbyteArray GetByteArray(GetStringEntryPoint function, JNIEnv *env, jobject obj)
{
	ACBR_HANDLE handle = GetACBrHandle(env, obj);

	PCHAR nBuff = (PCHAR)malloc(BUFF_SIZE);
	int ret = function(handle, nBuff, BUFF_SIZE);

	if (ret < 0)
	{
		free(nBuff);
		ThrowJavaException(env, handle);
	}
	else
	{
		free(nBuff);
		return 0;
	}
}

void SetString(SetStringEntryPoint function, JNIEnv *env, jobject obj, jstring value)
{
	ACBR_HANDLE handle = GetACBrHandle(env, obj);

	jboolean isCopy = (jboolean)false;
	const PCHAR nValue = (PCHAR)env->GetStringUTFChars(value, &isCopy);
	
	int ret = function(handle, nValue);
	
	env->ReleaseStringUTFChars(value, nValue);

	CheckResult(env, handle, ret);
}

jint GetInt(GetIntEntryPoint function, JNIEnv *env, jobject obj)
{
	ACBR_HANDLE handle = GetACBrHandle(env, obj);
	int ret = function(handle);

	CheckResult(env, handle, ret);

	return (jint)ret;
}

void SetInt(SetIntEntryPoint function, JNIEnv *env, jobject obj, jint value)
{
	ACBR_HANDLE handle = GetACBrHandle(env, obj);
	int ret = function(handle, (int)value);
	CheckResult(env, handle, ret);
}

jboolean GetBool(GetIntEntryPoint function, JNIEnv *env, jobject obj)
{
	ACBR_HANDLE handle = GetACBrHandle(env, obj);
	int ret = function(handle);
	CheckResult(env, handle, ret);

	return (jboolean)(ret == 1);
}
 
void SetBool(SetBoolEntryPoint function, JNIEnv *env, jobject obj, jboolean value)
{
	ACBR_HANDLE handle = GetACBrHandle(env, obj);
	int ret = function(handle, (BOOL)value);
	CheckResult(env, handle, ret);
}

jdouble GetDouble(GetDoubleEntryPoint function, JNIEnv *env, jobject obj)
{
	ACBR_HANDLE handle = GetACBrHandle(env, obj);
	
	double nValue;
	int ret = function(handle, &nValue);
	CheckResult(env, handle, ret);

	return (jdouble)nValue;
}

void SetDouble(SetDoubleEntryPoint function, JNIEnv *env, jobject obj, jdouble value)
{
	ACBR_HANDLE handle = GetACBrHandle(env, obj);
	int ret = function(handle, (double)value);
	CheckResult(env, handle, ret);
}

long doubleToTicks(const double value)
{
	if ((value >= 2958466.0) || (value <= -657435.0)) return 0;

	long num = (long) ((value * 86400000.0) + ((value >= 0.0) ? 0.5 : -0.5));
	if (num < 0L)
	{
		num -= (num % 0x5265c00L) * 2L;
	}

	num += 0x3680b5e1fc00L;
	if ((num < 0L) || (num >= 0x11efae44cb400L)) return 0;

	long ticks = (num * 0x2710L);

	const long DIFF_IN_MILLIS = 11644473600000L;
	long javaTime = ( ticks / 10000 ) - DIFF_IN_MILLIS;

	return javaTime;
}

jobject GetDate(GetDoubleEntryPoint function, JNIEnv *env, jobject obj)
{
	ACBR_HANDLE handle = GetACBrHandle(env, obj);

	jdouble value;
	int ret = function(handle, &value);
	
	if (ret < 0)
	{
		CheckResult(env, handle, ret);
		return NULL;
	}
	else
	{
		jclass clazz = env->FindClass("jACBr/Util");
		jmethodID method = env->GetStaticMethodID(clazz, "doubleToDate", "(D)Ljava/util/Date;");
		
		return env->CallObjectMethod(clazz, method, value);
	}
}

void CheckResult(JNIEnv *env, const ACBR_HANDLE handle, const int ret)
{
	if (ret < 0)
	{
		if (ret == -1)
		{
			ThrowJavaException(env, handle);
		}
		else if (ret == -2)
		{
			jclass clazz = env->FindClass("jACBr/ACBrException");
			env->ThrowNew(clazz, "Componente ACBr não inicializado.");
		}
	}
}

void ThrowJavaException(JNIEnv *env, const ACBR_HANDLE handle)
{
	PCHAR buff = (PCHAR)malloc(BUFF_SIZE);
	ECF_GetUltimoErro(handle, buff, BUFF_SIZE);

	jclass clazz = env->FindClass("jACBr/ACBrException");
	env->ThrowNew(clazz, buff);

	free(buff);
}