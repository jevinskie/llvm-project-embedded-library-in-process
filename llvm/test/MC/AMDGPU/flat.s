// RUN: llvm-mc -triple=amdgcn -mcpu=bonaire -show-encoding %s | FileCheck %s --check-prefix=CIVI --check-prefix=CI
// RUN: not llvm-mc -triple=amdgcn -mcpu=tonga -show-encoding %s | FileCheck %s --check-prefix=CIVI --check-prefix=VI

// RUN: not llvm-mc -triple=amdgcn -mcpu=tonga %s 2>&1 | FileCheck %s --check-prefix=NOVI --implicit-check-not=error:
// RUN: not llvm-mc -triple=amdgcn %s 2>&1 | FileCheck %s --check-prefix=NOSI --implicit-check-not=error:
// RUN: not llvm-mc -triple=amdgcn -mcpu=tahiti %s 2>&1 | FileCheck %s --check-prefix=NOSI --implicit-check-not=error:

//===----------------------------------------------------------------------===//
// Operands
//===----------------------------------------------------------------------===//

flat_load_dword v1, v[3:4]
// NOSI: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU
// CI: flat_load_dword v1, v[3:4] ; encoding: [0x00,0x00,0x30,0xdc,0x03,0x00,0x00,0x01]
// VI: flat_load_dword v1, v[3:4] ; encoding: [0x00,0x00,0x50,0xdc,0x03,0x00,0x00,0x01]

flat_load_dword v1, v[3:4] glc
// NOSI: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU
// CI: flat_load_dword v1, v[3:4] glc ; encoding: [0x00,0x00,0x31,0xdc,0x03,0x00,0x00,0x01]
// VI: flat_load_dword v1, v[3:4] glc ; encoding: [0x00,0x00,0x51,0xdc,0x03,0x00,0x00,0x01]

flat_load_dword v1, v[3:4] glc slc
// NOSI: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU
// CI: flat_load_dword v1, v[3:4] glc slc ; encoding: [0x00,0x00,0x33,0xdc,0x03,0x00,0x00,0x01]
// VI: flat_load_dword v1, v[3:4] glc slc ; encoding: [0x00,0x00,0x53,0xdc,0x03,0x00,0x00,0x01]

flat_store_dword v[3:4], v1
// NOSI: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU
// CIVI: flat_store_dword v[3:4], v1 ; encoding: [0x00,0x00,0x70,0xdc,0x03,0x01,0x00,0x00]

flat_store_dword v[3:4], v1 glc
// NOSI: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU
// CIVI: flat_store_dword v[3:4], v1 glc ; encoding: [0x00,0x00,0x71,0xdc,0x03,0x01,0x00,0x00]

flat_store_dword v[3:4], v1 glc slc
// NOSI: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU
// CIVI: flat_store_dword v[3:4], v1 glc slc ; encoding: [0x00,0x00,0x73,0xdc,0x03,0x01,0x00,0x00]


flat_store_dword v[3:4], v1 slc
// NOSI: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU
// CIVI: flat_store_dword v[3:4], v1 slc ; encoding: [0x00,0x00,0x72,0xdc,0x03,0x01,0x00,0x00]

// FIXME: For atomic instructions, glc must be placed immediately following
// the data regiser.  These forms aren't currently supported:
// FIXME: offset:0 required
// flat_atomic_add v1, v[3:4], v5 slc glc

flat_atomic_add v1, v[3:4], v5 offset:0 glc slc
// NOSI: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU
// CI: flat_atomic_add v1, v[3:4], v5 glc slc ; encoding: [0x00,0x00,0xcb,0xdc,0x03,0x05,0x00,0x01]
// VI: flat_atomic_add v1, v[3:4], v5 glc slc ; encoding: [0x00,0x00,0x0b,0xdd,0x03,0x05,0x00,0x01]

flat_atomic_add v[3:4], v5 slc
// NOSI: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU
// CI: flat_atomic_add v[3:4], v5 slc ; encoding: [0x00,0x00,0xca,0xdc,0x03,0x05,0x00,0x00]
// VI: flat_atomic_add v[3:4], v5 slc ; encoding: [0x00,0x00,0x0a,0xdd,0x03,0x05,0x00,0x00]

//===----------------------------------------------------------------------===//
// Instructions
//===----------------------------------------------------------------------===//

