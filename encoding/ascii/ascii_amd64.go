//go:build amd64 && !noasm

package ascii

import (
	"github.com/stuartcarnie/go-simd/internal/cpu"
)

func init() {
	if cpu.X86.HasAVX2 {
		validFn = validate_ascii_fast_avx2
	} else if cpu.X86.HasSSE42 {
		validFn = validate_ascii_fast_sse4
	} else {
		validFn = validate_ascii_go
	}
}
