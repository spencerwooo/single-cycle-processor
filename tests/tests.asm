# ALU operation tests
addiu $1, $0, 0x0050
addiu $2, $0, 0x0090
subu $3, $2, $1
add $4, $1, $2

# LUI
LUI $5, 0x0153
LUI $6, 0x0153

# SW to dm
SW $3, 0($0)
SW $4, 4($0)

# JUMP
BEQ $5, $6, target
LUI $7, 0x0007
target: LUI $8, 0x0008

# LW from dm
LW $9, 4($0)