flat_load_ubyte v1, v[3:4]
// NOSI: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU
// CI: flat_load_ubyte v1, v[3:4] ; encoding: [0x00,0x00,0x20,0xdc,0x03,0x00,0x00,0x01]
// VI: flat_load_ubyte v1, v[3:4] ; encoding: [0x00,0x00,0x40,0xdc,0x03,0x00,0x00,0x01]

flat_load_sbyte v1, v[3:4]
// NOSI: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU
// CI: flat_load_sbyte v1, v[3:4] ; encoding: [0x00,0x00,0x24,0xdc,0x03,0x00,0x00,0x01]
// VI: flat_load_sbyte v1, v[3:4] ; encoding: [0x00,0x00,0x44,0xdc,0x03,0x00,0x00,0x01]

flat_load_ushort v1, v[3:4]
// NOSI: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU
// CI: flat_load_ushort v1, v[3:4] ; encoding: [0x00,0x00,0x28,0xdc,0x03,0x00,0x00,0x01]
// VI: flat_load_ushort v1, v[3:4] ; encoding: [0x00,0x00,0x48,0xdc,0x03,0x00,0x00,0x01]

flat_load_sshort v1, v[3:4]
// NOSI: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU
// CI: flat_load_sshort v1, v[3:4] ; encoding: [0x00,0x00,0x2c,0xdc,0x03,0x00,0x00,0x01]
// VI: flat_load_sshort v1, v[3:4] ; encoding: [0x00,0x00,0x4c,0xdc,0x03,0x00,0x00,0x01]

flat_load_dword v1, v[3:4]
// NOSI: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU
// CI: flat_load_dword v1, v[3:4] ; encoding: [0x00,0x00,0x30,0xdc,0x03,0x00,0x00,0x01]
// VI: flat_load_dword v1, v[3:4] ; encoding: [0x00,0x00,0x50,0xdc,0x03,0x00,0x00,0x01]

flat_load_dwordx2 v[1:2], v[3:4]
// NOSI: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU
// CI: flat_load_dwordx2 v[1:2], v[3:4] ; encoding: [0x00,0x00,0x34,0xdc,0x03,0x00,0x00,0x01]
// VI: flat_load_dwordx2 v[1:2], v[3:4] ; encoding: [0x00,0x00,0x54,0xdc,0x03,0x00,0x00,0x01]

flat_load_dwordx4 v[5:8], v[3:4]
// NOSI: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU
// CI: flat_load_dwordx4 v[5:8], v[3:4] ; encoding: [0x00,0x00,0x38,0xdc,0x03,0x00,0x00,0x05]
// VI: flat_load_dwordx4 v[5:8], v[3:4] ; encoding: [0x00,0x00,0x5c,0xdc,0x03,0x00,0x00,0x05]

flat_load_dwordx3 v[5:7], v[3:4]
// NOSI: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU
// CI: flat_load_dwordx3 v[5:7], v[3:4] ; encoding: [0x00,0x00,0x3c,0xdc,0x03,0x00,0x00,0x05]
// VI: flat_load_dwordx3 v[5:7], v[3:4] ; encoding: [0x00,0x00,0x58,0xdc,0x03,0x00,0x00,0x05]

flat_store_byte v[3:4], v1
// NOSI: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU
// CIVI: flat_store_byte v[3:4], v1 ; encoding: [0x00,0x00,0x60,0xdc,0x03,0x01,0x00,0x00]

flat_store_short v[3:4], v1
// NOSI: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU
// CIVI: flat_store_short v[3:4], v1 ; encoding: [0x00,0x00,0x68,0xdc,0x03,0x01,0x00,0x00]

flat_store_dword v[3:4], v1
// NOSI: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU
// CIVI: flat_store_dword v[3:4], v1 ; encoding: [0x00,0x00,0x70,0xdc,0x03,0x01,0x00,0x00]

flat_store_dwordx2 v[3:4], v[1:2]
// NOSI: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU
// CIVI: flat_store_dwordx2 v[3:4], v[1:2] ; encoding: [0x00,0x00,0x74,0xdc,0x03,0x01,0x00,0x00]

flat_store_dwordx4 v[3:4], v[5:8]
// NOSI: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU
// CI: flat_store_dwordx4 v[3:4], v[5:8] ; encoding: [0x00,0x00,0x78,0xdc,0x03,0x05,0x00,0x00]
// VI: flat_store_dwordx4 v[3:4], v[5:8] ; encoding: [0x00,0x00,0x7c,0xdc,0x03,0x05,0x00,0x00]

