#!/bin/bash -eu
######################################################################

me=$(basename "$0")

err  () { echo >&2 "$*";    }
log  () { err "$me: $*";    }
vlog () { $verbose && err "$me: $*"; }
fail () { log "$*"; exit 1; }
try  () { "$@" || fail "'$*' failed"; }
vmsg () { $quiet || log "$@"; }

function usage()
{
    err
    err "usage:"
    err "  $me [options] <symbol1> <symbol2>"
    err
    err "description:"
    err "  Produce a list of kernel compatability macros to match the "
    err "  kernel_compat.c and kernel_compat.h files"
    err
    err "options:"
    err "  -k KPATH        -- Specify the path to the kernel build source tree"
    err "                     defaults to /lib/modules/VERSION/build"
    err "  -r VERSION      -- Specify the kernel version instead to test"
    err '                     defaults to `uname -r`'
    err "  -a ARCH         -- Set the architecture to ARCH"
    err "                     defaults to `uname -m`"
    err "  -m MAP          -- Specify a System map for the build kernel."
    err "                     By default will look in KPATH and /boot"
    err "  -q              -- Quieten the checks"
    err "  -v              -- Verbose output"
    err "  <symbol>        -- Symbol to evaluate."
    err "                     By default every symbol is evaluated"

}

######################################################################
# Symbol definition map

