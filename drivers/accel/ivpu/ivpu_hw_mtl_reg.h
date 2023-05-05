/* SPDX-License-Identifier: GPL-2.0-only */
/*
 * Copyright (C) 2020-2023 Intel Corporation
 */

#ifndef __IVPU_HW_MTL_REG_H__
#define __IVPU_HW_MTL_REG_H__

#include <linux/bits.h>

#define MTL_BUTTRESS_INTERRUPT_TYPE					0x00000000u

#define MTL_BUTTRESS_INTERRUPT_STAT					0x00000004u
#define MTL_BUTTRESS_INTERRUPT_STAT_FREQ_CHANGE_MASK			BIT_MASK(0)
#define MTL_BUTTRESS_INTERRUPT_STAT_ATS_ERR_MASK			BIT_MASK(1)
#define MTL_BUTTRESS_INTERRUPT_STAT_UFI_ERR_MASK			BIT_MASK(2)

#define MTL_BUTTRESS_WP_REQ_PAYLOAD0					0x00000008u
#define MTL_BUTTRESS_WP_REQ_PAYLOAD0_MIN_RATIO_MASK			GENMASK(15, 0)
#define MTL_BUTTRESS_WP_REQ_PAYLOAD0_MAX_RATIO_MASK			GENMASK(31, 16)

#define MTL_BUTTRESS_WP_REQ_PAYLOAD1					0x0000000cu
#define MTL_BUTTRESS_WP_REQ_PAYLOAD1_TARGET_RATIO_MASK			GENMASK(15, 0)
#define MTL_BUTTRESS_WP_REQ_PAYLOAD1_EPP_MASK				GENMASK(31, 16)

#define MTL_BUTTRESS_WP_REQ_PAYLOAD2					0x00000010u
#define MTL_BUTTRESS_WP_REQ_PAYLOAD2_CONFIG_MASK			GENMASK(15, 0)

#define MTL_BUTTRESS_WP_REQ_CMD						0x00000014u
#define MTL_BUTTRESS_WP_REQ_CMD_SEND_MASK				BIT_MASK(0)

#define MTL_BUTTRESS_WP_DOWNLOAD					0x00000018u
#define MTL_BUTTRESS_WP_DOWNLOAD_TARGET_RATIO_MASK			GENMASK(15, 0)

#define MTL_BUTTRESS_CURRENT_PLL					0x0000001cu
#define MTL_BUTTRESS_CURRENT_PLL_RATIO_MASK				GENMASK(15, 0)

#define MTL_BUTTRESS_PLL_ENABLE						0x00000020u

#define MTL_BUTTRESS_FMIN_FUSE						0x00000024u
#define MTL_BUTTRESS_FMIN_FUSE_MIN_RATIO_MASK				GENMASK(7, 0)
#define MTL_BUTTRESS_FMIN_FUSE_PN_RATIO_MASK				GENMASK(15, 8)

#define MTL_BUTTRESS_FMAX_FUSE						0x00000028u
#define MTL_BUTTRESS_FMAX_FUSE_MAX_RATIO_MASK				GENMASK(7, 0)

#define MTL_BUTTRESS_TILE_FUSE						0x0000002cu
#define MTL_BUTTRESS_TILE_FUSE_VALID_MASK				BIT_MASK(0)
#define MTL_BUTTRESS_TILE_FUSE_SKU_MASK					GENMASK(3, 2)

#define MTL_BUTTRESS_LOCAL_INT_MASK					0x00000030u
#define MTL_BUTTRESS_GLOBAL_INT_MASK					0x00000034u

#define MTL_BUTTRESS_PLL_STATUS						0x00000040u
#define MTL_BUTTRESS_PLL_STATUS_LOCK_MASK				BIT_MASK(1)

#define MTL_BUTTRESS_VPU_STATUS						0x00000044u
#define MTL_BUTTRESS_VPU_STATUS_READY_MASK				BIT_MASK(0)
#define MTL_BUTTRESS_VPU_STATUS_IDLE_MASK				BIT_MASK(1)

