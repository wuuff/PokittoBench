# add files to be compiled

OBJECTS += main.o

###############################################################################
# Boiler-plate

# cross-platform directory manipulation
ifeq ($(shell echo $$OS),$$OS)
    MAKEDIR = if not exist "$(1)" mkdir "$(1)"
    RM = rmdir /S /Q "$(1)"
else
    MAKEDIR = '$(SHELL)' -c "mkdir -p \"$(1)\""
    RM = '$(SHELL)' -c "rm -rf \"$(1)\""
endif

OBJDIR := BUILD
# Move to the build directory
ifeq (,$(filter $(OBJDIR),$(notdir $(CURDIR))))
.SUFFIXES:
mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
MAKETARGET = '$(MAKE)' --no-print-directory -C $(OBJDIR) -f '$(mkfile_path)' \
		'SRCDIR=$(CURDIR)' $(MAKECMDGOALS)
.PHONY: $(OBJDIR) clean
pokitto:
	+@$(call MAKEDIR,$(OBJDIR))
	+@$(MAKETARGET)
$(OBJDIR): pokitto
Makefile : ;
% :: $(OBJDIR) ; :
clean :
	$(call RM,$(OBJDIR))

else

# trick rules into thinking we are in the root, when we are in the bulid dir
VPATH = ..

# Boiler-plate
###############################################################################
# Project settings

PROJECT := game

# Project settings
###############################################################################
# Objects and Paths