function generate_kompat_symbols() {
    echo "
EFX_NEED_ETHTOOL_OFFLOAD_SANITY_CHECKS	kver	<	2.6.10
EFX_HAVE_MSIX_TABLE_RESERVED		kver	<	2.6.12
EFX_USE_ETHTOOL_OP_GET_TX_CSUM		kver	>=	2.6.12
EFX_NEED_UNREGISTER_NETDEVICE_NOTIFIER_FIX	kver	<	2.6.17
EFX_HAVE_COMPOUND_PAGES			kver	>=	2.6.15
EFX_HAVE_NONCONST_ETHTOOL_OPS		kver	<	2.6.19
EFX_USE_GSO_SIZE_FOR_MSS		kver	>=	2.6.19
EFX_USE_FASTCALL			kver	<	2.6.20
EFX_USE_VLAN_RX_KILL_VID		kver	<	2.6.22
EFX_NEED_BONDING_HACKS			kver	<	2.6.24
EFX_NEED_DEV_CLOSE_HACK			kver	<	2.6.25
EFX_NEED_PCI_VPD_ATTR			kver	<	2.6.26
EFX_NEED_LM87_DRIVER			kver	<	2.6.28
EFX_NEED_LM90_DRIVER			kver	<	2.6.28
EFX_USE_NET_DEVICE_LAST_RX		kver	<	2.6.29
EFX_USE_NET_DEVICE_TRANS_START		kver	<	2.6.31
EFX_USE_PRINT_MAC			kver	<	2.6.31
EFX_HAVE_PARAM_BOOL_INT			kver	<	2.6.31
EFX_HAVE_MTD_TABLE			kver	<	2.6.35
EFX_HAVE_VMALLOC_REG_DUMP_BUF		kver	>=	2.6.37
EFX_USE_ETHTOOL_OP_GET_LINK		kver	>=	2.6.38
EFX_HAVE_OLD_NAPI			nsymbol napi_schedule		include/linux/netdevice.h
EFX_HAVE_OLD_CSUM			nsymbol __sum16			include/linux/types.h
EFX_HAVE_OLD_IP_FAST_CSUM		custom
EFX_NEED_BYTEORDER_TYPES		nsymbol	__be32			include/linux/types.h
EFX_NEED_CSUM_UNFOLDED			nsymbol csum_unfold		include/net/checksum.h
EFX_NEED_CSUM_TCPUDP_NOFOLD		custom
EFX_NEED_DEV_NOTICE			nsymbol	dev_notice		include/linux/device.h
EFX_NEED_DUMMY_PCI_DISABLE_MSI		nexport	pci_disable_msi		include/linux/pci.h	drivers/pci/msi.c
EFX_NEED_DUMMY_MSIX			nsymbol msix_entry		include/linux/pci.h
EFX_NEED_ENABLE_MSIX			nexport	pci_enable_msix		include/linux/pci.h	drivers/pci/msi.c
EFX_HAVE_GRO				custom
EFX_NEED_GRO_RESULT_T			nsymbol	gro_result_t		include/linux/netdevice.h
EFX_HAVE_NAPI_GRO_RECEIVE_GR		symbol	napi_gro_receive_gr	include/linux/netdevice.h
EFX_NEED_GFP_T				custom
EFX_NEED_HEX_DUMP			nexport	print_hex_dump		include/linux/kernel.h include/linux/printk.h lib/hexdump.c
EFX_NEED_HEX_DUMP_CONST_FIX 		symtype	print_hex_dump		include/linux/kernel.h void(const char *, const char *, int, int, int, void *, size_t, bool)
EFX_NEED_IF_MII				nsymbol	if_mii			include/linux/mii.h
EFX_HAVE_IRQ_HANDLER_REGS		symbol	pt_regs			include/linux/interrupt.h
EFX_NEED_IRQ_HANDLER_T			nsymbol	irq_handler_t		include/linux/interrupt.h
EFX_NEED_KCALLOC			nsymbol	kcalloc			include/linux/slab.h
EFX_NEED_KZALLOC			nsymbol	kzalloc			include/linux/slab.h
EFX_NEED_VZALLOC			nsymbol	vzalloc			include/linux/vmalloc.h
EFX_NEED_MII_CONSTANTS			nsymbol	LPA_1000FULL		include/linux/mii.h
EFX_NEED_MII_ADVERTISE_FLOWCTRL		nsymbol	mii_advertise_flowctrl	include/linux/mii.h
EFX_NEED_MII_RESOLVE_FLOWCTRL_FDX	nsymbol	mii_resolve_flowctrl_fdx include/linux/mii.h
EFX_HAVE_LINUX_MDIO_H			file				include/linux/mdio.h
EFX_NEED_MSECS_TO_JIFFIES		custom
EFX_NEED_MDELAY				custom
EFX_NEED_MSLEEP				nexport	msleep			include/linux/delay.h	kernel/timer.c
EFX_NEED_SSLEEP				nsymbol	ssleep			include/linux/delay.h
EFX_NEED_MTD_DEVICE_REGISTER		nsymbol	mtd_device_register	include/linux/mtd/mtd.h
EFX_NEED_MTD_ERASE_CALLBACK		nsymbol	mtd_erase_callback	include/linux/mtd/mtd.h
EFX_NEED_MUTEX				nsymbol	mutex_is_locked		include/linux/mutex.h
EFX_NEED_NETDEV_ALLOC_SKB		nsymbol	netdev_alloc_skb	include/linux/skbuff.h
EFX_NEED_SKB_COPY_FROM_LINEAR_DATA	nsymbol skb_copy_from_linear_data	include/linux/skbuff.h
EFX_NEED___SKB_QUEUE_HEAD_INIT		nsymbol __skb_queue_head_init	include/linux/skbuff.h
EFX_NEED_NETDEV_TX_T			nsymbol	netdev_tx_t		include/linux/netdevice.h
EFX_NEED_NETIF_NAPI_DEL			nsymbol	netif_napi_del		include/linux/netdevice.h
EFX_NEED_NETIF_TX_LOCK			nsymbol	netif_tx_lock		include/linux/netdevice.h
EFX_NEED_NETIF_ADDR_LOCK		nsymbol	netif_addr_lock		include/linux/netdevice.h
EFX_NEED_ALLOC_ETHERDEV_MQ		nsymbol	alloc_etherdev_mq	include/linux/etherdevice.h
EFX_NEED_TX_MQ_API			nsymbol	__netif_tx_unlock	include/linux/netdevice.h
EFX_USE_TX_MQ				symbol	real_num_tx_queues	include/linux/netdevice.h
EFX_HAVE___NETIF_TX_LOCK_1PARAM		symtype	__netif_tx_lock		include/linux/netdevice.h void(struct netdev_queue *)
EFX_NEED_NETIF_SET_REAL_NUM_TX_QUEUES	nsymbol	netif_set_real_num_tx_queues include/linux/netdevice.h
EFX_NEED_NETIF_SET_REAL_NUM_RX_QUEUES	nsymbol	netif_set_real_num_rx_queues include/linux/netdevice.h
EFX_NEED_PCI_CLEAR_MASTER		nsymbol	pci_clear_master	include/linux/pci.h
EFX_NEED_PCI_MATCH_ID			nsymbol pci_match_id		include/linux/pci.h
EFX_NEED_PCI_SAVE_RESTORE_WRAPPERS	symtype	pci_save_state		include/linux/pci.h int(struct pci_dev *, u32 *)
EFX_NEED_PRINT_MAC			nsymbol print_mac		include/linux/if_ether.h
EFX_NEED_RANDOM_ETHER_ADDR		nsymbol	random_ether_addr	include/linux/etherdevice.h
EFX_NEED_RESOURCE_SIZE_T		nsymbol resource_size_t		include/linux/types.h
EFX_NEED_RTNL_TRYLOCK			nsymbol	rtnl_trylock		include/linux/rtnetlink.h
EFX_HAVE_ROUND_JIFFIES_UP		symbol	round_jiffies_up	include/linux/timer.h
EFX_NEED_SAFE_LISTS			nsymbol	list_for_each_entry_safe_reverse	include/linux/list.h
EFX_NEED_SCHEDULE_TIMEOUT_INTERRUPTIBLE	nexport	schedule_timeout_interruptible		include/linux/sched.h	kernel/timer.c
EFX_NEED_SCHEDULE_TIMEOUT_UNINTERRUPTIBLE	nexport	schedule_timeout_uninterruptible	include/linux/sched.h	kernel/timer.c
EFX_NEED_SETUP_TIMER			nsymbol setup_timer		include/linux/timer.h
EFX_NEED_SKB_HEADER_MACROS		nsymbol	skb_mac_header		include/linux/skbuff.h
EFX_NEED_SKB_CHECKSUM_START_OFFSET	nsymbol	skb_checksum_start_offset	include/linux/skbuff.h
EFX_HAVE_CSUM_START			symbol	csum_start		include/linux/skbuff.h
EFX_HAVE_SKB_SET_TRANSPORT_HEADER	symbol	skb_set_transport_header	include/linux/skbuff.h
EFX_HAVE_OLD_SKB_LINEARIZE		nsymtype skb_linearize		include/linux/skbuff.h int(struct sk_buff *)
EFX_HAVE_SKBTX_HW_TSTAMP		symbol	SKBTX_HW_TSTAMP		include/linux/skbuff.h
EFX_NEED_ETH_HDR			nsymbol	eth_hdr			include/linux/if_ether.h
EFX_NEED_VLAN_ETH_HDR			nsymbol	vlan_eth_hdr		include/linux/if_vlan.h
EFX_NEED_TCP_HDR			nsymbol	tcp_hdr			include/linux/tcp.h
EFX_NEED_UDP_HDR			nsymbol	udp_hdr			include/linux/udp.h
EFX_NEED_IP_HDR				nsymbol	ip_hdr			include/linux/ip.h
EFX_NEED_IPV6_HDR			nsymbol	ipv6_hdr		include/linux/ipv6.h
EFX_NEED_WORK_API_WRAPPERS		nmember	struct_delayed_work	timer	include/linux/workqueue.h
EFX_USE_CANCEL_DELAYED_WORK_SYNC	symbol	cancel_delayed_work_sync		include/linux/workqueue.h
EFX_USE_CANCEL_WORK_SYNC		symbol	cancel_work_sync	include/linux/workqueue.h
EFX_USE_ETHTOOL_ETH_TP_MDIX		symbol	eth_tp_mdix		include/linux/ethtool.h
EFX_USE_ETHTOOL_GET_PERM_ADDR		symbol	get_perm_addr		include/linux/ethtool.h
EFX_USE_ETHTOOL_FLAGS			symbol	get_flags		include/linux/ethtool.h
EFX_USE_ETHTOOL_LP_ADVERTISING		symbol	lp_advertising		include/linux/ethtool.h
EFX_USE_ETHTOOL_MDIO_SUPPORT		symbol	mdio_support		include/linux/ethtool.h
EFX_USE_LINUX_IO_H			file				include/linux/io.h
EFX_NEED_MMIOWB				custom
EFX_USE_LINUX_UACCESS_H			file				include/linux/uaccess.h
EFX_USE_MTD_ERASE_FAIL_ADDR		symbol	fail_addr		include/linux/mtd/mtd.h
EFX_USE_MTD_WRITESIZE			symbol	writesize		include/linux/mtd/mtd.h
EFX_USE_NETDEV_DEV			member	struct_net_device	dev	include/linux/netdevice.h
EFX_USE_NETDEV_DEV_ID			member	struct_net_device	dev_id	include/linux/netdevice.h
EFX_USE_NETDEV_STATS			custom
EFX_USE_NETDEV_STATS64			member	struct_net_device_ops	ndo_get_stats64 include/linux/netdevice.h
EFX_USE_PCI_DEV_REVISION		symbol	revision		include/linux/pci.h
EFX_USE_NETDEV_VLAN_FEATURES		symbol	vlan_features		include/linux/netdevice.h
EFX_USE_NETDEV_PERM_ADDR		symbol	perm_addr		include/linux/netdevice.h
EFX_USE_DEV_MC_LIST			memtype	struct_net_device	mc_list	include/linux/netdevice.h	struct dev_mc_list *
EFX_HAVE_OLD_SKB_CHECKSUM_HELP		symtype	skb_checksum_help	include/linux/netdevice.h int(struct sk_buff *, int)
EFX_HAVE_OLDER_SKB_CHECKSUM_HELP	symtype	skb_checksum_help	include/linux/netdevice.h int(struct sk_buff **, int)
EFX_USE_I2C_LEGACY			custom
EFX_NEED_I2C_NEW_DUMMY			nsymbol	i2c_new_dummy		include/linux/i2c.h
EFX_HAVE_OLD_I2C_DRIVER_PROBE		custom
EFX_HAVE_OLD_I2C_NEW_DUMMY		symtype	i2c_new_dummy		include/linux/i2c.h struct i2c_client *(struct i2c_adapter *, u16, const char *)
EFX_USE_I2C_DRIVER_NAME			custom
EFX_HAVE_HWMON_H			file				include/linux/hwmon.h
EFX_NEED_HWMON_VID			nfile				include/linux/hwmon-vid.h
EFX_HAVE_I2C_SENSOR_H			file    			include/linux/i2c-sensor.h
EFX_HAVE_HWMON_CLASS_DEVICE		symtype	hwmon_device_register	include/linux/hwmon.h struct class_device *(struct device *)
EFX_HAVE_OLD_DEVICE_ATTRIBUTE		custom
EFX_HAVE_BIN_ATTRIBUTE_OP_ATTR_PARAM	custom
EFX_HAVE_BIN_ATTRIBUTE_OP_FILE_PARAM	custom
EFX_NEED_BOOL				nsymbol	bool			include/linux/types.h
EFX_USE_ETHTOOL_GET_SSET_COUNT		symbol	get_sset_count		include/linux/ethtool.h
EFX_HAVE_ETHTOOL_RESET			member  struct_ethtool_ops	reset	include/linux/ethtool.h
EFX_HAVE_ETHTOOL_SET_PHYS_ID		symbol	set_phys_id		include/linux/ethtool.h
EFX_NEED_ETHTOOL_CMD_SPEED		nsymbol	ethtool_cmd_speed	include/linux/ethtool.h
EFX_NEED_I2C_LOCK_ADAPTER		nsymbol	i2c_lock_adapter	include/linux/i2c.h
EFX_USE_I2C_BUS_SEMAPHORE		custom
EFX_HAVE_OLD_PCI_DMA_MAPPING_ERROR	custom
EFX_HAVE_LINUX_SEMAPHORE_H		file				include/linux/semaphore.h
EFX_NEED_DEV_GET_STATS			nsymbol	dev_get_stats		include/linux/netdevice.h
EFX_HAVE_OLD_CPUMASK_SCNPRINTF		nsymtype cpumask_scnprintf	include/linux/cpumask.h int(char *, int, const struct cpumask *)
EFX_NEED_NEW_CPUMASK_API		nsymbol	cpumask_var_t		include/linux/cpumask.h
EFX_NEED_ZALLOC_CPUMASK_VAR		nsymbol zalloc_cpumask_var	include/linux/cpumask.h
EFX_USE_PM				symbol	PM_EVENT_SUSPEND	include/linux/pm.h
EFX_USE_PM_EXT_OPS			symbol	pm_ext_ops		include/linux/pm.h
EFX_USE_DEV_PM_OPS			symbol	dev_pm_ops		include/linux/pm.h
EFX_NEED_ATOMIC_CMPXCHG			custom
EFX_NEED_WARN_ON			custom
EFX_NEED_WAIT_EVENT_TIMEOUT		nsymbol wait_event_timeout	include/linux/wait.h
EFX_NEED_ETHTOOL_CONSTANTS		nsymbol	ADVERTISED_Pause	include/linux/ethtool.h
EFX_NEED_PCI_WAKE_FROM_D3		nsymbol pci_wake_from_d3        include/linux/pci.h
EFX_HAVE_DEV_DISABLE_LRO		export	dev_disable_lro		include/linux/netdevice.h	net/core/dev.c
EFX_NEED_UNMASK_MSIX_VECTORS		nsymbol	masked			include/linux/msi.h
EFX_HAVE_PM_IDLE			export	pm_idle			include/linux/pm.h arch/$SRCARCH/kernel/process.c
EFX_HAVE_SKB_RECORD_RX_QUEUE		symbol	skb_record_rx_queue	include/linux/skbuff.h
EFX_HAVE_XEN_XEN_H			file				include/xen/xen.h
EFX_HAVE_XEN_START_INFO			custom
EFX_HAVE_CPUMASK_OF_NODE		symbol	cpumask_of_node		include/asm/topology.h	arch/$SRCARCH/include/asm/topology.h
EFX_NEED_SET_CPUS_ALLOWED_PTR		nexport set_cpus_allowed_ptr	include/linux/sched.h		kernel/sched.c
EFX_NEED_ON_EACH_CPU_WRAPPER 		custom
EFX_HAVE_EXPORTED_CPU_SIBLING_MAP	export	(per_cpu__)?cpu_sibling_map	include/asm/smp.h	arch/$SRCARCH/include/asm/smp.h	arch/$SRCARCH/kernel/smpboot.c	drivers/xen/core/smpboot.c
EFX_HAVE_ROUNDDOWN_POW_OF_TWO		symbol	rounddown_pow_of_two	include/linux/log2.h include/linux/kernel.h
EFX_HAVE_ROUNDUP_POW_OF_TWO		symbol	roundup_pow_of_two	include/linux/log2.h include/linux/kernel.h
EFX_HAVE_SRIOV				export	pci_enable_sriov	include/linux/pci.h	drivers/pci/iov.c
EFX_HAVE_NET_DEVICE_OPS			symbol	net_device_ops		include/linux/netdevice.h
EFX_HAVE_NDO_SET_VF_MAC 		symbol	ndo_set_vf_mac		include/linux/netdevice.h
EFX_HAVE_NDO_SET_FEATURES		symbol	ndo_set_features	include/linux/netdevice.h
EFX_NEED_IS_ZERO_ETHER_ADDR		nsymbol	is_zero_ether_addr	include/linux/etherdevice.h
EFX_NEED_IS_BROADCAST_ETHER_ADDR	nsymbol	is_broadcast_ether_addr	include/linux/etherdevice.h
EFX_NEED_IS_MULTICAST_ETHER_ADDR	nsymbol	is_multicast_ether_addr	include/linux/etherdevice.h
EFX_NEED_COMPARE_ETHER_ADDR		nsymbol	compare_ether_addr	include/linux/etherdevice.h
EFX_HAVE_LIST_SPLICE_TAIL_INIT		symbol	list_splice_tail_init	include/linux/list.h
EFX_NEED_LIST_FIRST_ENTRY		nsymbol	list_first_entry	include/linux/list.h
EFX_NEED_TIMESPEC_ADD_NS		nsymbol	timespec_add_ns		include/linux/time.h
EFX_NEED_TIMESPEC_SUB			nsymbol	timespec_sub		include/linux/time.h
EFX_NEED_TIMESPEC_COMPARE		nsymbol	timespec_compare	include/linux/time.h
EFX_NEED_NS_TO_TIMESPEC			nexport ns_to_timespec		include/linux/time.h	kernel/time.c
EFX_NEED_SET_NORMALIZED_TIMESPEC	custom
EFX_HAVE_PROCFS_DELETED			symbol	deleted			include/linux/proc_fs.h
EFX_HAVE_VLAN_RX_PATH			symbol	vlan_hwaccel_receive_skb include/linux/if_vlan.h
EFX_HAVE_NDO_SET_MULTICAST_LIST		symbol	ndo_set_multicast_list	include/linux/netdevice.h
EFX_HAVE_OLD_ETHTOOL_GET_RXNFC		memtype	struct_ethtool_ops	get_rxnfc	include/linux/ethtool.h int (*)(struct net_device *, struct ethtool_rxnfc *, void *)
EFX_HAVE_CPU_RMAP			file				include/linux/cpu_rmap.h
EFX_NEED_KTIME				nfile				include/linux/ktime.h
EFX_HAVE_NET_TSTAMP			file				include/linux/net_tstamp.h
EFX_HAVE_DIV_S64_REM			symbol	div_s64_rem		include/linux/math64.h
EFX_NEED_NETDEV_FEATURES_T		nsymbol	netdev_features_t	include/linux/netdevice.h
EFX_NEED_SKB_FILL_PAGE_DESC		nsymbol	skb_fill_page_desc	include/linux/skbuff.h
EFX_NEED_SKB_FRAG_DMA_MAP		nsymbol	skb_frag_dma_map	include/linux/skbuff.h
EFX_HAVE_OLD_ETHTOOL_RXFH_INDIR		custom
EFX_NEED_ETHTOOL_RXFH_INDIR_DEFAULT	nsymbol	ethtool_rxfh_indir_default	include/linux/ethtool.h
EFX_NEED_IS_COMPAT_TASK			custom
EFX_NEED_COMPAT_U64			nsymbol	compat_u64		include/asm/compat.h arch/$SRCARCH/include/asm/compat.h include/asm-$SRCARCH/compat.h
EFX_USE_IRQ_SET_AFFINITY_HINT		symbol	irq_set_affinity_hint	include/linux/interrupt.h

# Stuff needed in code other than the linux net driver
EFX_NEED_FOR_EACH_PCI_DEV		nsymbol for_each_pci_dev	include/linux/pci.h
EFX_NEED_SCSI_SGLIST			nsymbol scsi_sglist		include/scsi/scsi_cmnd.h
EFX_NEED_SG_NEXT			nsymbol sg_next			include/linux/scatterlist.h
EFX_HAVE_NEW_KFIFO			symbol kfifo_out		include/linux/kfifo.h
EFX_NEED_VMALLOC_NODE			nsymbol vmalloc_node		include/linux/vmalloc.h
EFX_NEED_VMALLOC_TO_PFN			nsymbol vmalloc_to_pfn		include/linux/mm.h
EFX_NEED_KVEC				nsymbol	kvec			include/linux/uio.h
EFX_NEED_KERNEL_SENDMSG			nsymbol kernel_sendmsg		include/linux/net.h
EFX_HAVE_NETFILTER_INDIRECT_SKB		memtype	struct_nf_hook_ops	hook	include/linux/netfilter.h	unsigned int(*)(unsigned int, struct sk_buff **, const struct net_device *, const struct net_device *, int (*)(struct sk_buff *))
EFX_HAVE_NFPROTO_CONSTANTS		symbol	NFPROTO_NUMPROTO	include/linux/netfilter.h
EFX_HAVE_FDTABLE			symbol	files_fdtable		include/linux/file.h include/linux/fdtable.h
EFX_HAVE_REMAP_PFN_RANGE		symbol	remap_pfn_range		include/linux/mm.h
EFX_HAVE_GETNSTIMEOFDAY			export	getnstimeofday		include/linux/time.h
EFX_NEED_PCI_READ_VPD			nsymbol pci_read_vpd		include/linux/pci.h
EFX_NEED_PCI_VPD_LRDT			nsymbol PCI_VPD_LRDT		include/linux/pci.h
EFX_HAVE_KERN_UMOUNT			symbol	kern_unmount		include/linux/fs.h
EFX_HAVE_D_DNAME			member	struct_dentry_operations d_dname	include/linux/dcache.h
EFX_HAVE_STRUCT_PATH			symtype	alloc_file		include/linux/file.h struct file *(struct path *, fmode_t, const struct file_operations *)
EFX_HAVE_CONST_D_OP			memtype	struct_dentry_operations d_op	include/linux/dcache.h	const struct dentry_operations *
EFX_FSTYPE_HAS_MOUNT			member	struct_file_system_type	mount	include/linux/fs.h
EFX_NEED_VFSMOUNT_PARAM_IN_GET_SB	memtype	struct_file_system_type	get_sb	include/linux/fs.h	int (*)(struct file_system_type *, int, const char *, void *, struct vfsmount *)
EFX_HAVE_KMEM_CACHE_S			symtype	kmem_cache_create	include/linux/slab.h struct kmem_cache_s *(const char *, size_t, size_t, unsigned long, void (*ctor)(void*, struct kmem_cache_s *, unsigned long), void (*dtor)(void*, kmem_cache_t *, unsigned long))
EFX_HAVE_KMEM_CACHE_DTOR		symtype	kmem_cache_create	include/linux/slab.h struct kmem_cache *(const char *, size_t, size_t, unsigned long, void (*ctor)(void*, struct kmem_cache *, unsigned long), void (*dtor)(void*, struct kmem_cache *, unsigned long))
EFX_HAVE_KMEM_CACHE_FLAGS		symtype	kmem_cache_create	include/linux/slab.h struct kmem_cache *(const char *, size_t, size_t, unsigned long, void (*ctor)(void*, struct kmem_cache *, unsigned long))
EFX_HAVE_KMEM_CACHE_CACHEP		symtype	kmem_cache_create	include/linux/slab.h struct kmem_cache *(const char *, size_t, size_t, unsigned long, void (*ctor)(struct kmem_cache *, void*))
EFX_HAVE_ALLOC_FILE			symbol	alloc_file	include/linux/file.h
" | egrep -v -e '^#' -e '^$' | sed 's/[ \t][ \t]*/:/g'
}

