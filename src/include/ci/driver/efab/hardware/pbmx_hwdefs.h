/*
** Copyright 2005-2012  Solarflare Communications Inc.
**                      7505 Irvine Center Drive, Irvine, CA 92618, USA
** Copyright 2002-2005  Level 5 Networks Inc.
**
** This program is free software; you can redistribute it and/or modify it
** under the terms of version 2 of the GNU General Public License as
** published by the Free Software Foundation.
**
** This program is distributed in the hope that it will be useful,
** but WITHOUT ANY WARRANTY; without even the implied warranty of
** MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
** GNU General Public License for more details.
*/

/* This file is autogenerated, do not manually alter.    */
/* If you are in the v5 tree, you can refresh headers    */
/* with the genheader utility in .../v5/scripts          */
#ifndef	PBMX_PROGMODEL_DEFS_H
#define	PBMX_PROGMODEL_DEFS_H


/*------------------------------------------------------------*/
/*
 * FPMR_CZ_TX_PBMX_CFG_REG(24bit):
 * Probe mux configuration register
 */
#define	FPMR_CZ_TX_PBMX_CFG_REG 0x00000000
	/* sienaa0=pbmx_f0 */
#define	FPMR_CZ_TX_PBMX_CFG_REG_STEP 16
#define	FPMR_CZ_TX_PBMX_CFG_REG_ROWS 6
/*
 * FPMR_CZ_RX_PBMX_CFG_REG(24bit):
 * Probe mux configuration register
 */
#define	FPMR_CZ_RX_PBMX_CFG_REG 0x00000100
	/* sienaa0=pbmx_f0 */
#define	FPMR_CZ_RX_PBMX_CFG_REG_STEP 16
#define	FPMR_CZ_RX_PBMX_CFG_REG_ROWS 6
/*
 * FPMR_CZ_EV_PBMX_CFG_REG(24bit):
 * Probe mux configuration register
 */
#define	FPMR_CZ_EV_PBMX_CFG_REG 0x00000200
	/* sienaa0=pbmx_f0 */
#define	FPMR_CZ_EV_PBMX_CFG_REG_STEP 16
#define	FPMR_CZ_EV_PBMX_CFG_REG_ROWS 4
/*
 * FPMR_CZ_EM_PBMX_CFG_REG(24bit):
 * Probe mux configuration register
 */
#define	FPMR_CZ_EM_PBMX_CFG_REG 0x00000300
	/* sienaa0=pbmx_f0 */
#define	FPMR_CZ_EM_PBMX_CFG_REG_STEP 16
#define	FPMR_CZ_EM_PBMX_CFG_REG_ROWS 3
/*
 * FPMR_CZ_SR_PBMX_CFG_REG(24bit):
 * Probe mux configuration register
 */
#define	FPMR_CZ_SR_PBMX_CFG_REG 0x00000400
	/* sienaa0=pbmx_f0 */
#define	FPMR_CZ_SR_PBMX_CFG_REG_STEP 16
#define	FPMR_CZ_SR_PBMX_CFG_REG_ROWS 4
/*
 * FPMR_CZ_BIU_PBMX_CFG_REG(24bit):
 * Probe mux configuration register
 */
#define	FPMR_CZ_BIU_PBMX_CFG_REG 0x00008000
	/* sienaa0=pbmx_f0 */
#define	FPMR_CZ_BIU_PBMX_CFG_REG_STEP 16
#define	FPMR_CZ_BIU_PBMX_CFG_REG_ROWS 7
/*
 * FPMR_CZ_MC_PBMX_CFG_REG(24bit):
 * Probe mux configuration register
 */
#define	FPMR_CZ_MC_PBMX_CFG_REG 0x00008100
	/* sienaa0=pbmx_f0 */
#define	FPMR_CZ_MC_PBMX_CFG_REG_STEP 16
#define	FPMR_CZ_MC_PBMX_CFG_REG_ROWS 7

