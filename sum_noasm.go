//go:build !amd64 || noasm

package simd

func init() {
	sumFloat64 = sum_float64_go
}
