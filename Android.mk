# CROSS_COMPILE := $(TOP)prebuilt/$(HOST_PREBUILT_TAG)/toolchain/arm-eabi-4.4.3/bin/arm-eabi-
# 
# to check : prebuilt/linux-x86/toolchain/i686-linux-glibc2.7-4.4.3/sysroot/usr/include/net/if.h

LOCAL_PATH:= $(call my-dir)

# ========================================================
# kexec
# ========================================================

# util_lib
include $(CLEAR_VARS)

LOCAL_MODULE := kexec-libutil
LOCAL_MODULE_TAGS := optional

LOCAL_SRC_FILES := \
 util_lib/compute_ip_checksum.c \
 util_lib/sha256.c

LOCAL_C_INCLUDES := $(LOCAL_PATH)/util_lib/include

include $(BUILD_STATIC_LIBRARY)

##################################################

include $(CLEAR_VARS)

LOCAL_MODULE := kexec
LOCAL_MODULE_TAGS := optional

KEXEC_SRCS += kexec/kexec.c
KEXEC_SRCS += kexec/ifdown.c
KEXEC_SRCS += kexec/kexec-elf.c
KEXEC_SRCS += kexec/kexec-elf-exec.c
KEXEC_SRCS += kexec/kexec-elf-core.c
KEXEC_SRCS += kexec/kexec-elf-rel.c
KEXEC_SRCS += kexec/kexec-elf-boot.c
KEXEC_SRCS += kexec/kexec-iomem.c
KEXEC_SRCS += kexec/firmware_memmap.c
KEXEC_SRCS += kexec/crashdump.c
KEXEC_SRCS += kexec/crashdump-xen.c
KEXEC_SRCS += kexec/phys_arch.c
KEXEC_SRCS += kexec/kernel_version.c
KEXEC_SRCS += kexec/lzma.c
KEXEC_SRCS += kexec/zlib.c

KEXEC_SRCS += kexec/kexec-uImage.c
KEXEC_SRCS += kexec/add_buffer.c
KEXEC_SRCS += kexec/add_segment.c
KEXEC_SRCS += kexec/arch_reuse_initrd.c
KEXEC_SRCS += kexec/proc_iomem.c
KEXEC_SRCS += kexec/phys_to_virt.c
KEXEC_SRCS += kexec/virt_to_phys.c

LOCAL_SRC_FILES := $(KEXEC_SRCS) \
 kexec/arch/$(TARGET_ARCH)/kexec-$(TARGET_ARCH).c \
 kexec/arch/$(TARGET_ARCH)/crashdump-$(TARGET_ARCH).c \
 kexec/arch/$(TARGET_ARCH)/kexec-uImage-$(TARGET_ARCH).c \
 kexec/arch/$(TARGET_ARCH)/kexec-zImage-$(TARGET_ARCH).c

LOCAL_C_INCLUDES := \
 $(LOCAL_PATH)/include \
 $(LOCAL_PATH)/kexec/arch/$(TARGET_ARCH)/include \
 $(LOCAL_PATH)/util_lib/include \
 $(TOP)/external/zlib

LOCAL_MODULE_CLASS := UTILITY_EXECUTABLES
LOCAL_MODULE_PATH := $(PRODUCT_OUT)/utilities
LOCAL_UNSTRIPPED_PATH := $(PRODUCT_OUT)/symbols/utilities

LOCAL_REQUIRED_MODULES := kexec-libutil libz
LOCAL_STATIC_LIBRARIES := kexec-libutil libz

# should be renamed, because kexec subfolder exists in sources
LOCAL_MODULE_STEM := $(LOCAL_MODULE)-$(TARGET_ARCH)

include $(BUILD_EXECUTABLE)


# ========================================================
# kdump
# ========================================================
include $(CLEAR_VARS)

LOCAL_MODULE := kdump
LOCAL_MODULE_TAGS := optional

LOCAL_SRC_FILES := kdump/kdump.c
LOCAL_C_INCLUDES := $(LOCAL_PATH)/include

LOCAL_MODULE_CLASS := UTILITY_EXECUTABLES
LOCAL_MODULE_PATH := $(PRODUCT_OUT)/utilities
LOCAL_UNSTRIPPED_PATH := $(PRODUCT_OUT)/symbols/utilities

# should be renamed, because kexec subfolder exists in sources
LOCAL_MODULE_STEM := $(LOCAL_MODULE)-$(TARGET_ARCH)

include $(BUILD_EXECUTABLE)