OBJECTS += PokittoLib/POKITTO_CORE/FONTS/TIC806x6.o
OBJECTS += PokittoLib/POKITTO_CORE/FONTS/ZXSpec.o
OBJECTS += PokittoLib/POKITTO_CORE/FONTS/adventurer12x16.o
OBJECTS += PokittoLib/POKITTO_CORE/FONTS/donut7x10.o
OBJECTS += PokittoLib/POKITTO_CORE/FONTS/dragon6x8.o
OBJECTS += PokittoLib/POKITTO_CORE/FONTS/font3x3.o
OBJECTS += PokittoLib/POKITTO_CORE/FONTS/font3x5.o
OBJECTS += PokittoLib/POKITTO_CORE/FONTS/font5x7.o
OBJECTS += PokittoLib/POKITTO_CORE/FONTS/fontC64.o
OBJECTS += PokittoLib/POKITTO_CORE/FONTS/fontC64UIGfx.o
OBJECTS += PokittoLib/POKITTO_CORE/FONTS/fontMonkey.o
OBJECTS += PokittoLib/POKITTO_CORE/FONTS/karateka8x11.o
OBJECTS += PokittoLib/POKITTO_CORE/FONTS/koubit7x7.o
OBJECTS += PokittoLib/POKITTO_CORE/FONTS/mini4x6.o
OBJECTS += PokittoLib/POKITTO_CORE/FONTS/runes6x8.o
OBJECTS += PokittoLib/POKITTO_CORE/FONTS/tight4x7.o
OBJECTS += PokittoLib/POKITTO_CORE/FONTS/tiny5x7.o
OBJECTS += PokittoLib/POKITTO_CORE/PALETTES/palAction.o
OBJECTS += PokittoLib/POKITTO_CORE/PALETTES/palCGA.o
OBJECTS += PokittoLib/POKITTO_CORE/PALETTES/palDB16.o
OBJECTS += PokittoLib/POKITTO_CORE/PALETTES/palDefault.o
OBJECTS += PokittoLib/POKITTO_CORE/PALETTES/palGameboy.o
OBJECTS += PokittoLib/POKITTO_CORE/PALETTES/palMagma.o
OBJECTS += PokittoLib/POKITTO_CORE/PALETTES/palMono.o
OBJECTS += PokittoLib/POKITTO_CORE/PALETTES/palPico.o
OBJECTS += PokittoLib/POKITTO_CORE/PALETTES/palRainbow.o
OBJECTS += PokittoLib/POKITTO_CORE/PALETTES/palZXSpec.o
OBJECTS += PokittoLib/POKITTO_CORE/PokittoBacklight.o
OBJECTS += PokittoLib/POKITTO_CORE/PokittoBattery.o
OBJECTS += PokittoLib/POKITTO_CORE/PokittoButtons.o
OBJECTS += PokittoLib/POKITTO_CORE/PokittoConsole.o
OBJECTS += PokittoLib/POKITTO_CORE/PokittoCookie.o
OBJECTS += PokittoLib/POKITTO_CORE/PokittoCore.o
OBJECTS += PokittoLib/POKITTO_CORE/PokittoDisk.o
OBJECTS += PokittoLib/POKITTO_CORE/PokittoDisplay.o
OBJECTS += PokittoLib/POKITTO_CORE/PokittoFramebuffer.o
OBJECTS += PokittoLib/POKITTO_CORE/PokittoItoa.o
OBJECTS += PokittoLib/POKITTO_CORE/PokittoLogos.o
OBJECTS += PokittoLib/POKITTO_CORE/PokittoPalette.o
OBJECTS += PokittoLib/POKITTO_CORE/PokittoPrintf.o
OBJECTS += PokittoLib/POKITTO_CORE/PokittoSound.o
OBJECTS += PokittoLib/POKITTO_HW/HWButtons.o
OBJECTS += PokittoLib/POKITTO_HW/HWLCD.o
OBJECTS += PokittoLib/POKITTO_HW/HWSound.o
OBJECTS += PokittoLib/POKITTO_HW/PokittoClock.o
OBJECTS += PokittoLib/POKITTO_HW/PokittoHW.o
OBJECTS += PokittoLib/POKITTO_HW/Pokitto_extport.o
OBJECTS += PokittoLib/POKITTO_HW/SoftwareI2C.o
OBJECTS += PokittoLib/POKITTO_HW/clock_11u6x.o
OBJECTS += PokittoLib/POKITTO_HW/dma_11u6x.o
OBJECTS += PokittoLib/POKITTO_HW/iap.o
OBJECTS += PokittoLib/POKITTO_HW/timer_11u6x.o
#OBJECTS += PokittoLib/POKITTO_LIBS/ImageFormat/BmpImage.o
OBJECTS += PokittoLib/POKITTO_LIBS/Synth/Synth.o
OBJECTS += PokittoLib/POKITTO_LIBS/Synth/Synth_envfuncs.o
OBJECTS += PokittoLib/POKITTO_LIBS/Synth/Synth_helpers.o
OBJECTS += PokittoLib/POKITTO_LIBS/Synth/Synth_mixfuncs.o
OBJECTS += PokittoLib/POKITTO_LIBS/Synth/Synth_oscfuncs.o
OBJECTS += PokittoLib/POKITTO_LIBS/Synth/Synth_songfuncs.o
OBJECTS += PokittoLib/POKITTO_LIBS/Synth/Synth_wavefuncs.o
OBJECTS += PokittoLib/POKITTO_LIBS/SDFileSystem/SDFileSystem.o
OBJECTS += PokittoLib/POKITTO_LIBS/SDFileSystem/CRC16.o
OBJECTS += PokittoLib/POKITTO_LIBS/SDFileSystem/CRC7.o
OBJECTS += PokittoLib/POKITTO_LIBS/SDFileSystem/FATFileSystem/FATFileSystem.o
OBJECTS += PokittoLib/POKITTO_LIBS/SDFileSystem/FATFileSystem/FATFileHandle.o
OBJECTS += PokittoLib/POKITTO_LIBS/SDFileSystem/FATFileSystem/FATDirHandle.o
OBJECTS += PokittoLib/POKITTO_LIBS/SDFileSystem/FATFileSystem/ChaN/ccsbcs.o
OBJECTS += PokittoLib/POKITTO_LIBS/SDFileSystem/FATFileSystem/ChaN/diskio.o
OBJECTS += PokittoLib/POKITTO_LIBS/SDFileSystem/FATFileSystem/ChaN/ff.o
OBJECTS += PokittoLib/POKITTO_XTERNALS/Arduino/delay.o
OBJECTS += PokittoLib/libpff/mmc.o
OBJECTS += PokittoLib/libpff/pff.o
OBJECTS += PokittoLib/mbed-pokitto/common/BusIn.o
OBJECTS += PokittoLib/mbed-pokitto/common/BusInOut.o
OBJECTS += PokittoLib/mbed-pokitto/common/BusOut.o
OBJECTS += PokittoLib/mbed-pokitto/common/CAN.o
OBJECTS += PokittoLib/mbed-pokitto/common/CallChain.o
OBJECTS += PokittoLib/mbed-pokitto/common/Ethernet.o
OBJECTS += PokittoLib/mbed-pokitto/common/FileBase.o
OBJECTS += PokittoLib/mbed-pokitto/common/FileLike.o
OBJECTS += PokittoLib/mbed-pokitto/common/FilePath.o
OBJECTS += PokittoLib/mbed-pokitto/common/FileSystemLike.o
OBJECTS += PokittoLib/mbed-pokitto/common/I2C.o
OBJECTS += PokittoLib/mbed-pokitto/common/I2CSlave.o
OBJECTS += PokittoLib/mbed-pokitto/common/InterruptIn.o
OBJECTS += PokittoLib/mbed-pokitto/common/InterruptManager.o
OBJECTS += PokittoLib/mbed-pokitto/common/LocalFileSystem.o
OBJECTS += PokittoLib/mbed-pokitto/common/RawSerial.o
OBJECTS += PokittoLib/mbed-pokitto/common/SPI.o
OBJECTS += PokittoLib/mbed-pokitto/common/SPISlave.o
OBJECTS += PokittoLib/mbed-pokitto/common/Serial.o
OBJECTS += PokittoLib/mbed-pokitto/common/SerialBase.o
OBJECTS += PokittoLib/mbed-pokitto/common/Stream.o
OBJECTS += PokittoLib/mbed-pokitto/common/Ticker.o
OBJECTS += PokittoLib/mbed-pokitto/common/Timeout.o
OBJECTS += PokittoLib/mbed-pokitto/common/Timer.o
OBJECTS += PokittoLib/mbed-pokitto/common/TimerEvent.o
OBJECTS += PokittoLib/mbed-pokitto/common/assert.o
OBJECTS += PokittoLib/mbed-pokitto/common/board.o
OBJECTS += PokittoLib/mbed-pokitto/common/error.o
OBJECTS += PokittoLib/mbed-pokitto/common/gpio.o
OBJECTS += PokittoLib/mbed-pokitto/common/lp_ticker_api.o
OBJECTS += PokittoLib/mbed-pokitto/common/mbed_interface.o
OBJECTS += PokittoLib/mbed-pokitto/common/pinmap_common.o
OBJECTS += PokittoLib/mbed-pokitto/common/retarget.o
OBJECTS += PokittoLib/mbed-pokitto/common/rtc_time.o
OBJECTS += PokittoLib/mbed-pokitto/common/semihost_api.o
OBJECTS += PokittoLib/mbed-pokitto/common/ticker_api.o
OBJECTS += PokittoLib/mbed-pokitto/common/us_ticker_api.o
OBJECTS += PokittoLib/mbed-pokitto/common/wait_api.o
OBJECTS += PokittoLib/mbed-pokitto/targets/cmsis/TARGET_NXP/TARGET_LPC11U6X/TOOLCHAIN_GCC_ARM/TARGET_LPC11U68/startup_LPC11U68.o
OBJECTS += PokittoLib/mbed-pokitto/targets/cmsis/TARGET_NXP/TARGET_LPC11U6X/cmsis_nvic.o
OBJECTS += PokittoLib/mbed-pokitto/targets/cmsis/TARGET_NXP/TARGET_LPC11U6X/system_LPC11U6x.o
OBJECTS += PokittoLib/mbed-pokitto/targets/hal/TARGET_NXP/TARGET_LPC11U6X/analogin_api.o
OBJECTS += PokittoLib/mbed-pokitto/targets/hal/TARGET_NXP/TARGET_LPC11U6X/gpio_api.o
OBJECTS += PokittoLib/mbed-pokitto/targets/hal/TARGET_NXP/TARGET_LPC11U6X/gpio_irq_api.o
OBJECTS += PokittoLib/mbed-pokitto/targets/hal/TARGET_NXP/TARGET_LPC11U6X/i2c_api.o
OBJECTS += PokittoLib/mbed-pokitto/targets/hal/TARGET_NXP/TARGET_LPC11U6X/pinmap.o
OBJECTS += PokittoLib/mbed-pokitto/targets/hal/TARGET_NXP/TARGET_LPC11U6X/pwmout_api.o
OBJECTS += PokittoLib/mbed-pokitto/targets/hal/TARGET_NXP/TARGET_LPC11U6X/rtc_api.o
OBJECTS += PokittoLib/mbed-pokitto/targets/hal/TARGET_NXP/TARGET_LPC11U6X/serial_api.o
OBJECTS += PokittoLib/mbed-pokitto/targets/hal/TARGET_NXP/TARGET_LPC11U6X/sleep.o
OBJECTS += PokittoLib/mbed-pokitto/targets/hal/TARGET_NXP/TARGET_LPC11U6X/spi_api.o
OBJECTS += PokittoLib/mbed-pokitto/targets/hal/TARGET_NXP/TARGET_LPC11U6X/us_ticker.o