#define MTL_BUTTRESS_VPU_D0I3_CONTROL					0x00000060u
#define MTL_BUTTRESS_VPU_D0I3_CONTROL_INPROGRESS_MASK			BIT_MASK(0)
#define MTL_BUTTRESS_VPU_D0I3_CONTROL_I3_MASK				BIT_MASK(2)

#define MTL_BUTTRESS_VPU_IP_RESET					0x00000050u
#define MTL_BUTTRESS_VPU_IP_RESET_TRIGGER_MASK				BIT_MASK(0)

#define MTL_BUTTRESS_VPU_TELEMETRY_OFFSET				0x00000080u
#define MTL_BUTTRESS_VPU_TELEMETRY_SIZE					0x00000084u
#define MTL_BUTTRESS_VPU_TELEMETRY_ENABLE				0x00000088u

#define MTL_BUTTRESS_ATS_ERR_LOG_0					0x000000a0u
#define MTL_BUTTRESS_ATS_ERR_LOG_1					0x000000a4u
#define MTL_BUTTRESS_ATS_ERR_CLEAR					0x000000a8u

#define MTL_BUTTRESS_UFI_ERR_LOG					0x000000b0u
#define MTL_BUTTRESS_UFI_ERR_LOG_CQ_ID_MASK				GENMASK(11, 0)
#define MTL_BUTTRESS_UFI_ERR_LOG_AXI_ID_MASK				GENMASK(19, 12)
#define MTL_BUTTRESS_UFI_ERR_LOG_OPCODE_MASK				GENMASK(24, 20)

#define MTL_BUTTRESS_UFI_ERR_CLEAR					0x000000b4u

#define MTL_VPU_HOST_SS_CPR_CLK_SET					0x00000084u
#define MTL_VPU_HOST_SS_CPR_CLK_SET_TOP_NOC_MASK			BIT_MASK(1)
#define MTL_VPU_HOST_SS_CPR_CLK_SET_DSS_MAS_MASK			BIT_MASK(10)
#define MTL_VPU_HOST_SS_CPR_CLK_SET_MSS_MAS_MASK			BIT_MASK(11)

#define MTL_VPU_HOST_SS_CPR_RST_SET					0x00000094u
#define MTL_VPU_HOST_SS_CPR_RST_SET_TOP_NOC_MASK			BIT_MASK(1)
#define MTL_VPU_HOST_SS_CPR_RST_SET_DSS_MAS_MASK			BIT_MASK(10)
#define MTL_VPU_HOST_SS_CPR_RST_SET_MSS_MAS_MASK			BIT_MASK(11)

#define MTL_VPU_HOST_SS_CPR_RST_CLR					0x00000098u
#define MTL_VPU_HOST_SS_CPR_RST_CLR_TOP_NOC_MASK			BIT_MASK(1)
#define MTL_VPU_HOST_SS_CPR_RST_CLR_DSS_MAS_MASK			BIT_MASK(10)
#define MTL_VPU_HOST_SS_CPR_RST_CLR_MSS_MAS_MASK			BIT_MASK(11)

#define MTL_VPU_HOST_SS_HW_VERSION					0x00000108u
#define MTL_VPU_HOST_SS_HW_VERSION_SOC_REVISION_MASK			GENMASK(7, 0)
#define MTL_VPU_HOST_SS_HW_VERSION_SOC_NUMBER_MASK			GENMASK(15, 8)
#define MTL_VPU_HOST_SS_HW_VERSION_VPU_GENERATION_MASK			GENMASK(23, 16)

#define MTL_VPU_HOST_SS_GEN_CTRL					0x00000118u
#define MTL_VPU_HOST_SS_GEN_CTRL_PS_MASK				GENMASK(31, 29)

#define MTL_VPU_HOST_SS_NOC_QREQN					0x00000154u
#define MTL_VPU_HOST_SS_NOC_QREQN_TOP_SOCMMIO_MASK			BIT_MASK(0)

#define MTL_VPU_HOST_SS_NOC_QACCEPTN					0x00000158u
#define MTL_VPU_HOST_SS_NOC_QACCEPTN_TOP_SOCMMIO_MASK			BIT_MASK(0)

#define MTL_VPU_HOST_SS_NOC_QDENY					0x0000015cu
#define MTL_VPU_HOST_SS_NOC_QDENY_TOP_SOCMMIO_MASK			BIT_MASK(0)