#define	FPMRF_CZ_PBMX_OG5_EN_LBN 23
#define	FPMRF_CZ_PBMX_OG5_EN_WIDTH 1
#define	FPMRF_CZ_PBMX_OG5_SEL_LBN 20
#define	FPMRF_CZ_PBMX_OG5_SEL_WIDTH 3
#define	FPMRF_CZ_PBMX_OG4_EN_LBN 19
#define	FPMRF_CZ_PBMX_OG4_EN_WIDTH 1
#define	FPMRF_CZ_PBMX_OG4_SEL_LBN 16
#define	FPMRF_CZ_PBMX_OG4_SEL_WIDTH 3
#define	FPMRF_CZ_PBMX_OG3_EN_LBN 15
#define	FPMRF_CZ_PBMX_OG3_EN_WIDTH 1
#define	FPMRF_CZ_PBMX0_OG3_SEL_LBN 12
#define	FPMRF_CZ_PBMX0_OG3_SEL_WIDTH 3
#define	FPMRF_CZ_PBMX_OG2_EN_LBN 11
#define	FPMRF_CZ_PBMX_OG2_EN_WIDTH 1
#define	FPMRF_CZ_PBMX_OG2_SEL_LBN 8
#define	FPMRF_CZ_PBMX_OG2_SEL_WIDTH 3
#define	FPMRF_CZ_PBMX_OG1_EN_LBN 7
#define	FPMRF_CZ_PBMX_OG1_EN_WIDTH 1
#define	FPMRF_CZ_PBMX_OG1_SEL_LBN 4
#define	FPMRF_CZ_PBMX_OG1_SEL_WIDTH 3
#define	FPMRF_CZ_PBMX_OG0_EN_LBN 3
#define	FPMRF_CZ_PBMX_OG0_EN_WIDTH 1
#define	FPMRF_CZ_PBMX_OG0_SEL_LBN 0
#define	FPMRF_CZ_PBMX_OG0_SEL_WIDTH 3


/*------------------------------------------------------------*/
/*
 * FPMR_CZ_TX_PBMGR_CFG_REG(24bit):
 * probe merger configuration register
 */
#define	FPMR_CZ_TX_PBMGR_CFG_REG 0x00000060
	/* sienaa0=pbmx_f0 */
/*
 * FPMR_CZ_RX_PBMGR_CFG_REG(24bit):
 * probe merger configuration register
 */
#define	FPMR_CZ_RX_PBMGR_CFG_REG 0x00000160
	/* sienaa0=pbmx_f0 */
/*
 * FPMR_CZ_EV_PBMGR_CFG_REG(24bit):
 * probe merger configuration register
 */
#define	FPMR_CZ_EV_PBMGR_CFG_REG 0x00000240
	/* sienaa0=pbmx_f0 */
/*
 * FPMR_CZ_EM_PBMGR_CFG_REG(24bit):
 * probe merger configuration register
 */
#define	FPMR_CZ_EM_PBMGR_CFG_REG 0x00000330
	/* sienaa0=pbmx_f0 */
/*
 * FPMR_CZ_SR_PBMGR_CFG_REG(24bit):
 * probe merger configuration register
 */
#define	FPMR_CZ_SR_PBMGR_CFG_REG 0x00000440
	/* sienaa0=pbmx_f0 */
/*
 * FPMR_CZ_BIU_PBMGR_CFG_REG(24bit):
 * probe merger configuration register
 */
#define	FPMR_CZ_BIU_PBMGR_CFG_REG 0x00008070
	/* sienaa0=pbmx_f0 */
/*
 * FPMR_CZ_MC_PBMGR_CFG_REG(24bit):
 * probe merger configuration register
 */
#define	FPMR_CZ_MC_PBMGR_CFG_REG 0x00008170
	/* sienaa0=pbmx_f0 */

#define	FPMRF_CZ_PBMGR_TODIO_OE_LBN 15
#define	FPMRF_CZ_PBMGR_TODIO_OE_WIDTH 1
#define	FPMRF_CZ_PBMGR_TOCAP_OE_LBN 14
#define	FPMRF_CZ_PBMGR_TOCAP_OE_WIDTH 1
#define	FPMRF_CZ_PBMGR_CTRL_OE_LBN 2
#define	FPMRF_CZ_PBMGR_CTRL_OE_WIDTH 12
#define	FPMRF_CZ_PBMGR_CTRL_SEL_LBN 0
#define	FPMRF_CZ_PBMGR_CTRL_SEL_WIDTH 2


