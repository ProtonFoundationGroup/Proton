// Copyright 2017 The go-ethereum Authors
// This file is part of the go-ethereum library.
//
// The go-ethereum library is free software: you can redistribute it and/or modify
// it under the terms of the GNU Lesser General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// The go-ethereum library is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU Lesser General Public License for more details.
//
// You should have received a copy of the GNU Lesser General Public License
// along with the go-ethereum library. If not, see <http://www.gnu.org/licenses/>.

package core

// Constants containing the genesis allocation of built-in genesis blocks.
// Their content is an RLP-encoded list of (address, balance) tuples.
// Use mkalloc.go to create/update them.

// nolint: misspell
const (
	mainnetAllocData = "\xe3\xe2\x94\xd7\x13\x9e\f\x1a*\xc7JZ\x1dRk\xb5\x9c\x96\xbe\xf5\xbc\xbe\x11\x8c O\xce^>%\x02a\x10\x00\x00\x00"
	testnetAllocData = "\xe4\xe3\x94,\x14\xca\xc6o\u82cf,\u02ef\xeb\xff\xc1A\x8eVe3e\x8d\f\x9f,\x9c\xd0Ft\xed\xea@\x00\x00\x00"
	rinkebyAllocData = "\xe4\xe3\x94,\x14\xca\xc6o\u82cf,\u02ef\xeb\xff\xc1A\x8eVe3e\x8d\f\x9f,\x9c\xd0Ft\xed\xea@\x00\x00\x00"
)