#define MTL_VPU_TOP_NOC_QREQN						0x00000160u
#define MTL_VPU_TOP_NOC_QREQN_CPU_CTRL_MASK				BIT_MASK(0)
#define MTL_VPU_TOP_NOC_QREQN_HOSTIF_L2CACHE_MASK			BIT_MASK(1)

#define MTL_VPU_TOP_NOC_QACCEPTN					0x00000164u
#define MTL_VPU_TOP_NOC_QACCEPTN_CPU_CTRL_MASK				BIT_MASK(0)
#define MTL_VPU_TOP_NOC_QACCEPTN_HOSTIF_L2CACHE_MASK			BIT_MASK(1)

#define MTL_VPU_TOP_NOC_QDENY						0x00000168u
#define MTL_VPU_TOP_NOC_QDENY_CPU_CTRL_MASK				BIT_MASK(0)
#define MTL_VPU_TOP_NOC_QDENY_HOSTIF_L2CACHE_MASK			BIT_MASK(1)

#define MTL_VPU_HOST_SS_FW_SOC_IRQ_EN					0x00000170u
#define MTL_VPU_HOST_SS_FW_SOC_IRQ_EN_CSS_ROM_CMX_MASK			BIT_MASK(0)
#define MTL_VPU_HOST_SS_FW_SOC_IRQ_EN_CSS_DBG_MASK			BIT_MASK(1)
#define MTL_VPU_HOST_SS_FW_SOC_IRQ_EN_CSS_CTRL_MASK			BIT_MASK(2)
#define MTL_VPU_HOST_SS_FW_SOC_IRQ_EN_DEC400_MASK			BIT_MASK(3)
#define MTL_VPU_HOST_SS_FW_SOC_IRQ_EN_MSS_NCE_MASK			BIT_MASK(4)
#define MTL_VPU_HOST_SS_FW_SOC_IRQ_EN_MSS_MBI_MASK			BIT_MASK(5)
#define MTL_VPU_HOST_SS_FW_SOC_IRQ_EN_MSS_MBI_CMX_MASK			BIT_MASK(6)

#define MTL_VPU_HOST_SS_ICB_STATUS_0					0x00010210u
#define MTL_VPU_HOST_SS_ICB_STATUS_0_TIMER_0_INT_MASK			BIT_MASK(0)
#define MTL_VPU_HOST_SS_ICB_STATUS_0_TIMER_1_INT_MASK			BIT_MASK(1)
#define MTL_VPU_HOST_SS_ICB_STATUS_0_TIMER_2_INT_MASK			BIT_MASK(2)
#define MTL_VPU_HOST_SS_ICB_STATUS_0_TIMER_3_INT_MASK			BIT_MASK(3)
#define MTL_VPU_HOST_SS_ICB_STATUS_0_HOST_IPC_FIFO_INT_MASK		BIT_MASK(4)
#define MTL_VPU_HOST_SS_ICB_STATUS_0_MMU_IRQ_0_INT_MASK			BIT_MASK(5)
#define MTL_VPU_HOST_SS_ICB_STATUS_0_MMU_IRQ_1_INT_MASK			BIT_MASK(6)
#define MTL_VPU_HOST_SS_ICB_STATUS_0_MMU_IRQ_2_INT_MASK			BIT_MASK(7)
#define MTL_VPU_HOST_SS_ICB_STATUS_0_NOC_FIREWALL_INT_MASK		BIT_MASK(8)
#define MTL_VPU_HOST_SS_ICB_STATUS_0_CPU_INT_REDIRECT_0_INT_MASK	BIT_MASK(30)
#define MTL_VPU_HOST_SS_ICB_STATUS_0_CPU_INT_REDIRECT_1_INT_MASK	BIT_MASK(31)

#define MTL_VPU_HOST_SS_ICB_STATUS_1					0x00010214u
#define MTL_VPU_HOST_SS_ICB_STATUS_1_CPU_INT_REDIRECT_2_INT_MASK	BIT_MASK(0)
#define MTL_VPU_HOST_SS_ICB_STATUS_1_CPU_INT_REDIRECT_3_INT_MASK	BIT_MASK(1)
#define MTL_VPU_HOST_SS_ICB_STATUS_1_CPU_INT_REDIRECT_4_INT_MASK	BIT_MASK(2)