# New asm folder
OBJECTS += PokittoLib/POKITTO_HW/asm/flushLine2X.o
OBJECTS += PokittoLib/POKITTO_HW/asm/flushLine.o
OBJECTS += PokittoLib/POKITTO_HW/asm/mode13c.o
OBJECTS += PokittoLib/POKITTO_HW/asm/mode13.o
OBJECTS += PokittoLib/POKITTO_HW/asm/mode15c.o
OBJECTS += PokittoLib/POKITTO_HW/asm/mode15.o
OBJECTS += PokittoLib/POKITTO_HW/asm/mode1c.o
OBJECTS += PokittoLib/POKITTO_HW/asm/mode1.o
OBJECTS += PokittoLib/POKITTO_HW/asm/mode2c.o
OBJECTS += PokittoLib/POKITTO_HW/asm/mode2.o
OBJECTS += PokittoLib/POKITTO_HW/asm/mode64c.o
OBJECTS += PokittoLib/POKITTO_HW/asm/mode64.o
OBJECTS += PokittoLib/POKITTO_HW/asm/pixelCopyMirror.o
OBJECTS += PokittoLib/POKITTO_HW/asm/pixelCopy.o
OBJECTS += PokittoLib/POKITTO_HW/asm/pixelCopySolid.o
OBJECTS += PokittoLib/POKITTO_HW/asm/pixelExpand.o
OBJECTS += PokittoLib/POKITTO_HW/asm/unlz4.o