######################################################################
# Generic methods for standard symbol types

# Look for up to 3 numeric components separated by dots and stop when
# we find anything that doesn't match this.  Convert to a number like
# the LINUX_VERSION_CODE macro does.
function string_to_version_code
{
    local ver="$1"
    local code=0
    local place=65536
    local num

    while [ -n "$ver" ]; do
	# Look for numeric component; if none found then we're done;
	# otherwise add to the code
	num=${ver%%[^0-9]*}
	test -n "$num" || break
	code=$((code + $num * $place))

	# If this was the last component (place value = 1) then we're done;
	# otherwise update place value
	test $place -gt 1 || break
	place=$((place / 256))

	# Move past numeric component and following dot (if present)
	ver=${ver#$num}
	ver=${ver#.}
    done

    echo $code
}

# Test cases for string_to_version_code:
# test $(string_to_version_code 1.2.3) = $((1 * 65536 + 2 * 256 + 3))
# test $(string_to_version_code 12.34.56) = $((12 * 65536 + 34 * 256 + 56))
# test $(string_to_version_code 12.34.56foo) = $((12 * 65536 + 34 * 256 + 56))
# test $(string_to_version_code 12.34.56.78) = $((12 * 65536 + 34 * 256 + 56))
# test $(string_to_version_code 12.34.56.foo) = $((12 * 65536 + 34 * 256 + 56))
# test $(string_to_version_code 12.34.56-foo) = $((12 * 65536 + 34 * 256 + 56))
# test $(string_to_version_code 12.34) = $((12 * 65536 + 34 * 256))
# test $(string_to_version_code 12.34.0) = $((12 * 65536 + 34 * 256))
# test $(string_to_version_code 12.34foo) = $((12 * 65536 + 34 * 256))
# test $(string_to_version_code 12.34-56) = $((12 * 65536 + 34 * 256))
# test $(string_to_version_code 12.34.foo) = $((12 * 65536 + 34 * 256))
# test $(string_to_version_code 12.34-foo) = $((12 * 65536 + 34 * 256))

function do_kver()
{
    shift 2;
    local op="$1"
    local right_ver="$2"

    local left=$(string_to_version_code "$KVER")
    local right=$(string_to_version_code "$right_ver")

    local result=$((1 - ($left $op $right)))
    local msg="$KVER $op $right_ver == $left $op $right == "
    if [ $result = 0 ]; then
	msg="$msg true"
    else
	msg="$msg false"
    fi
    vmsg "$msg"
    return $result
}

function do_symbol()  { shift 2; test_symbol "$@"; }
function do_nsymbol() { shift 2; ! test_symbol "$@"; }
function do_symtype() { shift 2; defer_test_symtype pos "$@"; }
function do_nsymtype() { shift 2; defer_test_symtype neg "$@"; }
function do_member() { shift 2; defer_test_memtype pos "$@" void; }
function do_nmember() { shift 2; defer_test_memtype neg "$@" void; }
function do_memtype() { shift 2; defer_test_memtype pos "$@"; }
function do_nmemtype() { shift 2; defer_test_memtype neg "$@"; }
function do_export()
{
    local sym=$3
    shift 3

    # Only scan header files for the symbol
    test_symbol $sym $(echo "$@" | sed -r 's/ [^ ]+\.c/ /g') || return
    test_export $sym "$@"
}
function do_nexport() { ! do_export "$@"; }
function do_file()    { test -f $KBUILD_SRC/$3; }
function do_nfile()   { ! test -f $KBUILD_SRC/$3; }

function do_custom()  { do_$1; }

######################################################################
# Implementation of kernel feature checking

# Special return value for deferred test
DEFERRED=42

function atexit_cleanup()
{
  rc=$?
  [ -n "$rmfiles" ] && rm -rf $rmfiles
  return $rc
}

function strip_comments()
{
    local file=$1

    cat $1 | sed -e '
/\/\*/!b
:a
/\*\//!{
N
ba
}
s:/\*.*\*/::'
}

function test_symbol()
{
    local symbol=$1
    shift
    local file

    for file in "$@"; do
        # For speed, lets just grep through the file. The symbol may
        # be of any of these forms:
        #     #define SYMBOL
        #     typedef void (SYMBOL)(void)
        #     extern void SYMBOL(void)
        #     void (*SYMBOL)(void)
        #     enum { SYMBOL, } void
        #
        if [ $verbose = true ]; then
            echo >&2 "Looking for '$symbol' in '$KBUILD_SRC/$file'"
        fi
        [ -f "$KBUILD_SRC/$file" ] &&  \
            strip_comments $KBUILD_SRC/$file | \
            egrep -w "$symbol" >/dev/null && \
            return 0
    done
    return 1
}

function defer_test_symtype()
{
    local sense=$1
    local symbol=$2
    local file=$3
    shift 3
    local type="$*"

    if [ ${file:0:8} != "include/" ]; then
	fail "defer_test_symtype() can work in include/ - request was '$file'"
    fi

    defer_test_compile $sense "
#include <${file:8}>
__typeof($type) *kernel_compat_dummy = &$symbol;
"
}

function defer_test_memtype()
{
    local sense=$1
    local aggtype="${2/_/ }"
    local memname=$3
    local file=$4
    shift 4
    local memtype="$*"

    if [ ${file:0:8} != "include/" ]; then
	fail "defer_test_symtype() can work in include/ - request was '$file'"
    fi

    defer_test_compile $sense "
#include <${file:8}>
$aggtype kernel_compat_dummy_1;
__typeof($memtype) *kernel_compat_dummy_2 = &kernel_compat_dummy_1.$memname;
"
}

function test_inline_symbol()
{
    local symbol=$1
    local file=$2
    local t=$(mktemp)
    rmfiles="$rmfiles $t"

    [ -f "$KBUILD_SRC/$file" ] || return

    # TODO: This isn't very satisfactory. Alternative options are:
    #   1. Come up with a clever sed version
    #   2. Do a test compile, and look for an undefined symbol (extern)

    # look for the inline..symbol. This is complicated since the inline
    # and the symbol may be on different lines.
    strip_comments $KBUILD_SRC/$file | \
	egrep -m 1 -B 1 '(^|[,\* \(])'"$symbol"'($|[,; \(\)])' > $t
    [ $? = 0 ] || return $?
        
    # there is either an inline on the final line, or an inline and
    # no semicolon on the previous line
    head -1 $t | egrep -q 'inline[^;]*$' && return
    tail -1 $t | egrep -q 'inline' && return

    return 1
}

function test_export()
{
    local symbol=$1
    shift
    local files="$@"
    local file match

    # Looks for the given export symbol $symbol, defined in $file
    # Since this symbol is exported, we can look for it in:
    #     1. $KPATH/Module.symvers
    #     2. If the full source is installed, look in there.
    #        May give a false positive if the export is conditional.
    #     3. The MAP file if present. May give a false positive
    #        because it lists all extern (not only exported) symbols.
    if [ -f $KPATH/Module.symvers ]; then
        if [ $verbose = true ]; then
            echo >&2 "Looking for export of $symbol in $KPATH/Module.symvers"
	fi
	[ -n "$(awk '/0x[0-9a-f]+[\t ]+'$symbol'[\t ]+/' $KPATH/Module.symvers)" ]
    else
	for file in $files; do
            if [ $verbose = true ]; then
		echo >&2 "Looking for export of $symbol in $KBUILD_SRC/$file"
            fi
            if [ -f $KBUILD_SRC/$file ]; then
		egrep -q 'EXPORT_(PER_CPU)?SYMBOL(_GPL)?\('"$symbol"'\)' $KBUILD_SRC/$file && return
            fi
	done
	if [ -n "$MAP" ]; then
            if [ $verbose = true ]; then
		echo >&2 "Looking for export of $symbol in $MAP"
            fi
	    egrep -q "[A-Z] $symbol\$" $MAP && return
	fi
	return 1
    fi
}

function test_compile()
{
    local source="$1"
    local rc
    local dir=$(mktemp -d)
    echo "$source" > $dir/test.c
    cat > $dir/Makefile <<EOF
$makefile_prefix
obj-m := test.o
EOF
    make -C $KPATH $EXTRA_MAKEFLAGS M=$dir >$dir/log 2>&1
    rc=$?

    if [ $verbose = true ]; then
	echo >&2 "tried to compile:"
	sed >&2 's/^/    /' $dir/test.c
	echo >&2 "compiler output:"
	sed >&2 's/^/    /' $dir/log
    fi

    rm -rf $dir
    return $rc
}

function defer_test_compile()
{
    local sense=$1
    local source="$2"
    echo "$source" > "$compile_dir/test_$key.c"
    echo "obj-m += test_$key.o" >> "$compile_dir/Makefile"
    eval deferred_$sense=\"\$deferred_$sense $key\"
    return $DEFERRED
}

function read_make_variables()
{
    local regexp=''
    local split='('
    local variable
    local variables="$@"
    local dir=$(mktemp -d)

    for variable in $variables; do
	echo "\$(warning $variable=\$($variable))" >> $dir/Makefile
	regexp=$regexp$split$variable
	split='|'
    done
    make -C $KPATH $EXTRA_MAKEFLAGS M=$dir 2>&1 >/dev/null | sed -r "s#$dir/Makefile:.*: ($regexp)=.*$)#\1#; t; d"
    rc=$?

    rm -rf $dir
    return $rc
}

function read_define()
{
    local variable="$1"
    local file="$2"
    cat $KPATH/$2 | sed -r 's/#define '"$variable"' (.*)/\1/; t; d'
}

######################################################################
# Implementation for more tricky types

function do_EFX_HAVE_OLD_IP_FAST_CSUM()
{
    # ip_fast_csum takes (unsigned char*) in older kernels
    local source="
#include <asm/checksum.h>
void test(const void *iph) { ip_fast_csum(iph, 20); }"
    defer_test_compile neg "$source"
}

function do_EFX_NEED_CSUM_TCPUDP_NOFOLD()
{
    # csum_tcpudp_nofold is defined in archicture specific code, and
    # is either inline in include/asm/checksum.h, or exported in
    # arch/ARCH/lib/checksum.c.
    local s=csum_tcpudp_nofold
    ! test_inline_symbol $s include/asm-$SRCARCH/checksum.h && \
	! test_inline_symbol $s include/asm-$SRCARCH/checksum$WORDSUFFIX.h && \
	! test_inline_symbol $s arch/$SRCARCH/include/asm/checksum.h && \
	! test_inline_symbol $s arch/$SRCARCH/include/asm/checksum$WORDSUFFIX.h && \
	! test_export $s arch/$SRCARCH/lib/checksum.c && \
	! test_export $s arch/$SRCARCH/lib/checksum$WORDSUFFIX.c
}

function do_EFX_NEED_MDELAY()
{
    # rhel4 buggered up mdelay with -Werror builds
    local source="
#include <linux/delay.h>
void test(void) { mdelay(100); }"
    defer_test_compile neg "$source"
}

function do_EFX_NEED_MSECS_TO_JIFFIES()
{
    # inline up to 2.6.20, then became extern
    local s=msecs_to_jiffies

    ! test_inline_symbol $s include/linux/jiffies.h && \
	! test_inline_symbol $s include/linux/time.h && \
	! test_export $s kernel/time.c
}

function do_EFX_NEED_GFP_T()
{
    ! test_symbol gfp_t include/linux/types.h && \
	! test_symbol gfp_t include/linux/gfp.h
}

function do_EFX_USE_NETDEV_STATS()
{
    local source="
#include <linux/netdevice.h>
struct net_device_stats *stats;
void test(struct net_device *net_dev) { stats = &net_dev->stats; }"
    defer_test_compile pos "$source"
}

function do_EFX_USE_I2C_LEGACY()
{
    local source="
#include <linux/i2c.h>
struct i2c_driver d = {
	.probe = 0,
};"
    defer_test_compile neg "$source"
}

function do_EFX_HAVE_OLD_I2C_DRIVER_PROBE()
{
    local source="
#include <linux/i2c.h>
int f(struct i2c_client *);
struct i2c_driver d = {
	.probe = f
};"
    defer_test_compile pos "$source"
}

function do_EFX_USE_I2C_DRIVER_NAME()
{
    local source="
#include <linux/i2c.h>
struct i2c_driver d = {
	.name = \"\"
};"
    defer_test_compile pos "$source"
}

function do_EFX_HAVE_OLD_DEVICE_ATTRIBUTE()
{
    local source="
#include <linux/device.h>
ssize_t f(struct device *, char *);
struct device_attribute d = {
	.show = f
};"
    defer_test_compile pos "$source"
}

function do_EFX_HAVE_BIN_ATTRIBUTE_OP_ATTR_PARAM()
{
    defer_test_compile neg "
#include <linux/list.h>
#include <linux/sysfs.h>
ssize_t f(struct kobject *, char *, loff_t, size_t);
struct bin_attribute attr = { .read = f };
"
}

function do_EFX_HAVE_BIN_ATTRIBUTE_OP_FILE_PARAM()
{
    defer_test_compile pos "
#include <linux/list.h>
#include <linux/sysfs.h>
ssize_t f(struct file *, struct kobject *, struct bin_attribute *,
          char *, loff_t, size_t);
struct bin_attribute attr = { .read = f };
"
}

function do_EFX_USE_I2C_BUS_SEMAPHORE()
{
    defer_test_compile pos "
#include <linux/i2c.h>
struct semaphore *f(struct i2c_adapter *a) { return &a->bus_lock; }
"
}

function do_EFX_HAVE_OLD_PCI_DMA_MAPPING_ERROR()
{
    # We should be able to use symtype for this, but pci_dma_mapping_error
    # used to be defined as a macro on some architectures.
    defer_test_compile pos "
#include <linux/pci.h>
int f(void) { return pci_dma_mapping_error(0); }
"
}

function do_EFX_NEED_ATOMIC_CMPXCHG()
{
    local s=atomic_cmpxchg
    [ -f $KBUILD_SRC/include/asm-$SRCARCH/atomic.h ] &&
        ! test_symbol $s include/asm-$SRCARCH/atomic.h &&
        ! test_symbol $s include/asm-$SRCARCH/atomic$WORDSUFFIX.h
}

function do_EFX_NEED_WARN_ON()
{
    local source="
#include <asm/bug.h>
int f(void) { return WARN_ON(1); }
"
    defer_test_compile neg "$source"
}

function do_EFX_HAVE_XEN_START_INFO()
{
    case $SRCARCH in
	i386 | x86)
	    test_export xen_start_info arch/$SRCARCH/xen/enlighten.c || return
	    ;;
	ia64)
	    test_export xen_start_info arch/ia64/xen/hypervisor.c || return
	    ;;
	*)
	    return 1
	    ;;
    esac

    test_symbol xen_start_info \
	include/asm/xen/hypervisor.h \
	arch/$SRCARCH/include/asm/xen/hypervisor.h
}