flat_store_dwordx3 v[3:4], v[5:7]
// NOSI: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU
// CI: flat_store_dwordx3 v[3:4], v[5:7] ; encoding: [0x00,0x00,0x7c,0xdc,0x03,0x05,0x00,0x00]
// VI: flat_store_dwordx3 v[3:4], v[5:7] ; encoding: [0x00,0x00,0x78,0xdc,0x03,0x05,0x00,0x00]

flat_atomic_swap v[3:4], v5
// NOSI: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU
// CI: flat_atomic_swap v[3:4], v5 ; encoding: [0x00,0x00,0xc0,0xdc,0x03,0x05,0x00,0x00]
// VI: flat_atomic_swap v[3:4], v5 ; encoding: [0x00,0x00,0x00,0xdd,0x03,0x05,0x00,0x00]

flat_atomic_swap v1, v[3:4], v5 glc
// NOSI: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU
// CI: flat_atomic_swap v1, v[3:4], v5 glc ; encoding: [0x00,0x00,0xc1,0xdc,0x03,0x05,0x00,0x01]
// VI: flat_atomic_swap v1, v[3:4], v5 glc ; encoding: [0x00,0x00,0x01,0xdd,0x03,0x05,0x00,0x01]

flat_atomic_cmpswap v[3:4], v[5:6]
// NOSI: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU
// CI: flat_atomic_cmpswap v[3:4], v[5:6] ; encoding: [0x00,0x00,0xc4,0xdc,0x03,0x05,0x00,0x00]
// VI: flat_atomic_cmpswap v[3:4], v[5:6] ; encoding: [0x00,0x00,0x04,0xdd,0x03,0x05,0x00,0x00]

flat_atomic_cmpswap v1, v[3:4], v[5:6] glc
// NOSI: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU
// CI: flat_atomic_cmpswap v1, v[3:4], v[5:6] glc ; encoding: [0x00,0x00,0xc5,0xdc,0x03,0x05,0x00,0x01]
// VI: flat_atomic_cmpswap v1, v[3:4], v[5:6] glc ; encoding: [0x00,0x00,0x05,0xdd,0x03,0x05,0x00,0x01]

flat_atomic_add v[3:4], v5
// NOSI: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU
// CI: flat_atomic_add v[3:4], v5 ; encoding: [0x00,0x00,0xc8,0xdc,0x03,0x05,0x00,0x00]
// VI: flat_atomic_add v[3:4], v5 ; encoding: [0x00,0x00,0x08,0xdd,0x03,0x05,0x00,0x00]

flat_atomic_add v1, v[3:4], v5 glc
// NOSI: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU
// CI: flat_atomic_add v1, v[3:4], v5 glc ; encoding: [0x00,0x00,0xc9,0xdc,0x03,0x05,0x00,0x01]
// VI: flat_atomic_add v1, v[3:4], v5 glc ; encoding: [0x00,0x00,0x09,0xdd,0x03,0x05,0x00,0x01]

flat_atomic_sub v[3:4], v5
// NOSI: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU
// CI: flat_atomic_sub v[3:4], v5 ; encoding: [0x00,0x00,0xcc,0xdc,0x03,0x05,0x00,0x00]
// VI: flat_atomic_sub v[3:4], v5 ; encoding: [0x00,0x00,0x0c,0xdd,0x03,0x05,0x00,0x00]

flat_atomic_sub v1, v[3:4], v5 glc
// NOSI: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU
// CI: flat_atomic_sub v1, v[3:4], v5 glc ; encoding: [0x00,0x00,0xcd,0xdc,0x03,0x05,0x00,0x01]
// VI: flat_atomic_sub v1, v[3:4], v5 glc ; encoding: [0x00,0x00,0x0d,0xdd,0x03,0x05,0x00,0x01]

flat_atomic_smin v[3:4], v5
// NOSI: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU
// CI: flat_atomic_smin v[3:4], v5 ; encoding: [0x00,0x00,0xd4,0xdc,0x03,0x05,0x00,0x00]
// VI: flat_atomic_smin v[3:4], v5 ; encoding: [0x00,0x00,0x10,0xdd,0x03,0x05,0x00,0x00]

flat_atomic_smin v1, v[3:4], v5 glc
// NOSI: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU
// CI: flat_atomic_smin v1, v[3:4], v5 glc ; encoding: [0x00,0x00,0xd5,0xdc,0x03,0x05,0x00,0x01]
// VI: flat_atomic_smin v1, v[3:4], v5 glc ; encoding: [0x00,0x00,0x11,0xdd,0x03,0x05,0x00,0x01]