#Pokitto LibAudio dependency objects
OBJECTS += PokittoLib/POKITTO_LIBS/File/ChaN/ccsbcs.o
OBJECTS += PokittoLib/POKITTO_LIBS/File/ChaN/diskio.o
OBJECTS += PokittoLib/POKITTO_LIBS/File/ChaN/ff.o

INCLUDE_PATHS += -I../:
INCLUDE_PATHS += -I../.
INCLUDE_PATHS += -I../PokittoLib
INCLUDE_PATHS += -I../PokittoLib/POKITTO_CORE
INCLUDE_PATHS += -I../PokittoLib/POKITTO_CORE/FONTS
INCLUDE_PATHS += -I../PokittoLib/POKITTO_CORE/PALETTES
INCLUDE_PATHS += -I../PokittoLib/POKITTO_HW
INCLUDE_PATHS += -I../PokittoLib/POKITTO_LIBS
INCLUDE_PATHS += -I../PokittoLib/POKITTO_LIBS/ImageFormat
INCLUDE_PATHS += -I../PokittoLib/POKITTO_LIBS/Synth
INCLUDE_PATHS += -I../PokittoLib/POKITTO_LIBS/SDFileSystem
INCLUDE_PATHS += -I../PokittoLib/POKITTO_LIBS/SDFileSystem/FATFileSystem
INCLUDE_PATHS += -I../PokittoLib/POKITTO_LIBS/SDFileSystem/FATFileSystem/ChaN
INCLUDE_PATHS += -I../PokittoLib/POKITTO_XTERNALS
INCLUDE_PATHS += -I../PokittoLib/POKITTO_XTERNALS/Arduino
INCLUDE_PATHS += -I../PokittoLib/libpff
INCLUDE_PATHS += -I../PokittoLib/mbed-pokitto
INCLUDE_PATHS += -I../PokittoLib/mbed-pokitto/api
INCLUDE_PATHS += -I../PokittoLib/mbed-pokitto/common
INCLUDE_PATHS += -I../PokittoLib/mbed-pokitto/hal
INCLUDE_PATHS += -I../PokittoLib/mbed-pokitto/targets
INCLUDE_PATHS += -I../PokittoLib/mbed-pokitto/targets/cmsis
INCLUDE_PATHS += -I../PokittoLib/mbed-pokitto/targets/cmsis/TARGET_NXP
INCLUDE_PATHS += -I../PokittoLib/mbed-pokitto/targets/cmsis/TARGET_NXP/TARGET_LPC11U6X
INCLUDE_PATHS += -I../PokittoLib/mbed-pokitto/targets/cmsis/TARGET_NXP/TARGET_LPC11U6X/TOOLCHAIN_GCC_ARM
INCLUDE_PATHS += -I../PokittoLib/mbed-pokitto/targets/cmsis/TARGET_NXP/TARGET_LPC11U6X/TOOLCHAIN_GCC_ARM/TARGET_LPC11U68
INCLUDE_PATHS += -I../PokittoLib/mbed-pokitto/targets/cmsis/TOOLCHAIN_GCC
INCLUDE_PATHS += -I../PokittoLib/mbed-pokitto/targets/hal
INCLUDE_PATHS += -I../PokittoLib/mbed-pokitto/targets/hal/TARGET_NXP
INCLUDE_PATHS += -I../PokittoLib/mbed-pokitto/targets/hal/TARGET_NXP/TARGET_LPC11U6X

