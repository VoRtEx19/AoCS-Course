#===============================================================================
# Macro file for stack work
#===============================================================================

#-------------------------------------------------------------------------------
# Macro for saving a register to stack
# Argument %reg: register to be saved on stack
.macro push(%reg)
	addi	sp, sp, -4
	sw	%reg, (sp)
.end_macro

#-------------------------------------------------------------------------------
# Macro for loading the register from stack
# Argument %reg: register to be loaded from stack
.macro pop(%reg)
	lw	%reg, (sp)
	addi	sp, sp, 4
.end_macro