flat_atomic_umin v[3:4], v5
// NOSI: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU
// CI: flat_atomic_umin v[3:4], v5 ; encoding: [0x00,0x00,0xd8,0xdc,0x03,0x05,0x00,0x00]
// VI: flat_atomic_umin v[3:4], v5 ; encoding: [0x00,0x00,0x14,0xdd,0x03,0x05,0x00,0x00]

flat_atomic_umin v1, v[3:4], v5 glc
// NOSI: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU
// CI: flat_atomic_umin v1, v[3:4], v5 glc ; encoding: [0x00,0x00,0xd9,0xdc,0x03,0x05,0x00,0x01]
// VI: flat_atomic_umin v1, v[3:4], v5 glc ; encoding: [0x00,0x00,0x15,0xdd,0x03,0x05,0x00,0x01]

flat_atomic_smax v[3:4], v5,
// NOSI: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU
// CI: flat_atomic_smax v[3:4], v5 ; encoding: [0x00,0x00,0xdc,0xdc,0x03,0x05,0x00,0x00]
// VI: flat_atomic_smax v[3:4], v5 ; encoding: [0x00,0x00,0x18,0xdd,0x03,0x05,0x00,0x00]

flat_atomic_smax v1, v[3:4], v5 glc
// NOSI: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU
// CI: flat_atomic_smax v1, v[3:4], v5 glc ; encoding: [0x00,0x00,0xdd,0xdc,0x03,0x05,0x00,0x01]
// VI: flat_atomic_smax v1, v[3:4], v5 glc ; encoding: [0x00,0x00,0x19,0xdd,0x03,0x05,0x00,0x01]

flat_atomic_umax v[3:4], v5
// NOSI: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU
// CI: flat_atomic_umax v[3:4], v5 ; encoding: [0x00,0x00,0xe0,0xdc,0x03,0x05,0x00,0x00]
// VI: flat_atomic_umax v[3:4], v5 ; encoding: [0x00,0x00,0x1c,0xdd,0x03,0x05,0x00,0x00]

flat_atomic_umax v1, v[3:4], v5 glc
// NOSI: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU
// CI: flat_atomic_umax v1, v[3:4], v5 glc ; encoding: [0x00,0x00,0xe1,0xdc,0x03,0x05,0x00,0x01]
// VI: flat_atomic_umax v1, v[3:4], v5 glc ; encoding: [0x00,0x00,0x1d,0xdd,0x03,0x05,0x00,0x01]

flat_atomic_and v[3:4], v5
// NOSI: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU
// CI: flat_atomic_and v[3:4], v5 ; encoding: [0x00,0x00,0xe4,0xdc,0x03,0x05,0x00,0x00]
// VI: flat_atomic_and v[3:4], v5 ; encoding: [0x00,0x00,0x20,0xdd,0x03,0x05,0x00,0x00]

flat_atomic_and v1, v[3:4], v5 glc
// NOSI: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU
// CI: flat_atomic_and v1, v[3:4], v5 glc ; encoding: [0x00,0x00,0xe5,0xdc,0x03,0x05,0x00,0x01]
// VI: flat_atomic_and v1, v[3:4], v5 glc ; encoding: [0x00,0x00,0x21,0xdd,0x03,0x05,0x00,0x01]

flat_atomic_or v[3:4], v5
// NOSI: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU
// CI: flat_atomic_or v[3:4], v5 ; encoding: [0x00,0x00,0xe8,0xdc,0x03,0x05,0x00,0x00]
// VI: flat_atomic_or v[3:4], v5 ; encoding: [0x00,0x00,0x24,0xdd,0x03,0x05,0x00,0x00]

flat_atomic_or v1, v[3:4], v5 glc
// NOSI: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU
// CI: flat_atomic_or v1, v[3:4], v5 glc ; encoding: [0x00,0x00,0xe9,0xdc,0x03,0x05,0x00,0x01]
// VI: flat_atomic_or v1, v[3:4], v5 glc ; encoding: [0x00,0x00,0x25,0xdd,0x03,0x05,0x00,0x01]

flat_atomic_xor v[3:4], v5
// NOSI: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU
// CI: flat_atomic_xor v[3:4], v5 ; encoding: [0x00,0x00,0xec,0xdc,0x03,0x05,0x00,0x00]
// VI: flat_atomic_xor v[3:4], v5 ; encoding: [0x00,0x00,0x28,0xdd,0x03,0x05,0x00,0x00]