function do_EFX_HAVE_EXPORTED_CPU_DATA()
{
    # cpu_data gets exported in lots of places in various kernels
    test_export cpu_data \
        arch/x86_64/kernel/x8664_ksyms.c \
        arch/i386/kernel/i386_ksyms.c \
        arch/$SRCARCH/kernel/smpboot.c \
        drivers/xen/core/smpboot.c && \
	defer_test_symtype pos cpu_data include/asm/processor.h 'struct cpuinfo_x86[]'
}

function do_EFX_NEED_ON_EACH_CPU_WRAPPER()
{
    defer_test_compile pos "
#include <linux/smp.h>
void worker(void *dummy) { }
void test(void) { on_each_cpu(worker, NULL, 0, 0); }
"
}

function do_EFX_NEED_MMIOWB()
{
    local header
    if [ -f "$KBUILD_SRC/include/linux/io.h" ]; then
	header=linux/io.h
    else
	header=asm/io.h
    fi
    defer_test_compile neg "
#include <$header>
void test(void) { mmiowb(); }
"
}

function do_EFX_HAVE_GRO()
{
    # We check symbol types here because in Linux 2.6.29 and 2.6.30
    # napi_gro_frags() took an extra parameter.  We don't bother to
    # support GRO on those versions; no major distribution used them.
    if test_symbol napi_gro_receive_gr include/linux/netdevice.h; then
	true
    elif test_symbol gro_result_t include/linux/netdevice.h; then
	defer_test_symtype pos napi_gro_frags include/linux/netdevice.h "gro_result_t(struct napi_struct *)"
    else
	defer_test_symtype pos napi_gro_frags include/linux/netdevice.h "int(struct napi_struct *)"
    fi
}

