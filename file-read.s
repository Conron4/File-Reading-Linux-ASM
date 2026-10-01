/*
  SPDX-License-Identifier: GPL-V2-Only
  Copyright (C) 2026 Connor A. Hopley
 
  This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 2.

  This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

  You should have received a copy of the GNU General Public License along with this program; if not, write to the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA. 
 */
.global _start
.text
  _start:
    movq $2, %rax # Syscall for open
    movq $file, %rdi # Select file to open
    syscall

    movq %rax, %rdi # Move the return value(fd) to the fd arg of read
    movq $0, %rax # Read syscall
    movq $buffer, %rsi # Give read a buffer
    movq $64, %rdx # Amount of bytes to attempt to read
    syscall

    movq %rax, %rdx # Move the return value (amount of bytes read) to amount of bytes to write
    movq $1, %rax # Write syscall
    movq $1, %rdi # STDOUT fd
    movq $buffer, %rsi # File contents
    syscall

    movq $1, %rax # See above
    movq $1, %rdi # See above
    movq $newline, %rsi # Mov newline(LF) to write
    movq $1, %rdx # 1 byte write
    syscall

    movq $60, %rax # Exit syscall
    movq $0, %rdi # Exit Code(0 success)
    syscall

.data
  file:
    .ascii "test\0" # Filename null terminated
  buffer:
    .fill 64, 1, 0 # 64 byte filled with 0
  newline:
    .byte 10 # Byte 0x0A/10 = newline(LF)