flat_atomic_xor v1, v[3:4], v5 glc
// NOSI: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU
// CI: flat_atomic_xor v1, v[3:4], v5 glc ; encoding: [0x00,0x00,0xed,0xdc,0x03,0x05,0x00,0x01]
// VI: flat_atomic_xor v1, v[3:4], v5 glc ; encoding: [0x00,0x00,0x29,0xdd,0x03,0x05,0x00,0x01]

flat_atomic_inc v[3:4], v5
// NOSI: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU
// CI: flat_atomic_inc v[3:4], v5 ; encoding: [0x00,0x00,0xf0,0xdc,0x03,0x05,0x00,0x00]
// VI: flat_atomic_inc v[3:4], v5 ; encoding: [0x00,0x00,0x2c,0xdd,0x03,0x05,0x00,0x00]

flat_atomic_inc v1, v[3:4], v5 glc
// NOSI: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU
// CI: flat_atomic_inc v1, v[3:4], v5 glc ; encoding: [0x00,0x00,0xf1,0xdc,0x03,0x05,0x00,0x01]
// VI: flat_atomic_inc v1, v[3:4], v5 glc ; encoding: [0x00,0x00,0x2d,0xdd,0x03,0x05,0x00,0x01]

flat_atomic_dec v[3:4], v5
// NOSI: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU
// CI: flat_atomic_dec v[3:4], v5 ; encoding: [0x00,0x00,0xf4,0xdc,0x03,0x05,0x00,0x00]
// VI: flat_atomic_dec v[3:4], v5 ; encoding: [0x00,0x00,0x30,0xdd,0x03,0x05,0x00,0x00]

flat_atomic_dec v1, v[3:4], v5 glc
// NOSI: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU
// CI: flat_atomic_dec v1, v[3:4], v5 glc ; encoding: [0x00,0x00,0xf5,0xdc,0x03,0x05,0x00,0x01]
// VI: flat_atomic_dec v1, v[3:4], v5 glc ; encoding: [0x00,0x00,0x31,0xdd,0x03,0x05,0x00,0x01]

flat_atomic_fcmpswap v[3:4], v[5:6]
// NOSI: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU
// CI: flat_atomic_fcmpswap v[3:4], v[5:6] ; encoding: [0x00,0x00,0xf8,0xdc,0x03,0x05,0x00,0x00]
// NOVI: :[[@LINE-3]]:{{[0-9]+}}: error: instruction not supported on this GPU

flat_atomic_fcmpswap v1, v[3:4], v[5:6] glc
// NOSI: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU
// CI: flat_atomic_fcmpswap v1, v[3:4], v[5:6] glc ; encoding: [0x00,0x00,0xf9,0xdc,0x03,0x05,0x00,0x01]
// NOVI: :[[@LINE-3]]:{{[0-9]+}}: error: instruction not supported on this GPU

flat_atomic_swap_x2 v[3:4], v[5:6]
// NOSI: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU
// CI: flat_atomic_swap_x2 v[3:4], v[5:6] ; encoding: [0x00,0x00,0x40,0xdd,0x03,0x05,0x00,0x00]
// VI: flat_atomic_swap_x2 v[3:4], v[5:6] ; encoding: [0x00,0x00,0x80,0xdd,0x03,0x05,0x00,0x00]

flat_atomic_swap_x2 v[1:2], v[3:4], v[5:6] glc
// NOSI: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU
// CI: flat_atomic_swap_x2 v[1:2], v[3:4], v[5:6] glc ; encoding: [0x00,0x00,0x41,0xdd,0x03,0x05,0x00,0x01]
// VI: flat_atomic_swap_x2 v[1:2], v[3:4], v[5:6] glc ; encoding: [0x00,0x00,0x81,0xdd,0x03,0x05,0x00,0x01]

flat_atomic_cmpswap_x2 v[3:4], v[5:8]
// NOSI: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU
// CI: flat_atomic_cmpswap_x2 v[3:4], v[5:8] ; encoding: [0x00,0x00,0x44,0xdd,0x03,0x05,0x00,0x00]
// VI: flat_atomic_cmpswap_x2 v[3:4], v[5:8] ; encoding: [0x00,0x00,0x84,0xdd,0x03,0x05,0x00,0x00]