#Pokitto LibAudio include path and dependencies
INCLUDE_PATHS += -I../PokittoLib/POKITTO_LIBS/LibAudio
INCLUDE_PATHS += -I../PokittoLib/POKITTO_LIBS/MemOps
INCLUDE_PATHS += -I../PokittoLib/POKITTO_LIBS/File
INCLUDE_PATHS += -I../PokittoLib/POKITTO_LIBS/LibLog
INCLUDE_PATHS += -I../PokittoLib/POKITTO_LIBS/LibSchedule

LIBRARY_PATHS :=
LIBRARIES :=
LINKER_SCRIPT ?= ../PokittoLib/mbed-pokitto/targets/cmsis/TARGET_NXP/TARGET_LPC11U6X/TOOLCHAIN_GCC_ARM/TARGET_LPC11U68/LPC11U68.ld

# Objects and Paths
###############################################################################
# Tools and Flags

AS      = '../gtc/arm-none-eabi-gcc' '-x' 'assembler-with-cpp' '-c' '-Wall' '-Wextra' '-Wno-unused-parameter' '-Wno-missing-field-initializers' '-fmessage-length=0' '-fno-exceptions' '-fno-builtin' '-ffunction-sections' '-fdata-sections' '-funsigned-char' '-MMD' '-fno-delete-null-pointer-checks' '-fomit-frame-pointer' '-O3' '-g1' '-DMBED_RTOS_SINGLE_THREAD' '-mcpu=cortex-m0plus' '-mthumb'
CC      = '../gtc/arm-none-eabi-gcc' '-std=gnu99' '-c' '-Wall' '-Wextra' '-Wno-unused-parameter' '-Wno-missing-field-initializers' '-fmessage-length=0' '-fno-exceptions' '-fno-builtin' '-ffunction-sections' '-fdata-sections' '-funsigned-char' '-MMD' '-fno-delete-null-pointer-checks' '-fomit-frame-pointer' '-O3' '-g1' '-DMBED_RTOS_SINGLE_THREAD' '-mcpu=cortex-m0plus' '-mthumb'
CPP     = '../gtc/arm-none-eabi-g++' '-std=gnu++98' '-fno-rtti' '-Wvla' '-c' '-Wall' '-Wextra' '-Wno-unused-parameter' '-Wno-missing-field-initializers' '-fmessage-length=0' '-fno-exceptions' '-fno-builtin' '-ffunction-sections' '-fdata-sections' '-funsigned-char' '-MMD' '-fno-delete-null-pointer-checks' '-fomit-frame-pointer' '-O3' '-g1' '-DMBED_RTOS_SINGLE_THREAD' '-mcpu=cortex-m0plus' '-mthumb'
LD      = '../gtc/arm-none-eabi-gcc'
ELF2BIN = '../gtc/arm-none-eabi-objcopy'
PREPROC = '../gtc/arm-none-eabi-cpp' '-E' '-P' '-Wl,--gc-sections' '-Wl,--wrap,main' '-Wl,--wrap,_malloc_r' '-Wl,--wrap,_free_r' '-Wl,--wrap,_realloc_r' '-Wl,--wrap,_memalign_r' '-Wl,--wrap,_calloc_r' '-Wl,--wrap,exit' '-Wl,--wrap,atexit' '-Wl,-n' '--specs=nano.specs' '-mcpu=cortex-m0plus' '-mthumb'

