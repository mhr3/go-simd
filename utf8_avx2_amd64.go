// +build !noasm

package simd

import "unsafe"

//go:noescape
func __validate_utf8_fast_avx2(state, buf, len, res unsafe.Pointer)

func validate_utf8_fast_avx2(v []byte) bool {
	var (
		state validateState
		res   uint64
	)
	__validate_utf8_fast_avx2(unsafe.Pointer(&state), unsafe.Pointer(&v[0]), unsafe.Pointer(uintptr(len(v))), unsafe.Pointer(&res))
	return res > 1
}