flat_atomic_cmpswap_x2 v[1:2], v[3:4], v[5:8] glc
// NOSI: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU
// CI: flat_atomic_cmpswap_x2 v[1:2], v[3:4], v[5:8] glc ; encoding: [0x00,0x00,0x45,0xdd,0x03,0x05,0x00,0x01]
// VI: flat_atomic_cmpswap_x2 v[1:2], v[3:4], v[5:8] glc ; encoding: [0x00,0x00,0x85,0xdd,0x03,0x05,0x00,0x01]

flat_atomic_add_x2 v[3:4], v[5:6]
// NOSI: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU
// CI: flat_atomic_add_x2 v[3:4], v[5:6] ; encoding: [0x00,0x00,0x48,0xdd,0x03,0x05,0x00,0x00]
// VI: flat_atomic_add_x2 v[3:4], v[5:6] ; encoding: [0x00,0x00,0x88,0xdd,0x03,0x05,0x00,0x00]

flat_atomic_add_x2 v[1:2], v[3:4], v[5:6] glc
// NOSI: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU
// CI: flat_atomic_add_x2 v[1:2], v[3:4], v[5:6] glc ; encoding: [0x00,0x00,0x49,0xdd,0x03,0x05,0x00,0x01]
// VI: flat_atomic_add_x2 v[1:2], v[3:4], v[5:6] glc ; encoding: [0x00,0x00,0x89,0xdd,0x03,0x05,0x00,0x01]

flat_atomic_sub_x2 v[3:4], v[5:6]
// NOSI: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU
// CI: flat_atomic_sub_x2 v[3:4], v[5:6] ; encoding: [0x00,0x00,0x4c,0xdd,0x03,0x05,0x00,0x00]
// VI: flat_atomic_sub_x2 v[3:4], v[5:6] ; encoding: [0x00,0x00,0x8c,0xdd,0x03,0x05,0x00,0x00]

flat_atomic_sub_x2 v[1:2], v[3:4], v[5:6] glc
// NOSI: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU
// CI: flat_atomic_sub_x2 v[1:2], v[3:4], v[5:6] glc ; encoding: [0x00,0x00,0x4d,0xdd,0x03,0x05,0x00,0x01]
// VI: flat_atomic_sub_x2 v[1:2], v[3:4], v[5:6] glc ; encoding: [0x00,0x00,0x8d,0xdd,0x03,0x05,0x00,0x01]

flat_atomic_smin_x2 v[3:4], v[5:6]
// NOSI: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU
// CI: flat_atomic_smin_x2 v[3:4], v[5:6] ; encoding: [0x00,0x00,0x54,0xdd,0x03,0x05,0x00,0x00]
// VI: flat_atomic_smin_x2 v[3:4], v[5:6] ; encoding: [0x00,0x00,0x90,0xdd,0x03,0x05,0x00,0x00]

flat_atomic_smin_x2 v[1:2], v[3:4], v[5:6] glc
// NOSI: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU
// CI: flat_atomic_smin_x2 v[1:2], v[3:4], v[5:6] glc ; encoding: [0x00,0x00,0x55,0xdd,0x03,0x05,0x00,0x01]
// VI: flat_atomic_smin_x2 v[1:2], v[3:4], v[5:6] glc ; encoding: [0x00,0x00,0x91,0xdd,0x03,0x05,0x00,0x01]

flat_atomic_umin_x2 v[3:4], v[5:6]
// NOSI: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU
// CI: flat_atomic_umin_x2 v[3:4], v[5:6] ; encoding: [0x00,0x00,0x58,0xdd,0x03,0x05,0x00,0x00]
// VI: flat_atomic_umin_x2 v[3:4], v[5:6] ; encoding: [0x00,0x00,0x94,0xdd,0x03,0x05,0x00,0x00]

flat_atomic_umin_x2 v[1:2], v[3:4], v[5:6] glc
// NOSI: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU
// CI: flat_atomic_umin_x2 v[1:2], v[3:4], v[5:6] glc ; encoding: [0x00,0x00,0x59,0xdd,0x03,0x05,0x00,0x01]
// VI: flat_atomic_umin_x2 v[1:2], v[3:4], v[5:6] glc ; encoding: [0x00,0x00,0x95,0xdd,0x03,0x05,0x00,0x01]

