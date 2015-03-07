#!/usr/bin/env bash

DCACHE_H="$(find -L /lib/modules/$(uname -r) -name 'dcache.h')"

if [[ -z "${DCACHE_H}" ]]; then
	LINUX_DIRS="$(find /usr/src -type d -name "$(uname -r)*")"
	DCACHE_H="$(find ${LINUX_DIRS} -name 'dcache.h')"
fi

if [[ -z "${DCACHE_H}" ]]; then
	echo $0: File not found: dcache.h >&2
	exit 1
fi

if ! grep -q __GENKSYMS__ "${DCACHE_H}"; then
	echo $0: __GENKSYMS__ not found in ${DCACHE_H}
	exit 0
fi

echo Post-patching inode.c as __GENKSYMS__ was found in ${DCACHE_H}
sed -i.bak -e "s|\(D_ALIAS_IS_A_MEMBER_OF_UNION_D_U)\)|\1 \&\& 0 /* use d_u.d_alias as __GENKSYMS__ was found in ${DCACHE_H} */|" inode.c

if [[ $? -gt 0 ]]; then
	echo $0: Failed to patch inode.c >&2
	exit 1
fi

exit 0
