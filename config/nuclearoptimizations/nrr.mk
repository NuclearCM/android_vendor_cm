#
#
#
#    ☢ ☣ ☢ ☣ ☢ ☣ ☢ ☣NuclearTeam☣ ☢ ☣ ☢ ☣ ☢ ☣ ☢
#
#
#
#
# TARGET_NRR_AND can be set before this file to override the default of gcc 4.8 for ROM.
# This is to avoid hardcoding the gcc versions for the ROM and kernels.

 TARGET_NRR_AND := $(TARGET_GCC_VERSION)
 TARGET_NRR_KERNEL := $(TARGET_GCC_VERSION_KERNEL)

 # Set GCC colors
 export GCC_COLORS := 'error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

 ANDROID_BUILD_TOP := $(shell pwd)

 # Find host os
 UNAME := $(shell uname -s)

 HOST_OS := linux

 TARGET_ARCH_LIB_PATH := $(ANDROID_BUILD_TOP)/prebuilts/gcc/$(HOST_PREBUILT_TAG)/arm/arm-linux-androideabi-$(TARGET_NRR_AND)/lib
 export TARGET_ARCH_LIB_PATH := $(ANDROID_BUILD_TOP)/prebuilts/gcc/$(HOST_PREBUILT_TAG)/arm/arm-linux-androideabi-$(TARGET_NRR_AND)/lib

 # Path to ROM toolchain
 NRR_AND_PATH := $(ANDROID_BUILD_TOP)/prebuilts/gcc/linux-x86/arm/arm-linux-androideabi-$(TARGET_NRR_AND)
 NRR_AND := $(shell $(NRR_AND_PATH)/bin/arm-linux-androideabi-gcc --version)

 # Path to kernel toolchain
 NRR_KERNEL_PATH := $(ANDROID_BUILD_TOP)/prebuilts/gcc/linux-x86/arm/arm-eabi-$(TARGET_NRR_KERNEL)
 NRR_KERNEL := $(shell $(NRR_KERNEL_PATH)/bin/arm-eabi-gcc --version)

 # Add extra libs for the compilers to use
 export LD_LIBRARY_PATH := $(TARGET_ARCH_LIB_PATH):$(LD_LIBRARY_PATH)
 export LIBRARY_PATH := $(TARGET_ARCH_LIB_PATH):$(LIBRARY_PATH)

ifeq ($(USE_O3_OPTIMIZATIONS),true)
   OPT1 := (O3)
endif

ifeq ($(GRAPHITE_OPTS),true)
   OPT2 := (graphite)
endif

ifeq ($(KRAIT_TUNINGS),true)
   OPT3 := (krait)
endif

ifeq ($(STRICT_ALIASING),true)
   OPT4 := (strict)
endif

ifeq ($(ENABLE_PTHREAD),true)
   OPT5 := (pthread)
endif

ifeq ($(ENABLE_EXTRAGCC),true)
   OPT6 := (extragcc)
endif

ifeq ($(ENABLE_GOMP),true)
   OPT7 := (openmp)
endif

ifeq (true,$(ENABLE_SANITIZE))
   OPT8 := (MemSanity)
endif

ifeq (true,$(TARGET_USE_PIPE))
   OPT9 := (pipe)
endif

ifeq (true,$(FFAST_MATH))
   OPT10 := (ffast)
endif

ifeq (true,$(ENABLE_IPA_ANALYSER))
   OPT11 := (ipa)
endif
ifeq (true,$(ENABLE_ARM_MODE))
   OPT12 := (arm-mode)
endif
ifeq (true,$(ENABLE_GOLD_LINKER))
   OPT13 := (gold-linker)
endif

  GCC_OPTIMIZATION_LEVELS := $(OPT1)$(OPT2)$(OPT3)$(OPT4)$(OPT5)$(OPT6)$(OPT7)
  GCC_OPTIMIZATION_LEVELS1 := $(OPT8)$(OPT9)$(OPT10)$(OPT11)$(OPT12)$(OPT13)

  ifneq ($(GCC_OPTIMIZATION_LEVELS),)
    PRODUCT_PROPERTY_OVERRIDES += \
      ro.nrr.flags=$(GCC_OPTIMIZATION_LEVELS)
  endif
  ifneq ($(GCC_OPTIMIZATION_LEVELS1),)
    PRODUCT_PROPERTY_OVERRIDES += \
      ro.nrr.flags1=$(GCC_OPTIMIZATION_LEVELS1)
  endif
export GCC_OPTIMIZATION_LEVELS
export GCC_OPTIMIZATION_LEVELS1