flat_atomic_smax_x2 v[3:4], v[5:6]
// NOSI: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU
// CI: flat_atomic_smax_x2 v[3:4], v[5:6] ; encoding: [0x00,0x00,0x5c,0xdd,0x03,0x05,0x00,0x00]
// VI: flat_atomic_smax_x2 v[3:4], v[5:6] ; encoding: [0x00,0x00,0x98,0xdd,0x03,0x05,0x00,0x00]

flat_atomic_smax_x2 v[1:2], v[3:4], v[5:6] glc
// NOSI: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU
// CI: flat_atomic_smax_x2 v[1:2], v[3:4], v[5:6] glc ; encoding: [0x00,0x00,0x5d,0xdd,0x03,0x05,0x00,0x01]
// VI: flat_atomic_smax_x2 v[1:2], v[3:4], v[5:6] glc ; encoding: [0x00,0x00,0x99,0xdd,0x03,0x05,0x00,0x01]

flat_atomic_umax_x2 v[3:4], v[5:6]
// NOSI: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU
// CI: flat_atomic_umax_x2 v[3:4], v[5:6] ; encoding: [0x00,0x00,0x60,0xdd,0x03,0x05,0x00,0x00]
// VI: flat_atomic_umax_x2 v[3:4], v[5:6] ; encoding: [0x00,0x00,0x9c,0xdd,0x03,0x05,0x00,0x00]

flat_atomic_umax_x2 v[1:2], v[3:4], v[5:6] glc
// NOSI: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU
// CI: flat_atomic_umax_x2 v[1:2], v[3:4], v[5:6] glc ; encoding: [0x00,0x00,0x61,0xdd,0x03,0x05,0x00,0x01]
// VI: flat_atomic_umax_x2 v[1:2], v[3:4], v[5:6] glc ; encoding: [0x00,0x00,0x9d,0xdd,0x03,0x05,0x00,0x01]

flat_atomic_and_x2 v[3:4], v[5:6]
// NOSI: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU
// CI: flat_atomic_and_x2 v[3:4], v[5:6] ; encoding: [0x00,0x00,0x64,0xdd,0x03,0x05,0x00,0x00]
// VI: flat_atomic_and_x2 v[3:4], v[5:6] ; encoding: [0x00,0x00,0xa0,0xdd,0x03,0x05,0x00,0x00]

flat_atomic_and_x2 v[1:2], v[3:4], v[5:6] glc
// NOSI: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU
// CI: flat_atomic_and_x2 v[1:2], v[3:4], v[5:6] glc ; encoding: [0x00,0x00,0x65,0xdd,0x03,0x05,0x00,0x01]
// VI: flat_atomic_and_x2 v[1:2], v[3:4], v[5:6] glc ; encoding: [0x00,0x00,0xa1,0xdd,0x03,0x05,0x00,0x01]

flat_atomic_or_x2 v[3:4], v[5:6]
// NOSI: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU
// CI: flat_atomic_or_x2 v[3:4], v[5:6] ; encoding: [0x00,0x00,0x68,0xdd,0x03,0x05,0x00,0x00]
// VI: flat_atomic_or_x2 v[3:4], v[5:6] ; encoding: [0x00,0x00,0xa4,0xdd,0x03,0x05,0x00,0x00]

flat_atomic_or_x2 v[1:2], v[3:4], v[5:6] glc
// NOSI: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU
// CI: flat_atomic_or_x2 v[1:2], v[3:4], v[5:6] glc ; encoding: [0x00,0x00,0x69,0xdd,0x03,0x05,0x00,0x01]
// VI: flat_atomic_or_x2 v[1:2], v[3:4], v[5:6] glc ; encoding: [0x00,0x00,0xa5,0xdd,0x03,0x05,0x00,0x01]

flat_atomic_xor_x2 v[3:4], v[5:6]
// NOSI: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU
// CI: flat_atomic_xor_x2 v[3:4], v[5:6] ; encoding: [0x00,0x00,0x6c,0xdd,0x03,0x05,0x00,0x00]
// VI: flat_atomic_xor_x2 v[3:4], v[5:6] ; encoding: [0x00,0x00,0xa8,0xdd,0x03,0x05,0x00,0x00]

flat_atomic_xor_x2 v[1:2], v[3:4], v[5:6] glc
// NOSI: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU
// CI: flat_atomic_xor_x2 v[1:2], v[3:4], v[5:6] glc ; encoding: [0x00,0x00,0x6d,0xdd,0x03,0x05,0x00,0x01]
// VI: flat_atomic_xor_x2 v[1:2], v[3:4], v[5:6] glc ; encoding: [0x00,0x00,0xa9,0xdd,0x03,0x05,0x00,0x01]

