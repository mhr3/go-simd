//go:build !amd64 || noasm

package utf8

func init() {
	validFn = validate_utf8_go
}