C_FLAGS += -std=gnu99
C_FLAGS += -O3
C_FLAGS += -DTARGET_LPC11U68
C_FLAGS += -D__MBED__=1
C_FLAGS += -DDEVICE_I2CSLAVE=1
C_FLAGS += -DTARGET_LIKE_MBED
C_FLAGS += -DTARGET_NXP
C_FLAGS += -D__MBED_CMSIS_RTOS_CM
C_FLAGS += -DDEVICE_RTC=1
C_FLAGS += -DTOOLCHAIN_object
C_FLAGS += -D__CMSIS_RTOS
C_FLAGS += -DTOOLCHAIN_GCC
C_FLAGS += -DTARGET_CORTEX_M
C_FLAGS += -DTARGET_M0P
C_FLAGS += -DTARGET_UVISOR_UNSUPPORTED
C_FLAGS += -DDEVICE_SERIAL=1
C_FLAGS += -DDEVICE_INTERRUPTIN=1
C_FLAGS += -DTARGET_LPCTarget
C_FLAGS += -DTARGET_CORTEX
C_FLAGS += -DDEVICE_I2C=1
C_FLAGS += -D__CORTEX_M0PLUS
C_FLAGS += -DTARGET_FF_ARDUINO
C_FLAGS += -DTARGET_RELEASE
C_FLAGS += -DMBED_BUILD_TIMESTAMP=1526394586.66
C_FLAGS += -DARM_MATH_CM0PLUS
C_FLAGS += -DTARGET_LPC11U6X
C_FLAGS += -DDEVICE_SLEEP=1
C_FLAGS += -DTOOLCHAIN_GCC_ARM
C_FLAGS += -DDEVICE_SPI=1
C_FLAGS += -DDEVICE_ANALOGIN=1
C_FLAGS += -DDEVICE_PWMOUT=1
C_FLAGS += -DTARGET_LIKE_CORTEX_M0
C_FLAGS += -include
C_FLAGS += mbed_config.h

