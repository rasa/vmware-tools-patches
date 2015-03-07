#!/usr/bin/env bash

DCACHE_H=

if [[ -d "/lib/modules/$(uname -r)" ]]; then
	DCACHE_H="$(find -L /lib/modules/$(uname -r) -name 'dcache.h' | head -n 1)"
fi

if [[ -z "${DCACHE_H}" ]]; then
	LINUX_DIRS="$(find /usr/src -type d -name "$(uname -r)*")"
	if [[ -z "${LINUX_DIRS}" ]]; then
		echo $0: Directory not found: /usr/src/$(uname -r)\* >&2
		exit 2
	fi
	DCACHE_H="$(find ${LINUX_DIRS} -name 'dcache.h' | head -n 1)"
fi

if [[ -z "${DCACHE_H}" ]]; then
	echo $0: File not found: dcache.h >&2
	exit 1
fi

# On Debian, if __GENKSYMS__ is not defined, then d_alias is inside struct d_u
if ! grep -q __GENKSYMS__ "${DCACHE_H}"; then
	echo $0: No changes made, as __GENKSYMS__ is not in ${DCACHE_H}
	exit 0
fi

echo Post-patching inode.c as __GENKSYMS__ was found in ${DCACHE_H}
sed -i.bak -e "s|\(D_ALIAS_IS_A_MEMBER_OF_UNION_D_U)\)|\1 \&\& 0 /* use d_u.d_alias as __GENKSYMS__ was found in ${DCACHE_H} */|" inode.c

if [[ $? -gt 0 ]]; then
	echo $0: Failed to patch inode.c >&2
	exit 1
fi

exit 0
