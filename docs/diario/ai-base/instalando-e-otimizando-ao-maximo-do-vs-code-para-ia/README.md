---
icon: microchip-ai
---

# Instalando e Otimizando ao Máximo do VS CODE para IA

Vou adaptar ao maximo para essa carroça

```
{
"system_info":
{
        "Hostname" : "lenovo",
        "StaticHostname" : "lenovo",
        "PrettyHostname" : null,
        "DefaultHostname" : "localhost",
        "HostnameSource" : "static",
        "IconName" : "computer-laptop",
        "Chassis" : "laptop",
        "Deployment" : null,
        "Location" : null,
        "KernelName" : "Linux",
        "KernelRelease" : "6.1.0-32-amd64",
        "KernelVersion" : "#1 SMP PREEMPT_DYNAMIC Debian 6.1.129-1 (2025-03-06)",
        "OperatingSystemPrettyName" : "Debian GNU/Linux 12 (bookworm)",
        "OperatingSystemCPEName" : null,
        "OperatingSystemHomeURL" : "https://www.debian.org/",
        "HardwareVendor" : "Lenovo",
        "HardwareModel" : "Lenovo IdeaPad S145-15IKB",
        "HardwareSerial" : null,
        "FirmwareVersion" : "CSCN17WW",
        "ProductUUID" : null
}
,
"cpu": {
"Arquitetura": "                            x86_64",
"Modo(s) operacional da CPU": "             32-bit, 64-bit",
"Tamanhos de endereço": "                   39 bits physical, 48 bits virtual",
"Ordem dos bytes": "                        Little Endian",
"CPU(s)": "                                 4",
"Lista de CPU(s) on-line": "                0-3",
"ID de fornecedor": "                       GenuineIntel",
"Nome do modelo": "                         Intel(R) Core(TM) i3-8130U CPU @ 2.20GHz",
"Família da CPU": "                         6",
"Modelo": "                                 142",
"Thread(s) per núcleo": "                   2",
"Núcleo(s) por soquete": "                  2",
"Soquete(s)": "                             1",
"Step": "                                   10",
"CPU(s) scaling MHz": "                     29%",
"CPU MHz máx.": "                           3400,0000",
"CPU MHz mín.": "                           400,0000",
"BogoMIPS": "                               4399,99",
"Opções": "                                 fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 3dnowprefetch cpuid_fault invpcid_single pti ssbd ibrs ibpb stibp tpr_shadow vnmi flexpriority ept vpid ept_ad fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid mpx rdseed adx smap clflushopt intel_pt xsaveopt xsavec xgetbv1 xsaves dtherm ida arat pln pts hwp hwp_notify hwp_act_window hwp_epp md_clear flush_l1d arch_capabilities",
"Virtualização": "                          VT-x",
"cache de L1d": "                           64 KiB (2 instâncias)",
"cache de L1i": "                           64 KiB (2 instâncias)",
"cache de L2": "                            512 KiB (2 instâncias)",
"cache de L3": "                            4 MiB (1 instância)",
"Nó(s) de NUMA": "                          1",
"CPU(s) de nó0 NUMA": "                     0-3",
"Vulnerabilidade Gather data sampling": "   Mitigation; Microcode",
"Vulnerabilidade Itlb multihit": "          KVM",
"Vulnerabilidade L1tf": "                   Mitigation; PTE Inversion; VMX conditional cache flushes, SMT vulnerable",
"Vulnerabilidade Mds": "                    Mitigation; Clear CPU buffers; SMT vulnerable",
"Vulnerabilidade Meltdown": "               Mitigation; PTI",
"Vulnerabilidade Mmio stale data": "        Mitigation; Clear CPU buffers; SMT vulnerable",
"Vulnerabilidade Reg file data sampling": " Not affected",
"Vulnerabilidade Retbleed": "               Mitigation; IBRS",
"Vulnerabilidade Spec rstack overflow": "   Not affected",
"Vulnerabilidade Spec store bypass": "      Mitigation; Speculative Store Bypass disabled via prctl",
"Vulnerabilidade Spectre v1": "             Mitigation; usercopy/swapgs barriers and __user pointer sanitization",
"Vulnerabilidade Spectre v2": "             Mitigation; IBRS; IBPB conditional; STIBP conditional; RSB filling; PBRSB-eIBRS Not affected; BHI Not affected",
"Vulnerabilidade Srbds": "                  Mitigation; Microcode",
"Vulnerabilidade Tsx async abort": "        Not affected"
},
"memory": {
},
"kernel": {
"full": "Linux lenovo 6.1.0-32-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.1.129-1 (2025-03-06) x86_64 GNU/Linux"
},
"filesystems":
{
   "blockdevices": [
      {
         "name": "sda",
         "fstype": null,
         "size": "223,6G",
         "mountpoint": null,
         "label": null,
         "children": [
            {
               "name": "sda1",
               "fstype": "vfat",
               "size": "512M",
               "mountpoint": "/boot/efi",
               "label": "EFI"
            },{
               "name": "sda2",
               "fstype": "ext4",
               "size": "1G",
               "mountpoint": "/boot",
               "label": "BOOT"
            },{
               "name": "sda3",
               "fstype": "btrfs",
               "size": "44,4G",
               "mountpoint": "/",
               "label": "ROOT"
            },{
               "name": "sda4",
               "fstype": "ext4",
               "size": "11,1G",
               "mountpoint": "/var",
               "label": "VAR"
            },{
               "name": "sda5",
               "fstype": "ext4",
               "size": "4,4G",
               "mountpoint": "/tmp",
               "label": "TMP"
            },{
               "name": "sda6",
               "fstype": "ext4",
               "size": "75,5G",
               "mountpoint": "/usr",
               "label": "USR"
            },{
               "name": "sda7",
               "fstype": "swap",
               "size": "11,1G",
               "mountpoint": "[SWAP]",
               "label": "SWAP"
            },{
               "name": "sda8",
               "fstype": "btrfs",
               "size": "75,5G",
               "mountpoint": "/home",
               "label": "HOME"
            }
         ]
      }
   ]
}
,
"disk_usage":
[
  {
    "device": "/dev/sda3",
    "fstype": "btrfs",
    "size": "45G",
    "used": "90M",
    "avail": "44G",
    "used_pct": "1%",
    "mount": "/"
  },
  {
    "device": "/dev/sda6",
    "fstype": "ext4",
    "size": "74G",
    "used": "8,5G",
    "avail": "62G",
    "used_pct": "13%",
    "mount": "/usr"
  },
  {
    "device": "/dev/sda2",
    "fstype": "ext4",
    "size": "974M",
    "used": "102M",
    "avail": "805M",
    "used_pct": "12%",
    "mount": "/boot"
  },
  {
    "device": "/dev/sda5",
    "fstype": "ext4",
    "size": "4,3G",
    "used": "248K",
    "avail": "4,1G",
    "used_pct": "1%",
    "mount": "/tmp"
  },
  {
    "device": "/dev/sda4",
    "fstype": "ext4",
    "size": "11G",
    "used": "3,6G",
    "avail": "6,7G",
    "used_pct": "35%",
    "mount": "/var"
  },
  {
    "device": "/dev/sda8",
    "fstype": "btrfs",
    "size": "76G",
    "used": "2,0G",
    "avail": "72G",
    "used_pct": "3%",
    "mount": "/home"
  },
  {
    "device": "/dev/sda1",
    "fstype": "vfat",
    "size": "511M",
    "used": "5,9M",
    "avail": "506M",
    "used_pct": "2%",
    "mount": "/boot/efi"
  }
]
,
"power": {
"state": "               fully-charged",
"percentage": "          100%",
"capacity": "            66,8%"
},
"gpu_info":
"00:02.0 VGA compatible controller [0300]: Intel Corporation UHD Graphics 620 [8086:5917] (rev 07)\n\tSubsystem: Lenovo UHD Graphics 620 [17aa:3fdf]\n\tKernel driver in use: i915\n\tKernel modules: i915\n"
,
"network": {
[{"ifindex":1,"ifname":"lo","flags":["LOOPBACK","UP","LOWER_UP"],"mtu":65536,"qdisc":"noqueue","operstate":"UNKNOWN","group":"default","txqlen":1000,"link_type":"loopback","address":"00:00:00:00:00:00","broadcast":"00:00:00:00:00:00","addr_info":[{"family":"inet","local":"127.0.0.1","prefixlen":8,"scope":"host","label":"lo","valid_life_time":4294967295,"preferred_life_time":4294967295},{"family":"inet6","local":"::1","prefixlen":128,"scope":"host","noprefixroute":true,"valid_life_time":4294967295,"preferred_life_time":4294967295}]},{"ifindex":2,"ifname":"wlp2s0","flags":["BROADCAST","MULTICAST","UP","LOWER_UP"],"mtu":1500,"qdisc":"noqueue","operstate":"UP","group":"default","txqlen":1000,"link_type":"ether","address":"5c:cd:5b:65:a7:f2","broadcast":"ff:ff:ff:ff:ff:ff","addr_info":[{"family":"inet","local":"192.168.15.4","prefixlen":24,"broadcast":"192.168.15.255","scope":"global","dynamic":true,"noprefixroute":true,"label":"wlp2s0","valid_life_time":12265,"preferred_life_time":12265},{"family":"inet6","local":"2804:1b3:aac3:cff:b5e4:d191:59b4:4540","prefixlen":64,"scope":"global","dynamic":true,"noprefixroute":true,"valid_life_time":43160,"preferred_life_time":43160},{"family":"inet6","local":"fe80::391d:2dca:ffa3:fbfe","prefixlen":64,"scope":"link","noprefixroute":true,"valid_life_time":4294967295,"preferred_life_time":4294967295}]}]
,
"routing":
[{"dst":"default","gateway":"192.168.15.1","dev":"wlp2s0","protocol":"dhcp","prefsrc":"192.168.15.4","metric":600,"flags":[]},{"dst":"169.254.0.0/16","dev":"wlp2s0","scope":"link","metric":1000,"flags":[]},{"dst":"192.168.15.0/24","dev":"wlp2s0","protocol":"kernel","scope":"link","prefsrc":"192.168.15.4","metric":600,"flags":[]}]
},
"ping_latency_ms":
,
}

```
