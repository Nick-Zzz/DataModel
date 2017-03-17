/* Copyright (C) 2006   Manuel Novoa III    <mjn3@codepoet.org>
 *
 * GNU Library General Public License (LGPL) version 2 or later.
 *
 * Dedicated to Toni.  See uClibc/DEDICATION.mjn3 for details.
 */

#ifndef _EBOXRESOLV_H
#define _EBOXRESOLV_H

#define __EBOXRESOLV_HAS_IPV6__
#define __EBOXRESOLV_HAS_THREADS__
#define L_res_init
#define L_res_query

#include "eboxpthread.h"


#ifndef __set_errno
#define __set_errno(val) ((errno) = (val))
#endif

#ifndef __set_h_errno
#define __set_h_errno(val) ((errno) = (val))
#endif

#undef DEBUG

#endif /* _EBOXRESOLV_H */