CXX_FLAGS += -std=gnu++17
CXX_FLAGS += -O3
CXX_FLAGS += -fno-rtti
CXX_FLAGS += -Wvla
CXX_FLAGS += -DTARGET_LPC11U68
CXX_FLAGS += -D__MBED__=1
CXX_FLAGS += -DDEVICE_I2CSLAVE=1
CXX_FLAGS += -DTARGET_LIKE_MBED
CXX_FLAGS += -DTARGET_NXP
CXX_FLAGS += -D__MBED_CMSIS_RTOS_CM
CXX_FLAGS += -DDEVICE_RTC=1
CXX_FLAGS += -DTOOLCHAIN_object
CXX_FLAGS += -D__CMSIS_RTOS
CXX_FLAGS += -DTOOLCHAIN_GCC
CXX_FLAGS += -DTARGET_CORTEX_M
CXX_FLAGS += -DTARGET_M0P
CXX_FLAGS += -DTARGET_UVISOR_UNSUPPORTED
CXX_FLAGS += -DDEVICE_SERIAL=1
CXX_FLAGS += -DDEVICE_INTERRUPTIN=1
CXX_FLAGS += -DTARGET_LPCTarget
CXX_FLAGS += -DTARGET_CORTEX
CXX_FLAGS += -DDEVICE_I2C=1
CXX_FLAGS += -D__CORTEX_M0PLUS
CXX_FLAGS += -DTARGET_FF_ARDUINO
CXX_FLAGS += -DTARGET_RELEASE
CXX_FLAGS += -DMBED_BUILD_TIMESTAMP=1526394586.66
CXX_FLAGS += -DARM_MATH_CM0PLUS
CXX_FLAGS += -DTARGET_LPC11U6X
CXX_FLAGS += -DDEVICE_SLEEP=1
CXX_FLAGS += -DTOOLCHAIN_GCC_ARM
CXX_FLAGS += -DDEVICE_SPI=1
CXX_FLAGS += -DDEVICE_ANALOGIN=1
CXX_FLAGS += -DDEVICE_PWMOUT=1
CXX_FLAGS += -DTARGET_LIKE_CORTEX_M0
CXX_FLAGS += -include
CXX_FLAGS += mbed_config.h

# Overclocking flags
#C_FLAGS += -D_OSCT=2
#CXX_FLAGS += -D_OSCT=2

