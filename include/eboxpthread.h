#ifndef _EBOXRESOLV_MUTEX_H
#define _EBOXRESOLV_MUTEX_H

#include <features.h>

#ifdef __EBOXRESOLV_HAS_THREADS__

#ifndef _GNU_SOURCE
#define _GNU_SOURCE
#endif

#include <pthread.h>

#define __EBOXRESOLV_MUTEX_TYPE				pthread_mutex_t

#define __EBOXRESOLV_MUTEX(M)				pthread_mutex_t M
#define __EBOXRESOLV_MUTEX_INIT(M,I)			pthread_mutex_t M = I
#define __EBOXRESOLV_MUTEX_STATIC(M,I)			static pthread_mutex_t M = I
#define __EBOXRESOLV_MUTEX_EXTERN(M)			extern pthread_mutex_t M

#define __EBOXRESOLV_MUTEX_LOCK_CANCEL_UNSAFE(M)								\
		pthread_mutex_lock(&(M))

#define __EBOXRESOLV_MUTEX_UNLOCK_CANCEL_UNSAFE(M)								\
		pthread_mutex_unlock(&(M))

#define __EBOXRESOLV_MUTEX_TRYLOCK_CANCEL_UNSAFE(M)								\
		pthread_mutex_trylock(&(M))

#define __EBOXRESOLV_MUTEX_CONDITIONAL_LOCK(M,C)								\
	do {												\
		struct _pthread_cleanup_buffer __infunc_pthread_cleanup_buffer;				\
		if (C) {										\
			_pthread_cleanup_push_defer(&__infunc_pthread_cleanup_buffer,			\
					   (void (*) (void *))pthread_mutex_unlock,			\
										&(M));			\
			__pthread_mutex_lock(&(M));							\
		}											\
		((void)0)

#define __EBOXRESOLV_MUTEX_CONDITIONAL_UNLOCK(M,C)								\
		if (C) {										\
			_pthread_cleanup_pop_restore(&__infunc_pthread_cleanup_buffer,1);		\
		}											\
	} while (0)

#define __EBOXRESOLV_MUTEX_AUTO_LOCK_VAR(A)		int A

#define __EBOXRESOLV_MUTEX_AUTO_LOCK(M,A,V)									\
        __EBOXRESOLV_MUTEX_CONDITIONAL_LOCK(M,((A=(V)) == 0))

#define __EBOXRESOLV_MUTEX_AUTO_UNLOCK(M,A)									\
        __EBOXRESOLV_MUTEX_CONDITIONAL_UNLOCK(M,(A == 0))

#define __EBOXRESOLV_MUTEX_LOCK(M)										\
        __EBOXRESOLV_MUTEX_CONDITIONAL_LOCK(M, 1)

#define __EBOXRESOLV_MUTEX_UNLOCK(M)									\
        __EBOXRESOLV_MUTEX_CONDITIONAL_UNLOCK(M, 1)

#else

#define __EBOXRESOLV_MUTEX(M)					void *__EBOXRESOLV_MUTEX_DUMMY_ ## M
#define __EBOXRESOLV_MUTEX_INIT(M,I)				extern void *__EBOXRESOLV_MUTEX_DUMMY_ ## M
#define __EBOXRESOLV_MUTEX_STATIC(M,I)				extern void *__EBOXRESOLV_MUTEX_DUMMY_ ## M
#define __EBOXRESOLV_MUTEX_EXTERN(M)				extern void *__EBOXRESOLV_MUTEX_DUMMY_ ## M

#define __EBOXRESOLV_MUTEX_LOCK_CANCEL_UNSAFE(M)		((void)0)
#define __EBOXRESOLV_MUTEX_UNLOCK_CANCEL_UNSAFE(M)		((void)0)
#define __EBOXRESOLV_MUTEX_TRYLOCK_CANCEL_UNSAFE(M)		(0)	/* Always succeed? */

#define __EBOXRESOLV_MUTEX_CONDITIONAL_LOCK(M,C)		((void)0)
#define __EBOXRESOLV_MUTEX_CONDITIONAL_UNLOCK(M,C)		((void)0)

#define __EBOXRESOLV_MUTEX_AUTO_LOCK_VAR(A)			((void)0)
#define __EBOXRESOLV_MUTEX_AUTO_LOCK(M,A,V)			((void)0)
#define __EBOXRESOLV_MUTEX_AUTO_UNLOCK(M,A)			((void)0)

#define __EBOXRESOLV_MUTEX_LOCK(M)				((void)0)
#define __EBOXRESOLV_MUTEX_UNLOCK(M)				((void)0)

#endif

#endif /* _EBOXRESOLV_MUTEX_H */