/*------------------------------------------------------------*/
/*
 * FPMR_CZ_TX_PBMX_SNAPSHOT_REG(56bit):
 * Snapshot of pbmx output to the capture module
 */
#define	FPMR_CZ_TX_PBMX_SNAPSHOT_REG 0x00000070
	/* sienaa0=pbmx_f0 */
/*
 * FPMR_CZ_RX_PBMX_SNAPSHOT_REG(56bit):
 * Snapshot of pbmx output to the capture module
 */
#define	FPMR_CZ_RX_PBMX_SNAPSHOT_REG 0x00000170
	/* sienaa0=pbmx_f0 */
/*
 * FPMR_CZ_EV_PBMX_SNAPSHOT_REG(56bit):
 * Snapshot of pbmx output to the capture module
 */
#define	FPMR_CZ_EV_PBMX_SNAPSHOT_REG 0x00000250
	/* sienaa0=pbmx_f0 */
/*
 * FPMR_CZ_EM_PBMX_SNAPSHOT_REG(56bit):
 * Snapshot of pbmx output to the capture module
 */
#define	FPMR_CZ_EM_PBMX_SNAPSHOT_REG 0x00000340
	/* sienaa0=pbmx_f0 */
/*
 * FPMR_CZ_SR_PBMX_SNAPSHOT_REG(56bit):
 * Snapshot of pbmx output to the capture module
 */
#define	FPMR_CZ_SR_PBMX_SNAPSHOT_REG 0x00000450
	/* sienaa0=pbmx_f0 */
/*
 * FPMR_CZ_BIU_PBMX_SNAPSHOT_REG(56bit):
 * Snapshot of pbmx output to the capture module
 */
#define	FPMR_CZ_BIU_PBMX_SNAPSHOT_REG 0x00008080
	/* sienaa0=pbmx_f0 */
/*
 * FPMR_CZ_MC_PBMX_SNAPSHOT_REG(56bit):
 * Snapshot of pbmx output to the capture module
 */
#define	FPMR_CZ_MC_PBMX_SNAPSHOT_REG 0x00008180
	/* sienaa0=pbmx_f0 */

#define	FPMRF_CZ_PBMGR_SNAPSHOT_CTRL_LBN 48
#define	FPMRF_CZ_PBMGR_SNAPSHOT_CTRL_WIDTH 8
#define	FPMRF_CZ_PBMGR_SNAPSHOT_DATA_LBN 0
#define	FPMRF_CZ_PBMGR_SNAPSHOT_DATA_WIDTH 48


/*------------------------------------------------------------*/
/*
 * FPMR_CZ_PBMX_TRG_CFG_REG(32bit):
 * Capture module trigger config register
 */
#define	FPMR_CZ_PBMX_TRG_CFG_REG 0x00000800
	/* sienaa0=pbmx_f0 */
/*
 * FPMR_CZ_MBU_PBMX_TRG_CFG_REG(32bit):
 * Capture module trigger config register
 */
#define	FPMR_CZ_MBU_PBMX_TRG_CFG_REG 0x00008800
	/* sienaa0=pbmx_f0 */

#define	FPMRF_CZ_TRIG_VAL_LBN 16
#define	FPMRF_CZ_TRIG_VAL_WIDTH 12
#define	FPMRF_CZ_TRIG_FND_LBN 12
#define	FPMRF_CZ_TRIG_FND_WIDTH 4
#define	FPMRF_CZ_TRIG_MSK_LBN 0
#define	FPMRF_CZ_TRIG_MSK_WIDTH 12


/*------------------------------------------------------------*/
/*
 * FPMR_CZ_PBMX_STAT_CTRL_REG(32bit):
 * Capture module trigger status/ctrl register
 */
#define	FPMR_CZ_PBMX_STAT_CTRL_REG 0x00000810
	/* sienaa0=pbmx_f0 */
/*
 * FPMR_CZ_MBU_PBMX_STAT_CTRL_REG(32bit):
 * Capture module trigger status/ctrl register
 */