ASM_FLAGS += -x
ASM_FLAGS += assembler-with-cpp
ASM_FLAGS += -D__CMSIS_RTOS
ASM_FLAGS += -D__MBED_CMSIS_RTOS_CM
ASM_FLAGS += -D__CORTEX_M0PLUS
ASM_FLAGS += -DARM_MATH_CM0PLUS
ASM_FLAGS += -I../.
ASM_FLAGS += -I../PokittoLib
ASM_FLAGS += -I../PokittoLib/POKITTO_CORE
ASM_FLAGS += -I../PokittoLib/POKITTO_CORE/FONTS
ASM_FLAGS += -I../PokittoLib/POKITTO_CORE/PALETTES
ASM_FLAGS += -I../PokittoLib/POKITTO_HW
ASM_FLAGS += -I../PokittoLib/POKITTO_LIBS
ASM_FLAGS += -I../PokittoLib/POKITTO_LIBS/ImageFormat
ASM_FLAGS += -I../PokittoLib/POKITTO_LIBS/Synth
ASM_FLAGS += -I../PokittoLib/POKITTO_XTERNALS
ASM_FLAGS += -I../PokittoLib/POKITTO_XTERNALS/Arduino
ASM_FLAGS += -I../PokittoLib/libpff
ASM_FLAGS += -I../PokittoLib/mbed-pokitto
ASM_FLAGS += -I../PokittoLib/mbed-pokitto/api
ASM_FLAGS += -I../PokittoLib/mbed-pokitto/common
ASM_FLAGS += -I../PokittoLib/mbed-pokitto/hal
ASM_FLAGS += -I../PokittoLib/mbed-pokitto/targets
ASM_FLAGS += -I../PokittoLib/mbed-pokitto/targets/cmsis
ASM_FLAGS += -I../PokittoLib/mbed-pokitto/targets/cmsis/TARGET_NXP
ASM_FLAGS += -I../PokittoLib/mbed-pokitto/targets/cmsis/TARGET_NXP/TARGET_LPC11U6X
ASM_FLAGS += -I../PokittoLib/mbed-pokitto/targets/cmsis/TARGET_NXP/TARGET_LPC11U6X/TOOLCHAIN_GCC_ARM
ASM_FLAGS += -I../PokittoLib/mbed-pokitto/targets/cmsis/TARGET_NXP/TARGET_LPC11U6X/TOOLCHAIN_GCC_ARM/TARGET_LPC11U68
ASM_FLAGS += -I../PokittoLib/mbed-pokitto/targets/cmsis/TOOLCHAIN_GCC
ASM_FLAGS += -I../PokittoLib/mbed-pokitto/targets/hal
ASM_FLAGS += -I../PokittoLib/mbed-pokitto/targets/hal/TARGET_NXP
ASM_FLAGS += -I../PokittoLib/mbed-pokitto/targets/hal/TARGET_NXP/TARGET_LPC11U6X

LD_FLAGS :=-Wl,--gc-sections -Wl,--wrap,main -Wl,--wrap,_memalign_r -Wl,-n --specs=nano.specs -mcpu=cortex-m0plus -mthumb 
LD_SYS_LIBS :=-Wl,--start-group -lstdc++ -lsupc++ -lm -lc -lgcc -lnosys  -Wl,--end-group

# Tools and Flags
###############################################################################
# Rules

.PHONY: pokitto lst size

pokitto: firmware.bin $(PROJECT).hex size

.s.o:
	+@$(call MAKEDIR,$(dir $@))
	+@echo "Assemble: $(notdir $<)"
  
	@$(AS) -c $(ASM_FLAGS) -o $@ $<
  
.S.o:
	+@$(call MAKEDIR,$(dir $@))
	+@echo "Assemble: $(notdir $<)"
  
	@$(AS) -c $(ASM_FLAGS) -o $@ $<
 
.c.o:
	+@$(call MAKEDIR,$(dir $@))
	+@echo "Compile: $(notdir $<)"
	@$(CC) $(C_FLAGS) $(INCLUDE_PATHS) -o $@ $<

.cpp.o:
	+@$(call MAKEDIR,$(dir $@))
	+@echo "Compile: $(notdir $<)"
	@$(CPP) $(CXX_FLAGS) $(INCLUDE_PATHS) -o $@ $<

$(PROJECT).link_script.ld: $(LINKER_SCRIPT)
	@$(PREPROC) $< -o $@

$(PROJECT).elf: $(OBJECTS) $(SYS_OBJECTS) $(PROJECT).link_script.ld 
	+@echo "link: $(notdir $@)"
	@$(LD) $(LD_FLAGS) -T $(filter-out %.o, $^) $(LIBRARY_PATHS) --output $@ $(filter %.o, $^) $(LIBRARIES) $(LD_SYS_LIBS)

firmware.bin: $(PROJECT).elf
	$(ELF2BIN) -O binary $< $@
	+@echo "===== bin file ready to flash: $(OBJDIR)/$@ =====" 

$(PROJECT).hex: $(PROJECT).elf
	$(ELF2BIN) -O ihex $< $@

# Rules
###############################################################################
# Dependencies

DEPS = $(OBJECTS:.o=.d) $(SYS_OBJECTS:.o=.d)
-include $(DEPS)
endif

# Dependencies
###############################################################################