#define MTL_VPU_HOST_SS_ICB_CLEAR_0					0x00010220u
#define MTL_VPU_HOST_SS_ICB_CLEAR_1					0x00010224u
#define MTL_VPU_HOST_SS_ICB_ENABLE_0					0x00010240u

#define MTL_VPU_HOST_SS_TIM_IPC_FIFO_ATM				0x000200f4u

#define MTL_VPU_HOST_SS_TIM_IPC_FIFO_STAT				0x000200fcu
#define MTL_VPU_HOST_SS_TIM_IPC_FIFO_STAT_READ_POINTER_MASK		GENMASK(7, 0)
#define MTL_VPU_HOST_SS_TIM_IPC_FIFO_STAT_WRITE_POINTER_MASK		GENMASK(15, 8)
#define MTL_VPU_HOST_SS_TIM_IPC_FIFO_STAT_FILL_LEVEL_MASK		GENMASK(23, 16)
#define MTL_VPU_HOST_SS_TIM_IPC_FIFO_STAT_RSVD0_MASK			GENMASK(31, 24)

#define MTL_VPU_HOST_SS_AON_PWR_ISO_EN0					0x00030020u
#define MTL_VPU_HOST_SS_AON_PWR_ISO_EN0_MSS_CPU_MASK			BIT_MASK(3)

#define MTL_VPU_HOST_SS_AON_PWR_ISLAND_EN0				0x00030024u
#define MTL_VPU_HOST_SS_AON_PWR_ISLAND_EN0_MSS_CPU_MASK			BIT_MASK(3)

#define MTL_VPU_HOST_SS_AON_PWR_ISLAND_TRICKLE_EN0			0x00030028u
#define MTL_VPU_HOST_SS_AON_PWR_ISLAND_TRICKLE_EN0_MSS_CPU_MASK		BIT_MASK(3)

#define MTL_VPU_HOST_SS_AON_PWR_ISLAND_STATUS0				0x0003002cu
#define MTL_VPU_HOST_SS_AON_PWR_ISLAND_STATUS0_MSS_CPU_MASK		BIT_MASK(3)

#define MTL_VPU_HOST_SS_AON_VPU_IDLE_GEN				0x00030200u
#define MTL_VPU_HOST_SS_AON_VPU_IDLE_GEN_EN_MASK			BIT_MASK(0)

#define MTL_VPU_HOST_SS_AON_DPU_ACTIVE					0x00030204u
#define MTL_VPU_HOST_SS_AON_DPU_ACTIVE_DPU_ACTIVE_MASK			BIT_MASK(0)

#define MTL_VPU_HOST_SS_LOADING_ADDRESS_LO				0x00041040u
#define MTL_VPU_HOST_SS_LOADING_ADDRESS_LO_DONE_MASK			BIT_MASK(0)
#define MTL_VPU_HOST_SS_LOADING_ADDRESS_LO_IOSF_RS_ID_MASK		GENMASK(2, 1)
#define MTL_VPU_HOST_SS_LOADING_ADDRESS_LO_IMAGE_LOCATION_MASK		GENMASK(31, 3)

#define MTL_VPU_HOST_SS_WORKPOINT_CONFIG_MIRROR				0x00082020u
#define MTL_VPU_HOST_SS_WORKPOINT_CONFIG_MIRROR_FINAL_PLL_FREQ_MASK	GENMASK(15, 0)
#define MTL_VPU_HOST_SS_WORKPOINT_CONFIG_MIRROR_CONFIG_ID_MASK		GENMASK(31, 16)

#define MTL_VPU_HOST_MMU_IDR0						0x00200000u
#define MTL_VPU_HOST_MMU_IDR1						0x00200004u
#define MTL_VPU_HOST_MMU_IDR3						0x0020000cu
#define MTL_VPU_HOST_MMU_IDR5						0x00200014u
#define MTL_VPU_HOST_MMU_CR0						0x00200020u
#define MTL_VPU_HOST_MMU_CR0ACK						0x00200024u
#define MTL_VPU_HOST_MMU_CR1						0x00200028u
#define MTL_VPU_HOST_MMU_CR2						0x0020002cu
#define MTL_VPU_HOST_MMU_IRQ_CTRL					0x00200050u
#define MTL_VPU_HOST_MMU_IRQ_CTRLACK					0x00200054u