function do_EFX_NEED_SET_NORMALIZED_TIMESPEC
{
    ! test_inline_symbol set_normalized_timespec include/linux/time.h && \
	! test_export set_normalized_timespec include/linux/time.h kernel/time.c
}

function do_EFX_HAVE_OLD_ETHTOOL_RXFH_INDIR
{
    test_symbol ETHTOOL_GRXFHINDIR include/linux/ethtool.h && \
	! test_symbol get_rxfh_indir_size include/linux/ethtool.h
}

function do_EFX_NEED_IS_COMPAT_TASK
{
    defer_test_compile neg "
#include <linux/compat.h>
int test(void) { return is_compat_task(); }
"
}

######################################################################
# main()

quiet=false
verbose=false

KVER=
KPATH=
FILTER=
unset ARCH  # avoid exporting ARCH during initial checks
ARCH=
MAP=
EXTRA_MAKEFLAGS=

# These variables from an outer build will interfere with our test builds
unset KBUILD_EXTMOD
unset KBUILD_SRC
unset M
unset TOPDIR

# Filter out make options except for job-server (parallel make)
old_MAKEFLAGS="$MAKEFLAGS"
MAKEFLAGS=
for word in $old_MAKEFLAGS; do
    case "$word" in
	'-j' | '--jobserver='*)
	    export MAKEFLAGS="$MAKEFLAGS $word"
	    ;;
	*)
	    ;;
    esac