flat_atomic_inc_x2 v[3:4], v[5:6]
// NOSI: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU
// CI: flat_atomic_inc_x2 v[3:4], v[5:6] ; encoding: [0x00,0x00,0x70,0xdd,0x03,0x05,0x00,0x00]
// VI: flat_atomic_inc_x2 v[3:4], v[5:6] ; encoding: [0x00,0x00,0xac,0xdd,0x03,0x05,0x00,0x00]

flat_atomic_inc_x2 v[1:2], v[3:4], v[5:6] glc
// NOSI: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU
// CI: flat_atomic_inc_x2 v[1:2], v[3:4], v[5:6] glc ; encoding: [0x00,0x00,0x71,0xdd,0x03,0x05,0x00,0x01]
// VI: flat_atomic_inc_x2 v[1:2], v[3:4], v[5:6] glc ; encoding: [0x00,0x00,0xad,0xdd,0x03,0x05,0x00,0x01]

flat_atomic_dec_x2 v[3:4], v[5:6]
// NOSI: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU
// CI: flat_atomic_dec_x2 v[3:4], v[5:6] ; encoding: [0x00,0x00,0x74,0xdd,0x03,0x05,0x00,0x00]
// VI: flat_atomic_dec_x2 v[3:4], v[5:6] ; encoding: [0x00,0x00,0xb0,0xdd,0x03,0x05,0x00,0x00]

flat_atomic_dec_x2 v[1:2], v[3:4], v[5:6] glc
// NOSI: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU
// CI: flat_atomic_dec_x2 v[1:2], v[3:4], v[5:6] glc ; encoding: [0x00,0x00,0x75,0xdd,0x03,0x05,0x00,0x01]
// VI: flat_atomic_dec_x2 v[1:2], v[3:4], v[5:6] glc ; encoding: [0x00,0x00,0xb1,0xdd,0x03,0x05,0x00,0x01]

flat_atomic_fcmpswap_x2 v[3:4], v[5:8]
// NOSI: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU
// CI: flat_atomic_fcmpswap_x2 v[3:4], v[5:8] ; encoding: [0x00,0x00,0x78,0xdd,0x03,0x05,0x00,0x00]
// NOVI: :[[@LINE-3]]:{{[0-9]+}}: error: instruction not supported on this GPU

flat_atomic_fcmpswap_x2 v[1:2], v[3:4], v[5:8] glc
// NOSI: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU
// CI: flat_atomic_fcmpswap_x2 v[1:2], v[3:4], v[5:8] glc ; encoding: [0x00,0x00,0x79,0xdd,0x03,0x05,0x00,0x01]
// NOVI: :[[@LINE-3]]:{{[0-9]+}}: error: instruction not supported on this GPU

flat_atomic_fmin_x2 v[3:4], v[5:6]
// NOSI: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU
// CI: flat_atomic_fmin_x2 v[3:4], v[5:6] ; encoding: [0x00,0x00,0x7c,0xdd,0x03,0x05,0x00,0x00]
// NOVI: :[[@LINE-3]]:{{[0-9]+}}: error: instruction not supported on this GPU

flat_atomic_fmin_x2 v[1:2], v[3:4], v[5:6] glc
// NOSI: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU
// CI: flat_atomic_fmin_x2 v[1:2], v[3:4], v[5:6] glc ; encoding: [0x00,0x00,0x7d,0xdd,0x03,0x05,0x00,0x01]
// NOVI: :[[@LINE-3]]:{{[0-9]+}}: error: instruction not supported on this GPU

flat_atomic_fmax_x2 v[3:4], v[5:6]
// NOSI: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU
// CI: flat_atomic_fmax_x2 v[3:4], v[5:6] ; encoding: [0x00,0x00,0x80,0xdd,0x03,0x05,0x00,0x00]
// NOVI: :[[@LINE-3]]:{{[0-9]+}}: error: instruction not supported on this GPU

flat_atomic_fmax_x2 v[1:2], v[3:4], v[5:6] glc
// NOSI: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU
// CI: flat_atomic_fmax_x2 v[1:2], v[3:4], v[5:6] glc ; encoding: [0x00,0x00,0x81,0xdd,0x03,0x05,0x00,0x01]
// NOVI: :[[@LINE-3]]:{{[0-9]+}}: error: instruction not supported on this GPU
