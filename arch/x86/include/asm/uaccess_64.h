/* SPDX-License-Identifier: GPL-2.0 */
#ifndef _ASM_X86_UACCESS_64_H
#define _ASM_X86_UACCESS_64_H

/*
 * User space memory access functions
 */
#include <linux/compiler.h>
#include <linux/lockdep.h>
#include <linux/kasan-checks.h>
#include <asm/alternative.h>
#include <asm/cpufeatures.h>
#include <asm/page.h>

/*
 * Copy To/From Userspace
 */

/* Handles exceptions in both to and from, but doesn't do access_ok */
__must_check unsigned long
rep_movs_alternative(void *to, const void *from, unsigned len);

static __always_inline __must_check unsigned long
copy_user_generic(void *to, const void *from, unsigned long len)
{
	stac();
	/*
	 * If CPU has FSRM feature, use 'rep movs'.
	 * Otherwise, use rep_movs_alternative.
	 */
	asm volatile(
		"1:\n\t"
		ALTERNATIVE("rep movsb",
			    "call rep_movs_alternative", ALT_NOT(X86_FEATURE_FSRM))
		"2:\n"
		_ASM_EXTABLE_UA(1b, 2b)
		:"+c" (len), "+D" (to), "+S" (from), ASM_CALL_CONSTRAINT
		: : "memory", "rax", "r8", "r9", "r10", "r11");
	clac();
	return len;
}

static __always_inline __must_check unsigned long
raw_copy_from_user(void *dst, const void __user *src, unsigned long size)
{
	return copy_user_generic(dst, (__force void *)src, size);
}

static __always_inline __must_check unsigned long
raw_copy_to_user(void __user *dst, const void *src, unsigned long size)
{
	return copy_user_generic((__force void *)dst, src, size);
}

extern long __copy_user_nocache(void *dst, const void __user *src, unsigned size);
extern long __copy_user_flushcache(void *dst, const void __user *src, unsigned size);

static inline int
__copy_from_user_inatomic_nocache(void *dst, const void __user *src,
				  unsigned size)
{
	long ret;
	kasan_check_write(dst, size);
	stac();
	ret = __copy_user_nocache(dst, src, size);
	clac();
	return ret;
}

static inline int
__copy_from_user_flushcache(void *dst, const void __user *src, unsigned size)
{
	kasan_check_write(dst, size);
	return __copy_user_flushcache(dst, src, size);
}

/*
 * Zero Userspace.
 */

__must_check unsigned long
rep_stos_alternative(void __user *addr, unsigned long len);

static __always_inline __must_check unsigned long __clear_user(void __user *addr, unsigned long size)
{
	might_fault();
	stac();

	/*
	 * No memory constraint because it doesn't change any memory gcc
	 * knows about.
	 */
	asm volatile(
		"1:\n\t"
		ALTERNATIVE("rep stosb",
			    "call rep_stos_alternative", ALT_NOT(X86_FEATURE_FSRS))
		"2:\n"
	       _ASM_EXTABLE_UA(1b, 2b)
	       : "+c" (size), "+D" (addr), ASM_CALL_CONSTRAINT
	       : "a" (0));

	clac();

	return size;
}

static __always_inline unsigned long clear_user(void __user *to, unsigned long n)
{
	if (access_ok(to, n))
		return __clear_user(to, n);
	return n;
}
#endif /* _ASM_X86_UACCESS_64_H */