done

# Clean-up temporary files when we exit.
rmfiles=
trap atexit_cleanup EXIT

while [ $# -gt 0 ]; do
    case "$1" in
	-r) KVER=$2; shift;;
	-k) KPATH=$2; shift;;
	-q) quiet=true;;
	-m) MAP=$2; shift;;
	-v) verbose=true;;
	-*) usage; exit -1;;
	*)  [ -z $FILTER ] && FILTER=$1 || FILTER="$FILTER|$1";;
	*)  break;
    esac
    shift
done

# resolve KVER and KPATH
[ -z "$KVER" ] && [ -z "$KPATH" ] && KVER=`uname -r`
[ -z "$KPATH" ] && KPATH=/lib/modules/$KVER/build

# Need to set CC explicitly on the kernel make line
# Needs to override top-level kernel Makefile setting
set +u
if [ -n "$CC" ]; then
    EXTRA_MAKEFLAGS="CC=$CC"
fi
set -u

# Select the right warnings - complicated by working out which options work
makefile_prefix='
ifndef try-run
try-run = $(shell set -e;		\
	TMP="$(obj)/.$$$$.tmp";		\
	TMPO="$(obj)/.$$$$.o";		\
	if ($(1)) >/dev/null 2>&1;	\
	then echo "$(2)";		\
	else echo "$(3)";		\
	fi;				\
	rm -f "$$TMP" "$$TMPO")
