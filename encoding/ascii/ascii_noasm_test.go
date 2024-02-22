//go:build !amd64 || noasm

package ascii

import (
	"fmt"
	"math/rand"
	"testing"
)

func makeASCII(n int) []byte {
	data := make([]byte, n)
	for i := range data {
		data[i] = byte(rand.Uint32() & 0x7f)
	}
	return data
}

type ValidTest struct {
	in  string
	exp bool
}

var validTests = []ValidTest{
	{"", true},
	{"a", true},
	{"abc", true},
	{"Ж", false},
	{"ЖЖ", false},
	{"брэд-ЛГТМ", false},
	{"☺☻☹", false},
	{"aa\xe2", false},
	{string([]byte{66, 250}), false},
	{string([]byte{66, 250, 67}), false},
	{"a\uFFFDb", false},
	{string("\xF4\x8F\xBF\xBF"), false},     // U+10FFFF
	{string("\xF4\x90\x80\x80"), false},     // U+10FFFF+1; exp of range
	{string("\xF7\xBF\xBF\xBF"), false},     // 0x1FFFFF; exp of range
	{string("\xFB\xBF\xBF\xBF\xBF"), false}, // 0x3FFFFFF; exp of range
	{string("\xc0\x80"), false},             // U+0000 encoded in two bytes: incorrect
	{string("\xed\xa0\x80"), false},         // U+D800 high surrogate (sic)
	{string("\xed\xbf\xbf"), false},         // U+DFFF low surrogate (sic)
}

func TestValid(t *testing.T) {
	for _, tc := range validTests {
		t.Run(fmt.Sprintf("Valid(%q)", tc.in), func(t *testing.T) {
			got := Valid([]byte(tc.in))
			if got != tc.exp {
				t.Errorf("Valid(%q) = %v; want %v", tc.in, got, tc.exp)
			}
		})
	}
}

func BenchmarkValid(b *testing.B) {
	benchmarks := []struct {
		name    string
		validFN func([]byte) bool
	}{
		{
			name:    "go.Valid",
			validFN: validate_ascii_go,
		},
	}
	for _, bm := range benchmarks {
		b.Run(bm.name, func(b *testing.B) {
			for _, n := range []int{100, 10000, 1000000} {
				buf := makeASCII(n)
				b.Run(fmt.Sprintf("%d", n), func(b *testing.B) {
					b.SetBytes(int64(len(buf)))
					for i := 0; i < b.N; i++ {
						bm.validFN(buf)
					}
				})
			}
		})
	}
}
