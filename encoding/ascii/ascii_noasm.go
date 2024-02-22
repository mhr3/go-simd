//go:build !amd64 || noasm

package ascii

func init() {
	validFn = validate_ascii_go
}