#define MTL_VPU_HOST_MMU_GERROR						0x00200060u
#define MTL_VPU_HOST_MMU_GERROR_CMDQ_MASK				BIT_MASK(0)
#define MTL_VPU_HOST_MMU_GERROR_EVTQ_ABT_MASK				BIT_MASK(2)
#define MTL_VPU_HOST_MMU_GERROR_PRIQ_ABT_MASK				BIT_MASK(3)
#define MTL_VPU_HOST_MMU_GERROR_MSI_CMDQ_ABT_MASK			BIT_MASK(4)
#define MTL_VPU_HOST_MMU_GERROR_MSI_EVTQ_ABT_MASK			BIT_MASK(5)
#define MTL_VPU_HOST_MMU_GERROR_MSI_PRIQ_ABT_MASK			BIT_MASK(6)
#define MTL_VPU_HOST_MMU_GERROR_MSI_ABT_MASK				BIT_MASK(7)

#define MTL_VPU_HOST_MMU_GERRORN					0x00200064u

#define MTL_VPU_HOST_MMU_STRTAB_BASE					0x00200080u
#define MTL_VPU_HOST_MMU_STRTAB_BASE_CFG				0x00200088u
#define MTL_VPU_HOST_MMU_CMDQ_BASE					0x00200090u
#define MTL_VPU_HOST_MMU_CMDQ_PROD					0x00200098u
#define MTL_VPU_HOST_MMU_CMDQ_CONS					0x0020009cu
#define MTL_VPU_HOST_MMU_EVTQ_BASE					0x002000a0u
#define MTL_VPU_HOST_MMU_EVTQ_PROD					0x002000a8u
#define MTL_VPU_HOST_MMU_EVTQ_CONS					0x002000acu
#define MTL_VPU_HOST_MMU_EVTQ_PROD_SEC					(0x002000a8u + SZ_64K)
#define MTL_VPU_HOST_MMU_EVTQ_CONS_SEC					(0x002000acu + SZ_64K)

#define MTL_VPU_HOST_IF_TCU_PTW_OVERRIDES				0x00360000u
#define MTL_VPU_HOST_IF_TCU_PTW_OVERRIDES_CACHE_OVERRIDE_EN_MASK	BIT_MASK(0)
#define MTL_VPU_HOST_IF_TCU_PTW_OVERRIDES_AWCACHE_OVERRIDE_MASK		BIT_MASK(1)
#define MTL_VPU_HOST_IF_TCU_PTW_OVERRIDES_ARCACHE_OVERRIDE_MASK		BIT_MASK(2)
#define MTL_VPU_HOST_IF_TCU_PTW_OVERRIDES_NOSNOOP_OVERRIDE_EN_MASK	BIT_MASK(3)
#define MTL_VPU_HOST_IF_TCU_PTW_OVERRIDES_AW_NOSNOOP_OVERRIDE_MASK	BIT_MASK(4)
#define MTL_VPU_HOST_IF_TCU_PTW_OVERRIDES_AR_NOSNOOP_OVERRIDE_MASK	BIT_MASK(5)
#define MTL_VPU_HOST_IF_TCU_PTW_OVERRIDES_PTW_AW_CONTEXT_FLAG_MASK	GENMASK(10, 6)
#define MTL_VPU_HOST_IF_TCU_PTW_OVERRIDES_PTW_AR_CONTEXT_FLAG_MASK	GENMASK(15, 11)