endif
ifndef cc-disable-warning
cc-disable-warning = $(call try-run,\
	$(CC) $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS) -W$(strip $(1)) -c -xc /dev/null -o "$$TMP",-Wno-$(strip $(1)))
endif
EXTRA_CFLAGS = -Werror $(call cc-disable-warning, unused-but-set-variable)
'

# Ensure it looks like a build tree and we can build a module
[ -d "$KPATH" ] || fail "$KPATH is not a directory"
[ -f "$KPATH/Makefile" ] || fail "$KPATH/Makefile is not present"
test_compile "#include <linux/module.h>" || \
    fail "Kernel build tree is unable to build modules"

# strip the KVER out of UTS_RELEASE, and compare to the specified KVER
_KVER=
for F in include/generated/utsrelease.h include/linux/utsrelease.h include/linux/version.h; do
    [ -f $KPATH/$F ] && _KVER="$(eval echo $(read_define UTS_RELEASE $F))" && break
done
[ -n "$_KVER" ] || fail "Unable to identify kernel version from $KPATH"
if [ -n "$KVER" ]; then
    [ "$KVER" = "$_KVER" ] || fail "$KPATH kernel version $_KVER does not match $KVER"
fi
KVER=$_KVER
unset _KVER

vmsg "KVER       := $KVER"
vmsg "KPATH      := $KPATH"