#define	FPMR_CZ_MBU_PBMX_STAT_CTRL_REG 0x00008810
	/* sienaa0=pbmx_f0 */

#define	FPMRF_CZ_TRG_STATUS_LBN 31
#define	FPMRF_CZ_TRG_STATUS_WIDTH 1
#define	FPMRF_CZ_CAPTURE_WORDS_LBN 16
#define	FPMRF_CZ_CAPTURE_WORDS_WIDTH 10
#define	FPMRF_CZ_TRG_REL_POS_LBN 12
#define	FPMRF_CZ_TRG_REL_POS_WIDTH 3
#define	FPMRF_CZ_TRG_ADDR_LBN 0
#define	FPMRF_CZ_TRG_ADDR_WIDTH 9


/*------------------------------------------------------------*/
/*
 * FPMR_CZ_PBMX_CTRL_REG(32bit):
 * Capture module control register
 */
#define	FPMR_CZ_PBMX_CTRL_REG 0x00000820
	/* sienaa0=pbmx_f0 */
/*
 * FPMR_CZ_MBU_PBMX_CTRL_REG(32bit):
 * Capture module control register
 */
#define	FPMR_CZ_MBU_PBMX_CTRL_REG 0x00008820
	/* sienaa0=pbmx_f0 */

#define	FPMRF_CZ_STAT_MODE_LBN 15
#define	FPMRF_CZ_STAT_MODE_WIDTH 1
#define	FPMRF_CZ_ARM_EN_LBN 0
#define	FPMRF_CZ_ARM_EN_WIDTH 1


/*------------------------------------------------------------*/
/*
 * FPMR_CZ_PBMX_CAPTBUF_IADDR_REG(32bit):
 * Capture module indirect address register
 */
#define	FPMR_CZ_PBMX_CAPTBUF_IADDR_REG 0x00000830
	/* sienaa0=pbmx_f0 */
/*
 * FPMR_CZ_MBU_PBMX_CAPTBUF_IADDR_REG(32bit):
 * Capture module indirect address register
 */
#define	FPMR_CZ_MBU_PBMX_CAPTBUF_IADDR_REG 0x00008830
	/* sienaa0=pbmx_f0 */

#define	FPMRF_CZ_CAPTBUF_IADDR_LBN 0
#define	FPMRF_CZ_CAPTBUF_IADDR_WIDTH 9


/*------------------------------------------------------------*/
/*
 * FPMR_CZ_PBMX_CAPTBUF_DATA_REG(64bit):
 * Capture module indirect data register
 */
#define	FPMR_CZ_PBMX_CAPTBUF_DATA_REG 0x00000840
	/* sienaa0=pbmx_f0 */
/*
 * FPMR_CZ_MBU_PBMX_CAPTBUF_DATA_REG(64bit):
 * Capture module indirect data register
 */
#define	FPMR_CZ_MBU_PBMX_CAPTBUF_DATA_REG 0x00008840
	/* sienaa0=pbmx_f0 */

#define	FPMRF_CZ_CAPTBUF_TDELTA_LBN 48
#define	FPMRF_CZ_CAPTBUF_TDELTA_WIDTH 8
#define	FPMRF_CZ_CAPTBUF_VEC_LBN 0
#define	FPMRF_CZ_CAPTBUF_VEC_WIDTH 48


/*------------------------------------------------------------*/
/*
 * FPMR_CZ_PBMX_STAT_REG(32bit):
 * Capture module statistics counter register
 */
#define	FPMR_CZ_PBMX_STAT_REG 0x00000850
	/* sienaa0=pbmx_f0 */
/*
 * FPMR_CZ_MBU_PBMX_STAT_REG(32bit):
 * Capture module statistics counter register
 */
#define	FPMR_CZ_MBU_PBMX_STAT_REG 0x00008850
	/* sienaa0=pbmx_f0 */

#define	FPMRF_CZ_TRG_STAT_CNT_LBN 0
#define	FPMRF_CZ_TRG_STAT_CNT_WIDTH 32




#endif /* PBMX_PROGMODEL_DEFS_H */