#define MTL_VPU_HOST_IF_TBU_MMUSSIDV					0x00360004u
#define MTL_VPU_HOST_IF_TBU_MMUSSIDV_TBU0_AWMMUSSIDV_MASK		BIT_MASK(0)
#define MTL_VPU_HOST_IF_TBU_MMUSSIDV_TBU0_ARMMUSSIDV_MASK		BIT_MASK(1)
#define MTL_VPU_HOST_IF_TBU_MMUSSIDV_TBU1_AWMMUSSIDV_MASK		BIT_MASK(2)
#define MTL_VPU_HOST_IF_TBU_MMUSSIDV_TBU1_ARMMUSSIDV_MASK		BIT_MASK(3)
#define MTL_VPU_HOST_IF_TBU_MMUSSIDV_TBU2_AWMMUSSIDV_MASK		BIT_MASK(4)
#define MTL_VPU_HOST_IF_TBU_MMUSSIDV_TBU2_ARMMUSSIDV_MASK		BIT_MASK(5)
#define MTL_VPU_HOST_IF_TBU_MMUSSIDV_TBU3_AWMMUSSIDV_MASK		BIT_MASK(6)
#define MTL_VPU_HOST_IF_TBU_MMUSSIDV_TBU3_ARMMUSSIDV_MASK		BIT_MASK(7)
#define MTL_VPU_HOST_IF_TBU_MMUSSIDV_TBU4_AWMMUSSIDV_MASK		BIT_MASK(8)
#define MTL_VPU_HOST_IF_TBU_MMUSSIDV_TBU4_ARMMUSSIDV_MASK		BIT_MASK(9)

#define MTL_VPU_CPU_SS_DSU_LEON_RT_BASE					0x04000000u
#define MTL_VPU_CPU_SS_DSU_LEON_RT_DSU_CTRL				0x04000000u
#define MTL_VPU_CPU_SS_DSU_LEON_RT_PC_REG				0x04400010u
#define MTL_VPU_CPU_SS_DSU_LEON_RT_NPC_REG				0x04400014u
#define MTL_VPU_CPU_SS_DSU_LEON_RT_DSU_TRAP_REG				0x04400020u

#define MTL_VPU_CPU_SS_MSSCPU_CPR_CLK_SET				0x06010004u
#define MTL_VPU_CPU_SS_MSSCPU_CPR_CLK_SET_CPU_DSU_MASK			BIT_MASK(1)

#define MTL_VPU_CPU_SS_MSSCPU_CPR_RST_CLR				0x06010018u
#define MTL_VPU_CPU_SS_MSSCPU_CPR_RST_CLR_CPU_DSU_MASK			BIT_MASK(1)

#define MTL_VPU_CPU_SS_MSSCPU_CPR_LEON_RT_VEC				0x06010040u
#define MTL_VPU_CPU_SS_MSSCPU_CPR_LEON_RT_VEC_IRQI_RSTRUN0_MASK		BIT_MASK(0)
#define MTL_VPU_CPU_SS_MSSCPU_CPR_LEON_RT_VEC_IRQI_RESUME0_MASK		BIT_MASK(1)
#define MTL_VPU_CPU_SS_MSSCPU_CPR_LEON_RT_VEC_IRQI_RSTRUN1_MASK		BIT_MASK(2)
#define MTL_VPU_CPU_SS_MSSCPU_CPR_LEON_RT_VEC_IRQI_RESUME1_MASK		BIT_MASK(3)
#define MTL_VPU_CPU_SS_MSSCPU_CPR_LEON_RT_VEC_IRQI_RSTVEC_MASK		GENMASK(31, 4)

#define MTL_VPU_CPU_SS_TIM_WATCHDOG					0x0602009cu
#define MTL_VPU_CPU_SS_TIM_WDOG_EN					0x060200a4u
#define MTL_VPU_CPU_SS_TIM_SAFE						0x060200a8u
#define MTL_VPU_CPU_SS_TIM_IPC_FIFO					0x060200f0u

#define MTL_VPU_CPU_SS_TIM_GEN_CONFIG					0x06021008u
#define MTL_VPU_CPU_SS_TIM_GEN_CONFIG_WDOG_TO_INT_CLR_MASK		BIT_MASK(9)

#define MTL_VPU_CPU_SS_DOORBELL_0					0x06300000u
#define MTL_VPU_CPU_SS_DOORBELL_0_SET_MASK				BIT_MASK(0)

#define MTL_VPU_CPU_SS_DOORBELL_1					0x06301000u

#endif /* __IVPU_HW_MTL_REG_H__ */