# Read the following variables from the Makefile:
#     KBUILD_SRC:         Root of source tree (not the same as KPATH under SUSE)
#     ARCH:               Target architecture name
#     SRCARCH:            Target architecture directory name (2.6.24 onward)
#     CONFIG_X86_{32,64}: Work around ARCH = x86 madness
[ -n "$ARCH" ] && export ARCH
eval $(read_make_variables KBUILD_SRC ARCH SRCARCH CONFIG_X86_32 CONFIG_X86_64)

# Define:
#     KBUILD_SRC:         If not already set, same as KPATH
#     SRCARCH:            If not already set, same as ARCH
#     WORDSUFFIX:         Suffix added to some filenames by the i386/amd64 merge
[ -n "$KBUILD_SRC" ] || KBUILD_SRC=$KPATH
[ -n "$SRCARCH" ] || SRCARCH=$ARCH
if [ "$ARCH" = "i386" ] || [ "$CONFIG_X86_32" = "y" ]; then
    WORDSUFFIX=_32
elif [ "$ARCH" = "x86_64" ] || [ "$CONFIG_X86_64" = "y" ]; then
    WORDSUFFIX=_64
else
    WORDSUFFIX=
fi
[ -f "$KBUILD_SRC/arch/$SRCARCH/Makefile" ] || fail "$KBUILD_SRC doesn't directly build $SRCARCH"

vmsg "KBUILD_SRC := $KBUILD_SRC"
vmsg "SRCARCH    := $SRCARCH"
vmsg "WORDSUFFIX := $WORDSUFFIX"

# try and find the System map [used by test_export]
if [ -z "$MAP" ]; then
    if [ -f /boot/System.map-$KVER ]; then
	MAP=/boot/System.map-$KVER
    elif [ $KVER = "`uname -r`" ] && [ -f /proc/kallsyms ]; then
	MAP=/proc/kallsyms
    elif [ -f $KPATH/Module.symvers ]; then
	# can use this to find external symbols only
	true
    else
	vmsg "!!Unable to find a valid System map. Export symbol checks may not work"
    fi
fi

kompat_symbols="$(generate_kompat_symbols)"

# filter the available symbols
if [ -n "$FILTER" ]; then
    kompat_symbols="$(echo "$kompat_symbols" | egrep "^($FILTER):")"
fi

compile_dir="$(mktemp -d)"
rmfiles="$rmfiles $compile_dir"
echo >"$compile_dir/Makefile" "$makefile_prefix"
deferred_pos=
deferred_neg=

function do_one_symbol() {
    local key=$1
    shift
    if "$@"; then
	echo "#define $key yes"
    elif [ $? -ne $DEFERRED ]; then
	echo "// #define $key"
    fi
}

# process each symbol
for symbol in $kompat_symbols; do
    # split symbol at colons; disable globbing (pathname expansion)
    set -o noglob
    IFS=:
    set -- $symbol
    unset IFS
    set +o noglob

    key="$1"
    method="$2"
    do_one_symbol $key do_${method} "$@"
done

# Run the deferred compile tests
make -C $KPATH -k $EXTRA_MAKEFLAGS M="$compile_dir" \
    >"$compile_dir/log" 2>&1 \
    || true
if [ $verbose = true ]; then
    echo >&2 "compiler output:"
    sed >&2 's/^/    /' "$compile_dir/log"
fi
for key in $deferred_pos; do
    do_one_symbol $key test -f "$compile_dir/test_$key.o"
done
for key in $deferred_neg; do
    do_one_symbol $key test ! -f "$compile_dir/test_$key.o"
done
