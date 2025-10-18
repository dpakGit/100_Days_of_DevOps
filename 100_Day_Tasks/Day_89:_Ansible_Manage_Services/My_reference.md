https://github.com/iinsys/devops/tree/master/100-days-of-devops/kodecloud/Day89

### Troubleshoot

[18-Oct-25 9:47 AM] Meta AI: The playbook you've created looks mostly correct. Here's a breakdown:

1. You're targeting all hosts in the inventory (hosts: all), which is fine if all the app servers are included in the inventory.
2. You're using become: yes to run the tasks with elevated privileges, which is necessary for installing packages and managing services.
3. You're installing the vsftpd package and starting and enabling the vsftpd service, which meets the requirements.

However, to ensure that the playbook works without any issues, you might want to consider adding some error handling and checking the status of the package installation and service management.

That being said, the playbook should work as expected, and the ansible-playbook command should run without any issues.

To confirm, you can run the playbook using the following command:


bash
ansible-playbook -i inventory playbook.yml


If everything is set up correctly, the playbook should install vsftpd on all app servers, start the service, and enable it to run on boot.

One minor suggestion: You might want to add a name to your play to make it more descriptive. Here's an updated version:


---
- name: Install and configure vsftpd
  hosts: all
  become: yes
  tasks:
  - name: Install vsftpd package
    yum:
      name: vsftpd
      state: present

  - name: Start and enable vsftpd service
    service:
      name: vsftpd
      state: started
      enabled: yes


But overall, your playbook looks good!
[18-Oct-25 10:10 AM] Deepak Ranjan Mishra: thor@jumphost ~/ansible$ # Run the playbook
ansible-playbook -i inventory playbook.yml

PLAY [all] *********************************************************************

TASK [Gathering Facts] *********************************************************
ok: [stapp02]
ok: [stapp03]
ok: [stapp01]

TASK [Install vsftpd package] **************************************************

fatal: [stapp02]: FAILED! => {"changed": false, "module_stderr": "Shared connection to 172.16.238.11 closed.\r\n", "module_stdout": "", "msg": "MODULE FAILURE\nSee stdout/stderr for the exact error", "rc": 137}
fatal: [stapp01]: FAILED! => {"changed": false, "module_stderr": "Shared connection to 172.16.238.10 closed.\r\n", "module_stdout": "", "msg": "MODULE FAILURE\nSee stdout/stderr for the exact error", "rc": 137}
changed: [stapp03]

TASK [Start and enable vsftpd service] *****************************************
changed: [stapp03]

PLAY RECAP *********************************************************************
stapp01                    : ok=1    changed=0    unreachable=0    failed=1    skipped=0    rescued=0    ignored=0   
stapp02                    : ok=1    changed=0    unreachable=0    failed=1    skipped=0    rescued=0    ignored=0   
stapp03                    : ok=3    changed=2    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   

thor@jumphost ~/ansible$ 
thor@jumphost ~/ansible$
[18-Oct-25 10:10 AM] Meta AI: The playbook ran into issues on stapp01 and stapp02, but it worked fine on stapp03.

The error message MODULE FAILURE with rc: 137 typically indicates that the task was killed due to a timeout or some other issue.

Here are a few potential causes:

1. SSH Connection Issues: The Shared connection to <IP> closed message suggests that there might be some issues with the SSH connection to the servers. You can try increasing the SSH connection timeout or checking the SSH server configuration on the target machines.
2. Package Installation Issues: The vsftpd package installation might be failing due to some dependency issues or conflicts. You can try adding some additional tasks to the playbook to troubleshoot the issue, such as checking the package manager logs or running the installation command manually on the target machines.

To troubleshoot further, you can try:

1. Running the playbook with increased verbosity using the -vvv option: ansible-playbook -i inventory playbook.yml -vvv
2. Checking the package manager logs on the target machines to see if there are any issues with the package installation.
3. Trying to install the vsftpd package manually on the target machines to see if it works.

It's also worth noting that the playbook is trying to start and enable the vsftpd service on all hosts, but since the installation failed on stapp01 and stapp02, this task is only being executed on stapp03. If you want to ensure that the service is only started and enabled on hosts where the installation was successful, you can use a block and rescue block to handle the errors.
[18-Oct-25 10:12 AM] Deepak Ranjan Mishra: b'')
ok: [stapp03] => {
    "changed": false,
    "enabled": true,
    "invocation": {
        "module_args": {
            "daemon_reexec": false,
            "daemon_reload": false,
            "enabled": true,
            "force": null,
            "masked": null,
            "name": "vsftpd",
            "no_block": false,
            "scope": "system",
            "state": "started"
        }
    },
    "name": "vsftpd",
    "state": "started",
    "status": {
        "ActiveEnterTimestamp": "Sat 2025-10-18 04:41:29 UTC",
        "ActiveEnterTimestampMonotonic": "7872994734",
        "ActiveExitTimestampMonotonic": "0",
        "ActiveState": "active",
        "After": "system.slice sysinit.target network-online.target systemd-journald.socket basic.target",
        "AllowIsolate": "no",
        "AssertResult": "yes",
        "AssertTimestamp": "Sat 2025-10-18 04:41:29 UTC",
        "AssertTimestampMonotonic": "7872967245",
        "Before": "shutdown.target multi-user.target",
        "BlockIOAccounting": "no",
        "BlockIOWeight": "[not set]",
        "CPUAccounting": "no",
        "CPUAffinityFromNUMA": "no",
        "CPUQuotaPerSecUSec": "infinity",
        "CPUQuotaPeriodUSec": "infinity",
        "CPUSchedulingPolicy": "0",
        "CPUSchedulingPriority": "0",
        "CPUSchedulingResetOnFork": "no",
        "CPUShares": "[not set]",
        "CPUUsageNSec": "[not set]",
        "CPUWeight": "[not set]",
        "CacheDirectoryMode": "0755",
        "CanFreeze": "yes",
        "CanIsolate": "no",
        "CanReload": "no",
        "CanStart": "yes",
        "CanStop": "yes",
        "CapabilityBoundingSet": "cap_chown cap_dac_override cap_dac_read_search cap_fowner cap_fsetid cap_kill cap_setgid cap_setuid cap_setpcap cap_linux_immutable cap_net_bind_service cap_net_broadcast cap_net_admin cap_net_raw cap_ipc_lock cap_ipc_owner cap_sys_module cap_sys_rawio cap_sys_chroot cap_sys_ptrace cap_sys_pacct cap_sys_admin cap_sys_boot cap_sys_nice cap_sys_resource cap_sys_time cap_sys_tty_config cap_mknod cap_lease cap_audit_write cap_audit_control cap_setfcap cap_mac_override cap_mac_admin cap_syslog cap_wake_alarm cap_block_suspend cap_audit_read",
        "CleanResult": "success",
        "CollectMode": "inactive",
        "ConditionResult": "yes",
        "ConditionTimestamp": "Sat 2025-10-18 04:41:29 UTC",
        "ConditionTimestampMonotonic": "7872967242",
        "ConfigurationDirectoryMode": "0755",
        "Conflicts": "shutdown.target",
        "ControlGroup": "/docker/641eaf02bf6c922fa7e43c164b9cf7cedaecbd1b9ec6ca14a4f46c930aa7a98a/system.slice/vsftpd.service",
        "ControlGroupId": "0",
        "ControlPID": "0",
        "CoredumpFilter": "0x33",
        "DefaultDependencies": "yes",
        "DefaultMemoryLow": "0",
        "DefaultMemoryMin": "0",
        "Delegate": "no",
        "Description": "Vsftpd ftp daemon",
        "DevicePolicy": "auto",
        "DynamicUser": "no",
        "ExecMainCode": "0",
        "ExecMainExitTimestampMonotonic": "0",
        "ExecMainPID": "3305",
        "ExecMainStartTimestamp": "Sat 2025-10-18 04:41:29 UTC",
        "ExecMainStartTimestampMonotonic": "7872994704",
        "ExecMainStatus": "0",
        "ExecStart": "{ path=/usr/sbin/vsftpd ; argv[]=/usr/sbin/vsftpd /etc/vsftpd/vsftpd.conf ; ignore_errors=no ; start_time=[Sat 2025-10-18 04:41:29 UTC] ; stop_time=[Sat 2025-10-18 04:41:29 UTC] ; pid=3304 ; code=exited ; status=0 }",
        "ExecStartEx": "{ path=/usr/sbin/vsftpd ; argv[]=/usr/sbin/vsftpd /etc/vsftpd/vsftpd.conf ; flags= ; start_time=[Sat 2025-10-18 04:41:29 UTC] ; stop_time=[Sat 2025-10-18 04:41:29 UTC] ; pid=3304 ; code=exited ; status=0 }",
        "ExitType": "main",
        "FailureAction": "none",
        "FileDescriptorStoreMax": "0",
        "FinalKillSignal": "9",
        "FragmentPath": "/usr/lib/systemd/system/vsftpd.service",
        "FreezerState": "running",
        "GID": "[not set]",
        "GuessMainPID": "yes",
        "IOAccounting": "no",
        "IOReadBytes": "18446744073709551615",
        "IOReadOperations": "18446744073709551615",
        "IOSchedulingClass": "2",
        "IOSchedulingPriority": "4",
        "IOWeight": "[not set]",
        "IOWriteBytes": "18446744073709551615",
        "IOWriteOperations": "18446744073709551615",
        "IPAccounting": "no",
        "IPEgressBytes": "[no data]",
        "IPEgressPackets": "[no data]",
        "IPIngressBytes": "[no data]",
        "IPIngressPackets": "[no data]",
        "Id": "vsftpd.service",
        "IgnoreOnIsolate": "no",
        "IgnoreSIGPIPE": "yes",
        "InactiveEnterTimestampMonotonic": "0",
        "InactiveExitTimestamp": "Sat 2025-10-18 04:41:29 UTC",
        "InactiveExitTimestampMonotonic": "7872990479",
        "InvocationID": "acf34c40596c497ba0c116764d11d3bd",
        "JobRunningTimeoutUSec": "infinity",
        "JobTimeoutAction": "none",
        "JobTimeoutUSec": "infinity",
        "KeyringMode": "private",
        "KillMode": "control-group",
        "KillSignal": "15",
        "LimitAS": "infinity",
        "LimitASSoft": "infinity",
        "LimitCORE": "infinity",
        "LimitCORESoft": "infinity",
        "LimitCPU": "infinity",
        "LimitCPUSoft": "infinity",
        "LimitDATA": "infinity",
        "LimitDATASoft": "infinity",
        "LimitFSIZE": "infinity",
        "LimitFSIZESoft": "infinity",
        "LimitLOCKS": "infinity",
        "LimitLOCKSSoft": "infinity",
        "LimitMEMLOCK": "67108864",
        "LimitMEMLOCKSoft": "67108864",
        "LimitMSGQUEUE": "819200",
        "LimitMSGQUEUESoft": "819200",
        "LimitNICE": "0",
        "LimitNICESoft": "0",
        "LimitNOFILE": "1048576",
        "LimitNOFILESoft": "1024",
        "LimitNPROC": "infinity",
        "LimitNPROCSoft": "infinity",
        "LimitRSS": "infinity",
        "LimitRSSSoft": "infinity",
        "LimitRTPRIO": "0",
        "LimitRTPRIOSoft": "0",
        "LimitRTTIME": "infinity",
        "LimitRTTIMESoft": "infinity",
        "LimitSIGPENDING": "256962",
        "LimitSIGPENDINGSoft": "256962",
        "LimitSTACK": "infinity",
        "LimitSTACKSoft": "8388608",
        "LoadState": "loaded",
        "LockPersonality": "no",
        "LogLevelMax": "-1",
        "LogRateLimitBurst": "0",
        "LogRateLimitIntervalUSec": "0",
        "LogsDirectoryMode": "0755",
        "MainPID": "3305",
        "ManagedOOMMemoryPressure": "auto",
        "ManagedOOMMemoryPressureLimit": "0",
        "ManagedOOMPreference": "none",
        "ManagedOOMSwap": "auto",
        "MemoryAccounting": "yes",
        "MemoryAvailable": "infinity",
        "MemoryCurrent": "868352",
        "MemoryDenyWriteExecute": "no",
        "MemoryHigh": "infinity",
        "MemoryLimit": "infinity",
        "MemoryLow": "0",
        "MemoryMax": "infinity",
        "MemoryMin": "0",
        "MemorySwapMax": "infinity",
        "MountAPIVFS": "no",
        "NFileDescriptorStore": "0",
        "NRestarts": "0",
        "NUMAPolicy": "n/a",
        "Names": "vsftpd.service",
        "NeedDaemonReload": "no",
        "Nice": "0",
        "NoNewPrivileges": "no",
        "NonBlocking": "no",
        "NotifyAccess": "none",
        "OOMPolicy": "stop",
        "OOMScoreAdjust": "0",
        "OnFailureJobMode": "replace",
        "OnSuccessJobMode": "fail",
        "Perpetual": "no",
        "PrivateDevices": "no",
        "PrivateIPC": "no",
        "PrivateMounts": "no",
        "PrivateNetwork": "no",
        "PrivateTmp": "no",
        "PrivateUsers": "no",
        "ProcSubset": "all",
        "ProtectClock": "no",
        "ProtectControlGroups": "no",
        "ProtectHome": "no",
        "ProtectHostname": "no",
        "ProtectKernelLogs": "no",
        "ProtectKernelModules": "no",
        "ProtectKernelTunables": "no",
        "ProtectProc": "default",
        "ProtectSystem": "no",
        "RefuseManualStart": "no",
        "RefuseManualStop": "no",
        "ReloadResult": "success",
        "ReloadSignal": "1",
        "RemainAfterExit": "no",
        "RemoveIPC": "no",
        "Requires": "sysinit.target system.slice",
        "Restart": "no",
        "RestartKillSignal": "15",
        "RestartUSec": "100ms",
        "RestrictNamespaces": "no",
        "RestrictRealtime": "no",
        "RestrictSUIDSGID": "no",
        "Result": "success",
        "RootDirectoryStartOnly": "no",
        "RuntimeDirectoryMode": "0755",
        "RuntimeDirectoryPreserve": "no",
        "RuntimeMaxUSec": "infinity",
        "RuntimeRandomizedExtraUSec": "0",
        "SameProcessGroup": "no",
        "SecureBits": "0",
        "SendSIGHUP": "no",
        "SendSIGKILL": "yes",
        "Slice": "system.slice",
        "StandardError": "inherit",
        "StandardInput": "null",
        "StandardOutput": "journal",
        "StartLimitAction": "none",
        "StartLimitBurst": "5",
        "StartLimitIntervalUSec": "10s",
        "StartupBlockIOWeight": "[not set]",
        "StartupCPUShares": "[not set]",
        "StartupCPUWeight": "[not set]",
        "StartupIOWeight": "[not set]",
        "StateChangeTimestamp": "Sat 2025-10-18 04:41:29 UTC",
        "StateChangeTimestampMonotonic": "7872994734",
        "StateDirectoryMode": "0755",
        "StatusErrno": "0",
        "StopWhenUnneeded": "no",
        "SubState": "running",
        "SuccessAction": "none",
        "SyslogFacility": "3",
        "SyslogLevel": "6",
        "SyslogLevelPrefix": "yes",
        "SyslogPriority": "30",
        "SystemCallErrorNumber": "2147483646",
        "TTYReset": "no",
        "TTYVHangup": "no",
        "TTYVTDisallocate": "no",
        "TasksAccounting": "yes",
        "TasksCurrent": "1",
        "TasksMax": "411140",
        "TimeoutAbortUSec": "1min 30s",
        "TimeoutCleanUSec": "infinity",
        "TimeoutStartFailureMode": "terminate",
        "TimeoutStartUSec": "1min 30s",
        "TimeoutStopFailureMode": "terminate",
        "TimeoutStopUSec": "1min 30s",
        "TimerSlackNSec": "50000",
        "Transient": "no",
        "Type": "forking",
        "UID": "[not set]",
        "UMask": "0022",
        "UnitFilePreset": "disabled",
        "UnitFileState": "enabled",
        "UtmpMode": "init",
        "WantedBy": "multi-user.target",
        "WatchdogSignal": "6",
        "WatchdogTimestampMonotonic": "0",
        "WatchdogUSec": "0"
    }
}
<172.16.238.11> (0, b'\r\n{"name": "vsftpd", "changed": true, "status": {"Type": "forking", "ExitType": "main", "Restart": "no", "NotifyAccess": "none", "RestartUSec": "100ms", "TimeoutStartUSec": "1min 30s", "TimeoutStopUSec": "1min 30s", "TimeoutAbortUSec": "1min 30s", "TimeoutStartFailureMode": "terminate", "TimeoutStopFailureMode": "terminate", "RuntimeMaxUSec": "infinity", "RuntimeRandomizedExtraUSec": "0", "WatchdogUSec": "infinity", "WatchdogTimestampMonotonic": "0", "RootDirectoryStartOnly": "no", "RemainAfterExit": "no", "GuessMainPID": "yes", "MainPID": "0", "ControlPID": "0", "FileDescriptorStoreMax": "0", "NFileDescriptorStore": "0", "StatusErrno": "0", "Result": "success", "ReloadResult": "success", "CleanResult": "success", "UID": "[not set]", "GID": "[not set]", "NRestarts": "0", "OOMPolicy": "stop", "ReloadSignal": "1", "ExecMainStartTimestampMonotonic": "0", "ExecMainExitTimestampMonotonic": "0", "ExecMainPID": "0", "ExecMainCode": "0", "ExecMainStatus": "0", "ExecStart": "{ path=/usr/sbin/vsftpd ; argv[]=/usr/sbin/vsftpd /etc/vsftpd/vsftpd.conf ; ignore_errors=no ; start_time=[n/a] ; stop_time=[n/a] ; pid=0 ; code=(null) ; status=0/0 }", "ExecStartEx": "{ path=/usr/sbin/vsftpd ; argv[]=/usr/sbin/vsftpd /etc/vsftpd/vsftpd.conf ; flags= ; start_time=[n/a] ; stop_time=[n/a] ; pid=0 ; code=(null) ; status=0/0 }", "Slice": "system.slice", "ControlGroupId": "0", "MemoryCurrent": "[not set]", "MemoryAvailable": "infinity", "CPUUsageNSec": "[not set]", "TasksCurrent": "[not set]", "IPIngressBytes": "[no data]", "IPIngressPackets": "[no data]", "IPEgressBytes": "[no data]", "IPEgressPackets": "[no data]", "IOReadBytes": "18446744073709551615", "IOReadOperations": "18446744073709551615", "IOWriteBytes": "18446744073709551615", "IOWriteOperations": "18446744073709551615", "Delegate": "no", "CPUAccounting": "no", "CPUWeight": "[not set]", "StartupCPUWeight": "[not set]", "CPUShares": "[not set]", "StartupCPUShares": "[not set]", "CPUQuotaPerSecUSec": "infinity", "CPUQuotaPeriodUSec": "infinity", "IOAccounting": "no", "IOWeight": "[not set]", "StartupIOWeight": "[not set]", "BlockIOAccounting": "no", "BlockIOWeight": "[not set]", "StartupBlockIOWeight": "[not set]", "MemoryAccounting": "yes", "DefaultMemoryLow": "0", "DefaultMemoryMin": "0", "MemoryMin": "0", "MemoryLow": "0", "MemoryHigh": "infinity", "MemoryMax": "infinity", "MemorySwapMax": "infinity", "MemoryLimit": "infinity", "DevicePolicy": "auto", "TasksAccounting": "yes", "TasksMax": "411140", "IPAccounting": "no", "ManagedOOMSwap": "auto", "ManagedOOMMemoryPressure": "auto", "ManagedOOMMemoryPressureLimit": "0", "ManagedOOMPreference": "none", "UMask": "0022", "LimitCPU": "infinity", "LimitCPUSoft": "infinity", "LimitFSIZE": "infinity", "LimitFSIZESoft": "infinity", "LimitDATA": "infinity", "LimitDATASoft": "infinity", "LimitSTACK": "infinity", "LimitSTACKSoft": "8388608", "LimitCORE": "infinity", "LimitCORESoft": "infinity", "LimitRSS": "infinity", "LimitRSSSoft": "infinity", "LimitNOFILE": "1048576", "LimitNOFILESoft": "1024", "LimitAS": "infinity", "LimitASSoft": "infinity", "LimitNPROC": "infinity", "LimitNPROCSoft": "infinity", "LimitMEMLOCK": "67108864", "LimitMEMLOCKSoft": "67108864", "LimitLOCKS": "infinity", "LimitLOCKSSoft": "infinity", "LimitSIGPENDING": "256962", "LimitSIGPENDINGSoft": "256962", "LimitMSGQUEUE": "819200", "LimitMSGQUEUESoft": "819200", "LimitNICE": "0", "LimitNICESoft": "0", "LimitRTPRIO": "0", "LimitRTPRIOSoft": "0", "LimitRTTIME": "infinity", "LimitRTTIMESoft": "infinity", "OOMScoreAdjust": "0", "CoredumpFilter": "0x33", "Nice": "0", "IOSchedulingClass": "2", "IOSchedulingPriority": "4", "CPUSchedulingPolicy": "0", "CPUSchedulingPriority": "0", "CPUAffinityFromNUMA": "no", "NUMAPolicy": "n/a", "TimerSlackNSec": "50000", "CPUSchedulingResetOnFork": "no", "NonBlocking": "no", "StandardInput": "null", "StandardOutput": "journal", "StandardError": "inherit", "TTYReset": "no", "TTYVHangup": "no", "TTYVTDisallocate": "no", "SyslogPriority": "30", "SyslogLevelPrefix": "yes", "SyslogLevel": "6", "SyslogFacility": "3", "LogLevelMax": "-1", "LogRateLimitIntervalUSec": "0", "LogRateLimitBurst": "0", "SecureBits": "0", "CapabilityBoundingSet": "cap_chown cap_dac_override cap_dac_read_search cap_fowner cap_fsetid cap_kill cap_setgid cap_setuid cap_setpcap cap_linux_immutable cap_net_bind_service cap_net_broadcast cap_net_admin cap_net_raw cap_ipc_lock cap_ipc_owner cap_sys_module cap_sys_rawio cap_sys_chroot cap_sys_ptrace cap_sys_pacct cap_sys_admin cap_sys_boot cap_sys_nice cap_sys_resource cap_sys_time cap_sys_tty_config cap_mknod cap_lease cap_audit_write cap_audit_control cap_setfcap cap_mac_override cap_mac_admin cap_syslog cap_wake_alarm cap_block_suspend cap_audit_read", "DynamicUser": "no", "RemoveIPC": "no", "PrivateTmp": "no", "PrivateDevices": "no", "ProtectClock": "no", "ProtectKernelTunables": "no", "ProtectKernelModules": "no", "ProtectKernelLogs": "no", "ProtectControlGroups": "no", "PrivateNetwork": "no", "PrivateUsers": "no", "PrivateMounts": "no", "PrivateIPC": "no", "ProtectHome": "no", "ProtectSystem": "no", "SameProcessGroup": "no", "UtmpMode": "init", "IgnoreSIGPIPE": "yes", "NoNewPrivileges": "no", "SystemCallErrorNumber": "2147483646", "LockPersonality": "no", "RuntimeDirectoryPreserve": "no", "RuntimeDirectoryMode": "0755", "StateDirectoryMode": "0755", "CacheDirectoryMode": "0755", "LogsDirectoryMode": "0755", "ConfigurationDirectoryMode": "0755", "TimeoutCleanUSec": "infinity", "MemoryDenyWriteExecute": "no", "RestrictRealtime": "no", "RestrictSUIDSGID": "no", "RestrictNamespaces": "no", "MountAPIVFS": "no", "KeyringMode": "private", "ProtectProc": "default", "ProcSubset": "all", "ProtectHostname": "no", "KillMode": "control-group", "KillSignal": "15", "RestartKillSignal": "15", "FinalKillSignal": "9", "SendSIGKILL": "yes", "SendSIGHUP": "no", "WatchdogSignal": "6", "Id": "vsftpd.service", "Names": "vsftpd.service", "Requires": "sysinit.target system.slice", "Conflicts": "shutdown.target", "Before": "shutdown.target", "After": "systemd-journald.socket network-online.target system.slice basic.target sysinit.target", "Description": "Vsftpd ftp daemon", "LoadState": "loaded", "ActiveState": "inactive", "FreezerState": "running", "SubState": "dead", "FragmentPath": "/usr/lib/systemd/system/vsftpd.service", "UnitFileState": "disabled", "UnitFilePreset": "disabled", "StateChangeTimestampMonotonic": "0", "InactiveExitTimestampMonotonic": "0", "ActiveEnterTimestampMonotonic": "0", "ActiveExitTimestampMonotonic": "0", "InactiveEnterTimestampMonotonic": "0", "CanStart": "yes", "CanStop": "yes", "CanReload": "no", "CanIsolate": "no", "CanFreeze": "yes", "StopWhenUnneeded": "no", "RefuseManualStart": "no", "RefuseManualStop": "no", "AllowIsolate": "no", "DefaultDependencies": "yes", "OnSuccessJobMode": "fail", "OnFailureJobMode": "replace", "IgnoreOnIsolate": "no", "NeedDaemonReload": "no", "JobTimeoutUSec": "infinity", "JobRunningTimeoutUSec": "infinity", "JobTimeoutAction": "none", "ConditionResult": "no", "AssertResult": "no", "ConditionTimestampMonotonic": "0", "AssertTimestampMonotonic": "0", "Transient": "no", "Perpetual": "no", "StartLimitIntervalUSec": "10s", "StartLimitBurst": "5", "StartLimitAction": "none", "FailureAction": "none", "SuccessAction": "none", "CollectMode": "inactive"}, "enabled": true, "state": "started", "invocation": {"module_args": {"name": "vsftpd", "state": "started", "enabled": true, "daemon_reload": false, "daemon_reexec": false, "scope": "system", "no_block": false, "force": null, "masked": null}}}\r\n', b'Shared connection to 172.16.238.11 closed.\r\n')
<172.16.238.11> ESTABLISH SSH CONNECTION FOR USER: steve
<172.16.238.11> SSH: EXEC sshpass -d13 ssh -C -o ControlMaster=auto -o ControlPersist=60s -o StrictHostKeyChecking=no -o 'User="steve"' -o ConnectTimeout=10 -o 'ControlPath="/home/thor/.ansible/cp/a46cd815a5"' 172.16.238.11 '/bin/sh -c '"'"'rm -f -r /home/steve/.ansible/tmp/ansible-tmp-1760762642.818134-3575-1739075361702/ > /dev/null 2>&1 && sleep 0'"'"''
<172.16.238.11> (0, b'', b'')
changed: [stapp02] => {
    "changed": true,
    "enabled": true,
    "invocation": {
        "module_args": {
            "daemon_reexec": false,
            "daemon_reload": false,
            "enabled": true,
            "force": null,
            "masked": null,
            "name": "vsftpd",
            "no_block": false,
            "scope": "system",
            "state": "started"
        }
    },
    "name": "vsftpd",
    "state": "started",
    "status": {
        "ActiveEnterTimestampMonotonic": "0",
        "ActiveExitTimestampMonotonic": "0",
        "ActiveState": "inactive",
        "After": "systemd-journald.socket network-online.target system.slice basic.target sysinit.target",
        "AllowIsolate": "no",
        "AssertResult": "no",
        "AssertTimestampMonotonic": "0",
        "Before": "shutdown.target",
        "BlockIOAccounting": "no",
        "BlockIOWeight": "[not set]",
        "CPUAccounting": "no",
        "CPUAffinityFromNUMA": "no",
        "CPUQuotaPerSecUSec": "infinity",
        "CPUQuotaPeriodUSec": "infinity",
        "CPUSchedulingPolicy": "0",
        "CPUSchedulingPriority": "0",
        "CPUSchedulingResetOnFork": "no",
        "CPUShares": "[not set]",
        "CPUUsageNSec": "[not set]",
        "CPUWeight": "[not set]",
        "CacheDirectoryMode": "0755",
        "CanFreeze": "yes",
        "CanIsolate": "no",
        "CanReload": "no",
        "CanStart": "yes",
        "CanStop": "yes",
        "CapabilityBoundingSet": "cap_chown cap_dac_override cap_dac_read_search cap_fowner cap_fsetid cap_kill cap_setgid cap_setuid cap_setpcap cap_linux_immutable cap_net_bind_service cap_net_broadcast cap_net_admin cap_net_raw cap_ipc_lock cap_ipc_owner cap_sys_module cap_sys_rawio cap_sys_chroot cap_sys_ptrace cap_sys_pacct cap_sys_admin cap_sys_boot cap_sys_nice cap_sys_resource cap_sys_time cap_sys_tty_config cap_mknod cap_lease cap_audit_write cap_audit_control cap_setfcap cap_mac_override cap_mac_admin cap_syslog cap_wake_alarm cap_block_suspend cap_audit_read",
        "CleanResult": "success",
        "CollectMode": "inactive",
        "ConditionResult": "no",
        "ConditionTimestampMonotonic": "0",
        "ConfigurationDirectoryMode": "0755",
        "Conflicts": "shutdown.target",
        "ControlGroupId": "0",
        "ControlPID": "0",
        "CoredumpFilter": "0x33",
        "DefaultDependencies": "yes",
        "DefaultMemoryLow": "0",
        "DefaultMemoryMin": "0",
        "Delegate": "no",
        "Description": "Vsftpd ftp daemon",
        "DevicePolicy": "auto",
        "DynamicUser": "no",
        "ExecMainCode": "0",
        "ExecMainExitTimestampMonotonic": "0",
        "ExecMainPID": "0",
        "ExecMainStartTimestampMonotonic": "0",
        "ExecMainStatus": "0",
        "ExecStart": "{ path=/usr/sbin/vsftpd ; argv[]=/usr/sbin/vsftpd /etc/vsftpd/vsftpd.conf ; ignore_errors=no ; start_time=[n/a] ; stop_time=[n/a] ; pid=0 ; code=(null) ; status=0/0 }",
        "ExecStartEx": "{ path=/usr/sbin/vsftpd ; argv[]=/usr/sbin/vsftpd /etc/vsftpd/vsftpd.conf ; flags= ; start_time=[n/a] ; stop_time=[n/a] ; pid=0 ; code=(null) ; status=0/0 }",
        "ExitType": "main",
        "FailureAction": "none",
        "FileDescriptorStoreMax": "0",
        "FinalKillSignal": "9",
        "FragmentPath": "/usr/lib/systemd/system/vsftpd.service",
        "FreezerState": "running",
        "GID": "[not set]",
        "GuessMainPID": "yes",
        "IOAccounting": "no",
        "IOReadBytes": "18446744073709551615",
        "IOReadOperations": "18446744073709551615",
        "IOSchedulingClass": "2",
        "IOSchedulingPriority": "4",
        "IOWeight": "[not set]",
        "IOWriteBytes": "18446744073709551615",
        "IOWriteOperations": "18446744073709551615",
        "IPAccounting": "no",
        "IPEgressBytes": "[no data]",
        "IPEgressPackets": "[no data]",
        "IPIngressBytes": "[no data]",
        "IPIngressPackets": "[no data]",
        "Id": "vsftpd.service",
        "IgnoreOnIsolate": "no",
        "IgnoreSIGPIPE": "yes",
        "InactiveEnterTimestampMonotonic": "0",
        "InactiveExitTimestampMonotonic": "0",
        "JobRunningTimeoutUSec": "infinity",
        "JobTimeoutAction": "none",
        "JobTimeoutUSec": "infinity",
        "KeyringMode": "private",
        "KillMode": "control-group",
        "KillSignal": "15",
        "LimitAS": "infinity",
        "LimitASSoft": "infinity",
        "LimitCORE": "infinity",
        "LimitCORESoft": "infinity",
        "LimitCPU": "infinity",
        "LimitCPUSoft": "infinity",
        "LimitDATA": "infinity",
        "LimitDATASoft": "infinity",
        "LimitFSIZE": "infinity",
        "LimitFSIZESoft": "infinity",
        "LimitLOCKS": "infinity",
        "LimitLOCKSSoft": "infinity",
        "LimitMEMLOCK": "67108864",
        "LimitMEMLOCKSoft": "67108864",
        "LimitMSGQUEUE": "819200",
        "LimitMSGQUEUESoft": "819200",
        "LimitNICE": "0",
        "LimitNICESoft": "0",
        "LimitNOFILE": "1048576",
        "LimitNOFILESoft": "1024",
        "LimitNPROC": "infinity",
        "LimitNPROCSoft": "infinity",
        "LimitRSS": "infinity",
        "LimitRSSSoft": "infinity",
        "LimitRTPRIO": "0",
        "LimitRTPRIOSoft": "0",
        "LimitRTTIME": "infinity",
        "LimitRTTIMESoft": "infinity",
        "LimitSIGPENDING": "256962",
        "LimitSIGPENDINGSoft": "256962",
        "LimitSTACK": "infinity",
        "LimitSTACKSoft": "8388608",
        "LoadState": "loaded",
        "LockPersonality": "no",
        "LogLevelMax": "-1",
        "LogRateLimitBurst": "0",
        "LogRateLimitIntervalUSec": "0",
        "LogsDirectoryMode": "0755",
        "MainPID": "0",
        "ManagedOOMMemoryPressure": "auto",
        "ManagedOOMMemoryPressureLimit": "0",
        "ManagedOOMPreference": "none",
        "ManagedOOMSwap": "auto",
        "MemoryAccounting": "yes",
        "MemoryAvailable": "infinity",
        "MemoryCurrent": "[not set]",
        "MemoryDenyWriteExecute": "no",
        "MemoryHigh": "infinity",
        "MemoryLimit": "infinity",
        "MemoryLow": "0",
        "MemoryMax": "infinity",
        "MemoryMin": "0",
        "MemorySwapMax": "infinity",
        "MountAPIVFS": "no",
        "NFileDescriptorStore": "0",
        "NRestarts": "0",
        "NUMAPolicy": "n/a",
        "Names": "vsftpd.service",
        "NeedDaemonReload": "no",
        "Nice": "0",
        "NoNewPrivileges": "no",
        "NonBlocking": "no",
        "NotifyAccess": "none",
        "OOMPolicy": "stop",
        "OOMScoreAdjust": "0",
        "OnFailureJobMode": "replace",
        "OnSuccessJobMode": "fail",
        "Perpetual": "no",
        "PrivateDevices": "no",
        "PrivateIPC": "no",
        "PrivateMounts": "no",
        "PrivateNetwork": "no",
        "PrivateTmp": "no",
        "PrivateUsers": "no",
        "ProcSubset": "all",
        "ProtectClock": "no",
        "ProtectControlGroups": "no",
        "ProtectHome": "no",
        "ProtectHostname": "no",
        "ProtectKernelLogs": "no",
        "ProtectKernelModules": "no",
        "ProtectKernelTunables": "no",
        "ProtectProc": "default",
        "ProtectSystem": "no",
        "RefuseManualStart": "no",
        "RefuseManualStop": "no",
        "ReloadResult": "success",
        "ReloadSignal": "1",
        "RemainAfterExit": "no",
        "RemoveIPC": "no",
        "Requires": "sysinit.target system.slice",
        "Restart": "no",
        "RestartKillSignal": "15",
        "RestartUSec": "100ms",
        "RestrictNamespaces": "no",
        "RestrictRealtime": "no",
        "RestrictSUIDSGID": "no",
        "Result": "success",
        "RootDirectoryStartOnly": "no",
        "RuntimeDirectoryMode": "0755",
        "RuntimeDirectoryPreserve": "no",
        "RuntimeMaxUSec": "infinity",
        "RuntimeRandomizedExtraUSec": "0",
        "SameProcessGroup": "no",
        "SecureBits": "0",
        "SendSIGHUP": "no",
        "SendSIGKILL": "yes",
        "Slice": "system.slice",
        "StandardError": "inherit",
        "StandardInput": "null",
        "StandardOutput": "journal",
        "StartLimitAction": "none",
        "StartLimitBurst": "5",
        "StartLimitIntervalUSec": "10s",
        "StartupBlockIOWeight": "[not set]",
        "StartupCPUShares": "[not set]",
        "StartupCPUWeight": "[not set]",
        "StartupIOWeight": "[not set]",
        "StateChangeTimestampMonotonic": "0",
        "StateDirectoryMode": "0755",
        "StatusErrno": "0",
        "StopWhenUnneeded": "no",
        "SubState": "dead",
        "SuccessAction": "none",
        "SyslogFacility": "3",
        "SyslogLevel": "6",
        "SyslogLevelPrefix": "yes",
        "SyslogPriority": "30",
        "SystemCallErrorNumber": "2147483646",
        "TTYReset": "no",
        "TTYVHangup": "no",
        "TTYVTDisallocate": "no",
        "TasksAccounting": "yes",
        "TasksCurrent": "[not set]",
        "TasksMax": "411140",
        "TimeoutAbortUSec": "1min 30s",
        "TimeoutCleanUSec": "infinity",
        "TimeoutStartFailureMode": "terminate",
        "TimeoutStartUSec": "1min 30s",
        "TimeoutStopFailureMode": "terminate",
        "TimeoutStopUSec": "1min 30s",
        "TimerSlackNSec": "50000",
        "Transient": "no",
        "Type": "forking",
        "UID": "[not set]",
        "UMask": "0022",
        "UnitFilePreset": "disabled",
        "UnitFileState": "disabled",
        "UtmpMode": "init",
        "WatchdogSignal": "6",
        "WatchdogTimestampMonotonic": "0",
        "WatchdogUSec": "infinity"
    }
}

PLAY RECAP *********************************************************************************************************************
stapp01                    : ok=1    changed=0    unreachable=0    failed=1    skipped=0    rescued=0    ignored=0   
stapp02                    : ok=3    changed=2    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
stapp03                    : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
[18-Oct-25 10:12 AM] Meta AI: The issue seems to be with the stapp01 server. The vsftpd package installation is failing on this server, which is causing the playbook to fail.

Here are a few potential reasons for this issue:

1. Package availability: Make sure that the vsftpd package is available in the repository configured on stapp01. You can try running yum list vsftpd on stapp01 to check if the package is available.
2. Dependency issues: There might be dependency issues on stapp01 that are preventing the vsftpd package from installing. You can try running yum install -y vsftpd on stapp01 to see if there are any dependency errors.
3. Yum configuration: The yum configuration on stapp01 might be incorrect or corrupted. You can try checking the yum configuration files on stapp01 to ensure that they are correct.

To troubleshoot this issue further, you can try running the playbook with increased verbosity using the -vvv option:


bash
ansible-playbook -i inventory playbook.yml -vvv


This will provide more detailed output that might help you identify the issue.

Additionally, you can try adding a failed_when: false clause to the yum task to ignore failures and continue running the playbook:


- name: Install vsftpd package
  yum:
    name: vsftpd
    state: present
  failed_when: false


However, this is just a temporary workaround, and you should investigate and fix the underlying issue on stapp01.
[18-Oct-25 10:14 AM] Deepak Ranjan Mishra: thor@jumphost ~/ansible$ ansible-playbook -i inventory playbook.yml -v
Using /etc/ansible/ansible.cfg as config file

PLAY [all] *********************************************************************************************************************

TASK [Gathering Facts] *********************************************************************************************************
ok: [stapp03]
ok: [stapp01]
ok: [stapp02]

TASK [Install vsftpd package] **************************************************************************************************
ok: [stapp02] => {"changed": false, "msg": "Nothing to do", "rc": 0, "results": []}
ok: [stapp03] => {"changed": false, "msg": "Nothing to do", "rc": 0, "results": []}
changed: [stapp01] => {"changed": true, "msg": "", "rc": 0, "results": ["Installed: vsftpd-3.0.5-6.el9.x86_64"]}

TASK [Start and enable vsftpd service] *****************************************************************************************
ok: [stapp03] => {"changed": false, "enabled": true, "name": "vsftpd", "state": "started", "status": {"ActiveEnterTimestamp": "Sat 2025-10-18 04:41:29 UTC", "ActiveEnterTimestampMonotonic": "7872994734", "ActiveExitTimestampMonotonic": "0", "ActiveState": "active", "After": "system.slice sysinit.target network-online.target systemd-journald.socket basic.target", "AllowIsolate": "no", "AssertResult": "yes", "AssertTimestamp": "Sat 2025-10-18 04:41:29 UTC", "AssertTimestampMonotonic": "7872967245", "Before": "shutdown.target multi-user.target", "BlockIOAccounting": "no", "BlockIOWeight": "[not set]", "CPUAccounting": "no", "CPUAffinityFromNUMA": "no", "CPUQuotaPerSecUSec": "infinity", "CPUQuotaPeriodUSec": "infinity", "CPUSchedulingPolicy": "0", "CPUSchedulingPriority": "0", "CPUSchedulingResetOnFork": "no", "CPUShares": "[not set]", "CPUUsageNSec": "[not set]", "CPUWeight": "[not set]", "CacheDirectoryMode": "0755", "CanFreeze": "yes", "CanIsolate": "no", "CanReload": "no", "CanStart": "yes", "CanStop": "yes", "CapabilityBoundingSet": "cap_chown cap_dac_override cap_dac_read_search cap_fowner cap_fsetid cap_kill cap_setgid cap_setuid cap_setpcap cap_linux_immutable cap_net_bind_service cap_net_broadcast cap_net_admin cap_net_raw cap_ipc_lock cap_ipc_owner cap_sys_module cap_sys_rawio cap_sys_chroot cap_sys_ptrace cap_sys_pacct cap_sys_admin cap_sys_boot cap_sys_nice cap_sys_resource cap_sys_time cap_sys_tty_config cap_mknod cap_lease cap_audit_write cap_audit_control cap_setfcap cap_mac_override cap_mac_admin cap_syslog cap_wake_alarm cap_block_suspend cap_audit_read", "CleanResult": "success", "CollectMode": "inactive", "ConditionResult": "yes", "ConditionTimestamp": "Sat 2025-10-18 04:41:29 UTC", "ConditionTimestampMonotonic": "7872967242", "ConfigurationDirectoryMode": "0755", "Conflicts": "shutdown.target", "ControlGroup": "/docker/641eaf02bf6c922fa7e43c164b9cf7cedaecbd1b9ec6ca14a4f46c930aa7a98a/system.slice/vsftpd.service", "ControlGroupId": "0", "ControlPID": "0", "CoredumpFilter": "0x33", "DefaultDependencies": "yes", "DefaultMemoryLow": "0", "DefaultMemoryMin": "0", "Delegate": "no", "Description": "Vsftpd ftp daemon", "DevicePolicy": "auto", "DynamicUser": "no", "ExecMainCode": "0", "ExecMainExitTimestampMonotonic": "0", "ExecMainPID": "3305", "ExecMainStartTimestamp": "Sat 2025-10-18 04:41:29 UTC", "ExecMainStartTimestampMonotonic": "7872994704", "ExecMainStatus": "0", "ExecStart": "{ path=/usr/sbin/vsftpd ; argv[]=/usr/sbin/vsftpd /etc/vsftpd/vsftpd.conf ; ignore_errors=no ; start_time=[Sat 2025-10-18 04:41:29 UTC] ; stop_time=[Sat 2025-10-18 04:41:29 UTC] ; pid=3304 ; code=exited ; status=0 }", "ExecStartEx": "{ path=/usr/sbin/vsftpd ; argv[]=/usr/sbin/vsftpd /etc/vsftpd/vsftpd.conf ; flags= ; start_time=[Sat 2025-10-18 04:41:29 UTC] ; stop_time=[Sat 2025-10-18 04:41:29 UTC] ; pid=3304 ; code=exited ; status=0 }", "ExitType": "main", "FailureAction": "none", "FileDescriptorStoreMax": "0", "FinalKillSignal": "9", "FragmentPath": "/usr/lib/systemd/system/vsftpd.service", "FreezerState": "running", "GID": "[not set]", "GuessMainPID": "yes", "IOAccounting": "no", "IOReadBytes": "18446744073709551615", "IOReadOperations": "18446744073709551615", "IOSchedulingClass": "2", "IOSchedulingPriority": "4", "IOWeight": "[not set]", "IOWriteBytes": "18446744073709551615", "IOWriteOperations": "18446744073709551615", "IPAccounting": "no", "IPEgressBytes": "[no data]", "IPEgressPackets": "[no data]", "IPIngressBytes": "[no data]", "IPIngressPackets": "[no data]", "Id": "vsftpd.service", "IgnoreOnIsolate": "no", "IgnoreSIGPIPE": "yes", "InactiveEnterTimestampMonotonic": "0", "InactiveExitTimestamp": "Sat 2025-10-18 04:41:29 UTC", "InactiveExitTimestampMonotonic": "7872990479", "InvocationID": "acf34c40596c497ba0c116764d11d3bd", "JobRunningTimeoutUSec": "infinity", "JobTimeoutAction": "none", "JobTimeoutUSec": "infinity", "KeyringMode": "private", "KillMode": "control-group", "KillSignal": "15", "LimitAS": "infinity", "LimitASSoft": "infinity", "LimitCORE": "infinity", "LimitCORESoft": "infinity", "LimitCPU": "infinity", "LimitCPUSoft": "infinity", "LimitDATA": "infinity", "LimitDATASoft": "infinity", "LimitFSIZE": "infinity", "LimitFSIZESoft": "infinity", "LimitLOCKS": "infinity", "LimitLOCKSSoft": "infinity", "LimitMEMLOCK": "67108864", "LimitMEMLOCKSoft": "67108864", "LimitMSGQUEUE": "819200", "LimitMSGQUEUESoft": "819200", "LimitNICE": "0", "LimitNICESoft": "0", "LimitNOFILE": "1048576", "LimitNOFILESoft": "1024", "LimitNPROC": "infinity", "LimitNPROCSoft": "infinity", "LimitRSS": "infinity", "LimitRSSSoft": "infinity", "LimitRTPRIO": "0", "LimitRTPRIOSoft": "0", "LimitRTTIME": "infinity", "LimitRTTIMESoft": "infinity", "LimitSIGPENDING": "256962", "LimitSIGPENDINGSoft": "256962", "LimitSTACK": "infinity", "LimitSTACKSoft": "8388608", "LoadState": "loaded", "LockPersonality": "no", "LogLevelMax": "-1", "LogRateLimitBurst": "0", "LogRateLimitIntervalUSec": "0", "LogsDirectoryMode": "0755", "MainPID": "3305", "ManagedOOMMemoryPressure": "auto", "ManagedOOMMemoryPressureLimit": "0", "ManagedOOMPreference": "none", "ManagedOOMSwap": "auto", "MemoryAccounting": "yes", "MemoryAvailable": "infinity", "MemoryCurrent": "868352", "MemoryDenyWriteExecute": "no", "MemoryHigh": "infinity", "MemoryLimit": "infinity", "MemoryLow": "0", "MemoryMax": "infinity", "MemoryMin": "0", "MemorySwapMax": "infinity", "MountAPIVFS": "no", "NFileDescriptorStore": "0", "NRestarts": "0", "NUMAPolicy": "n/a", "Names": "vsftpd.service", "NeedDaemonReload": "no", "Nice": "0", "NoNewPrivileges": "no", "NonBlocking": "no", "NotifyAccess": "none", "OOMPolicy": "stop", "OOMScoreAdjust": "0", "OnFailureJobMode": "replace", "OnSuccessJobMode": "fail", "Perpetual": "no", "PrivateDevices": "no", "PrivateIPC": "no", "PrivateMounts": "no", "PrivateNetwork": "no", "PrivateTmp": "no", "PrivateUsers": "no", "ProcSubset": "all", "ProtectClock": "no", "ProtectControlGroups": "no", "ProtectHome": "no", "ProtectHostname": "no", "ProtectKernelLogs": "no", "ProtectKernelModules": "no", "ProtectKernelTunables": "no", "ProtectProc": "default", "ProtectSystem": "no", "RefuseManualStart": "no", "RefuseManualStop": "no", "ReloadResult": "success", "ReloadSignal": "1", "RemainAfterExit": "no", "RemoveIPC": "no", "Requires": "sysinit.target system.slice", "Restart": "no", "RestartKillSignal": "15", "RestartUSec": "100ms", "RestrictNamespaces": "no", "RestrictRealtime": "no", "RestrictSUIDSGID": "no", "Result": "success", "RootDirectoryStartOnly": "no", "RuntimeDirectoryMode": "0755", "RuntimeDirectoryPreserve": "no", "RuntimeMaxUSec": "infinity", "RuntimeRandomizedExtraUSec": "0", "SameProcessGroup": "no", "SecureBits": "0", "SendSIGHUP": "no", "SendSIGKILL": "yes", "Slice": "system.slice", "StandardError": "inherit", "StandardInput": "null", "StandardOutput": "journal", "StartLimitAction": "none", "StartLimitBurst": "5", "StartLimitIntervalUSec": "10s", "StartupBlockIOWeight": "[not set]", "StartupCPUShares": "[not set]", "StartupCPUWeight": "[not set]", "StartupIOWeight": "[not set]", "StateChangeTimestamp": "Sat 2025-10-18 04:41:29 UTC", "StateChangeTimestampMonotonic": "7872994734", "StateDirectoryMode": "0755", "StatusErrno": "0", "StopWhenUnneeded": "no", "SubState": "running", "SuccessAction": "none", "SyslogFacility": "3", "SyslogLevel": "6", "SyslogLevelPrefix": "yes", "SyslogPriority": "30", "SystemCallErrorNumber": "2147483646", "TTYReset": "no", "TTYVHangup": "no", "TTYVTDisallocate": "no", "TasksAccounting": "yes", "TasksCurrent": "1", "TasksMax": "411140", "TimeoutAbortUSec": "1min 30s", "TimeoutCleanUSec": "infinity", "TimeoutStartFailureMode": "terminate", "TimeoutStartUSec": "1min 30s", "TimeoutStopFailureMode": "terminate", "TimeoutStopUSec": "1min 30s", "TimerSlackNSec": "50000", "Transient": "no", "Type": "forking", "UID": "[not set]", "UMask": "0022", "UnitFilePreset": "disabled", "UnitFileState": "enabled", "UtmpMode": "init", "WantedBy": "multi-user.target", "WatchdogSignal": "6", "WatchdogTimestampMonotonic": "0", "WatchdogUSec": "0"}}
ok: [stapp02] => {"changed": false, "enabled": true, "name": "vsftpd", "state": "started", "status": {"ActiveEnterTimestamp": "Sat 2025-10-18 04:44:05 UTC", "ActiveEnterTimestampMonotonic": "8029127069", "ActiveExitTimestampMonotonic": "0", "ActiveState": "active", "After": "systemd-journald.socket basic.target system.slice network-online.target sysinit.target", "AllowIsolate": "no", "AssertResult": "yes", "AssertTimestamp": "Sat 2025-10-18 04:44:05 UTC", "AssertTimestampMonotonic": "8029080431", "Before": "shutdown.target multi-user.target", "BlockIOAccounting": "no", "BlockIOWeight": "[not set]", "CPUAccounting": "no", "CPUAffinityFromNUMA": "no", "CPUQuotaPerSecUSec": "infinity", "CPUQuotaPeriodUSec": "infinity", "CPUSchedulingPolicy": "0", "CPUSchedulingPriority": "0", "CPUSchedulingResetOnFork": "no", "CPUShares": "[not set]", "CPUUsageNSec": "[not set]", "CPUWeight": "[not set]", "CacheDirectoryMode": "0755", "CanFreeze": "yes", "CanIsolate": "no", "CanReload": "no", "CanStart": "yes", "CanStop": "yes", "CapabilityBoundingSet": "cap_chown cap_dac_override cap_dac_read_search cap_fowner cap_fsetid cap_kill cap_setgid cap_setuid cap_setpcap cap_linux_immutable cap_net_bind_service cap_net_broadcast cap_net_admin cap_net_raw cap_ipc_lock cap_ipc_owner cap_sys_module cap_sys_rawio cap_sys_chroot cap_sys_ptrace cap_sys_pacct cap_sys_admin cap_sys_boot cap_sys_nice cap_sys_resource cap_sys_time cap_sys_tty_config cap_mknod cap_lease cap_audit_write cap_audit_control cap_setfcap cap_mac_override cap_mac_admin cap_syslog cap_wake_alarm cap_block_suspend cap_audit_read", "CleanResult": "success", "CollectMode": "inactive", "ConditionResult": "yes", "ConditionTimestamp": "Sat 2025-10-18 04:44:05 UTC", "ConditionTimestampMonotonic": "8029080429", "ConfigurationDirectoryMode": "0755", "Conflicts": "shutdown.target", "ControlGroup": "/docker/1d23ec6ae2eafd772d385e6debbd2159be671463bf4f55c4c835143ba2d41680/system.slice/vsftpd.service", "ControlGroupId": "0", "ControlPID": "0", "CoredumpFilter": "0x33", "DefaultDependencies": "yes", "DefaultMemoryLow": "0", "DefaultMemoryMin": "0", "Delegate": "no", "Description": "Vsftpd ftp daemon", "DevicePolicy": "auto", "DynamicUser": "no", "ExecMainCode": "0", "ExecMainExitTimestampMonotonic": "0", "ExecMainPID": "4016", "ExecMainStartTimestamp": "Sat 2025-10-18 04:44:05 UTC", "ExecMainStartTimestampMonotonic": "8029127050", "ExecMainStatus": "0", "ExecStart": "{ path=/usr/sbin/vsftpd ; argv[]=/usr/sbin/vsftpd /etc/vsftpd/vsftpd.conf ; ignore_errors=no ; start_time=[Sat 2025-10-18 04:44:05 UTC] ; stop_time=[Sat 2025-10-18 04:44:05 UTC] ; pid=4015 ; code=exited ; status=0 }", "ExecStartEx": "{ path=/usr/sbin/vsftpd ; argv[]=/usr/sbin/vsftpd /etc/vsftpd/vsftpd.conf ; flags= ; start_time=[Sat 2025-10-18 04:44:05 UTC] ; stop_time=[Sat 2025-10-18 04:44:05 UTC] ; pid=4015 ; code=exited ; status=0 }", "ExitType": "main", "FailureAction": "none", "FileDescriptorStoreMax": "0", "FinalKillSignal": "9", "FragmentPath": "/usr/lib/systemd/system/vsftpd.service", "FreezerState": "running", "GID": "[not set]", "GuessMainPID": "yes", "IOAccounting": "no", "IOReadBytes": "18446744073709551615", "IOReadOperations": "18446744073709551615", "IOSchedulingClass": "2", "IOSchedulingPriority": "4", "IOWeight": "[not set]", "IOWriteBytes": "18446744073709551615", "IOWriteOperations": "18446744073709551615", "IPAccounting": "no", "IPEgressBytes": "[no data]", "IPEgressPackets": "[no data]", "IPIngressBytes": "[no data]", "IPIngressPackets": "[no data]", "Id": "vsftpd.service", "IgnoreOnIsolate": "no", "IgnoreSIGPIPE": "yes", "InactiveEnterTimestampMonotonic": "0", "InactiveExitTimestamp": "Sat 2025-10-18 04:44:05 UTC", "InactiveExitTimestampMonotonic": "8029121070", "InvocationID": "537aa77f963c4e8c804e069b5b37930c", "JobRunningTimeoutUSec": "infinity", "JobTimeoutAction": "none", "JobTimeoutUSec": "infinity", "KeyringMode": "private", "KillMode": "control-group", "KillSignal": "15", "LimitAS": "infinity", "LimitASSoft": "infinity", "LimitCORE": "infinity", "LimitCORESoft": "infinity", "LimitCPU": "infinity", "LimitCPUSoft": "infinity", "LimitDATA": "infinity", "LimitDATASoft": "infinity", "LimitFSIZE": "infinity", "LimitFSIZESoft": "infinity", "LimitLOCKS": "infinity", "LimitLOCKSSoft": "infinity", "LimitMEMLOCK": "67108864", "LimitMEMLOCKSoft": "67108864", "LimitMSGQUEUE": "819200", "LimitMSGQUEUESoft": "819200", "LimitNICE": "0", "LimitNICESoft": "0", "LimitNOFILE": "1048576", "LimitNOFILESoft": "1024", "LimitNPROC": "infinity", "LimitNPROCSoft": "infinity", "LimitRSS": "infinity", "LimitRSSSoft": "infinity", "LimitRTPRIO": "0", "LimitRTPRIOSoft": "0", "LimitRTTIME": "infinity", "LimitRTTIMESoft": "infinity", "LimitSIGPENDING": "256962", "LimitSIGPENDINGSoft": "256962", "LimitSTACK": "infinity", "LimitSTACKSoft": "8388608", "LoadState": "loaded", "LockPersonality": "no", "LogLevelMax": "-1", "LogRateLimitBurst": "0", "LogRateLimitIntervalUSec": "0", "LogsDirectoryMode": "0755", "MainPID": "4016", "ManagedOOMMemoryPressure": "auto", "ManagedOOMMemoryPressureLimit": "0", "ManagedOOMPreference": "none", "ManagedOOMSwap": "auto", "MemoryAccounting": "yes", "MemoryAvailable": "infinity", "MemoryCurrent": "1003520", "MemoryDenyWriteExecute": "no", "MemoryHigh": "infinity", "MemoryLimit": "infinity", "MemoryLow": "0", "MemoryMax": "infinity", "MemoryMin": "0", "MemorySwapMax": "infinity", "MountAPIVFS": "no", "NFileDescriptorStore": "0", "NRestarts": "0", "NUMAPolicy": "n/a", "Names": "vsftpd.service", "NeedDaemonReload": "no", "Nice": "0", "NoNewPrivileges": "no", "NonBlocking": "no", "NotifyAccess": "none", "OOMPolicy": "stop", "OOMScoreAdjust": "0", "OnFailureJobMode": "replace", "OnSuccessJobMode": "fail", "Perpetual": "no", "PrivateDevices": "no", "PrivateIPC": "no", "PrivateMounts": "no", "PrivateNetwork": "no", "PrivateTmp": "no", "PrivateUsers": "no", "ProcSubset": "all", "ProtectClock": "no", "ProtectControlGroups": "no", "ProtectHome": "no", "ProtectHostname": "no", "ProtectKernelLogs": "no", "ProtectKernelModules": "no", "ProtectKernelTunables": "no", "ProtectProc": "default", "ProtectSystem": "no", "RefuseManualStart": "no", "RefuseManualStop": "no", "ReloadResult": "success", "ReloadSignal": "1", "RemainAfterExit": "no", "RemoveIPC": "no", "Requires": "system.slice sysinit.target", "Restart": "no", "RestartKillSignal": "15", "RestartUSec": "100ms", "RestrictNamespaces": "no", "RestrictRealtime": "no", "RestrictSUIDSGID": "no", "Result": "success", "RootDirectoryStartOnly": "no", "RuntimeDirectoryMode": "0755", "RuntimeDirectoryPreserve": "no", "RuntimeMaxUSec": "infinity", "RuntimeRandomizedExtraUSec": "0", "SameProcessGroup": "no", "SecureBits": "0", "SendSIGHUP": "no", "SendSIGKILL": "yes", "Slice": "system.slice", "StandardError": "inherit", "StandardInput": "null", "StandardOutput": "journal", "StartLimitAction": "none", "StartLimitBurst": "5", "StartLimitIntervalUSec": "10s", "StartupBlockIOWeight": "[not set]", "StartupCPUShares": "[not set]", "StartupCPUWeight": "[not set]", "StartupIOWeight": "[not set]", "StateChangeTimestamp": "Sat 2025-10-18 04:44:05 UTC", "StateChangeTimestampMonotonic": "8029127069", "StateDirectoryMode": "0755", "StatusErrno": "0", "StopWhenUnneeded": "no", "SubState": "running", "SuccessAction": "none", "SyslogFacility": "3", "SyslogLevel": "6", "SyslogLevelPrefix": "yes", "SyslogPriority": "30", "SystemCallErrorNumber": "2147483646", "TTYReset": "no", "TTYVHangup": "no", "TTYVTDisallocate": "no", "TasksAccounting": "yes", "TasksCurrent": "1", "TasksMax": "411140", "TimeoutAbortUSec": "1min 30s", "TimeoutCleanUSec": "infinity", "TimeoutStartFailureMode": "terminate", "TimeoutStartUSec": "1min 30s", "TimeoutStopFailureMode": "terminate", "TimeoutStopUSec": "1min 30s", "TimerSlackNSec": "50000", "Transient": "no", "Type": "forking", "UID": "[not set]", "UMask": "0022", "UnitFilePreset": "disabled", "UnitFileState": "enabled", "UtmpMode": "init", "WantedBy": "multi-user.target", "WatchdogSignal": "6", "WatchdogTimestampMonotonic": "0", "WatchdogUSec": "0"}}
changed: [stapp01] => {"changed": true, "enabled": true, "name": "vsftpd", "state": "started", "status": {"ActiveEnterTimestampMonotonic": "0", "ActiveExitTimestampMonotonic": "0", "ActiveState": "inactive", "After": "systemd-journald.socket basic.target sysinit.target network-online.target system.slice", "AllowIsolate": "no", "AssertResult": "no", "AssertTimestampMonotonic": "0", "Before": "shutdown.target", "BlockIOAccounting": "no", "BlockIOWeight": "[not set]", "CPUAccounting": "no", "CPUAffinityFromNUMA": "no", "CPUQuotaPerSecUSec": "infinity", "CPUQuotaPeriodUSec": "infinity", "CPUSchedulingPolicy": "0", "CPUSchedulingPriority": "0", "CPUSchedulingResetOnFork": "no", "CPUShares": "[not set]", "CPUUsageNSec": "[not set]", "CPUWeight": "[not set]", "CacheDirectoryMode": "0755", "CanFreeze": "yes", "CanIsolate": "no", "CanReload": "no", "CanStart": "yes", "CanStop": "yes", "CapabilityBoundingSet": "cap_chown cap_dac_override cap_dac_read_search cap_fowner cap_fsetid cap_kill cap_setgid cap_setuid cap_setpcap cap_linux_immutable cap_net_bind_service cap_net_broadcast cap_net_admin cap_net_raw cap_ipc_lock cap_ipc_owner cap_sys_module cap_sys_rawio cap_sys_chroot cap_sys_ptrace cap_sys_pacct cap_sys_admin cap_sys_boot cap_sys_nice cap_sys_resource cap_sys_time cap_sys_tty_config cap_mknod cap_lease cap_audit_write cap_audit_control cap_setfcap cap_mac_override cap_mac_admin cap_syslog cap_wake_alarm cap_block_suspend cap_audit_read", "CleanResult": "success", "CollectMode": "inactive", "ConditionResult": "no", "ConditionTimestampMonotonic": "0", "ConfigurationDirectoryMode": "0755", "Conflicts": "shutdown.target", "ControlGroupId": "0", "ControlPID": "0", "CoredumpFilter": "0x33", "DefaultDependencies": "yes", "DefaultMemoryLow": "0", "DefaultMemoryMin": "0", "Delegate": "no", "Description": "Vsftpd ftp daemon", "DevicePolicy": "auto", "DynamicUser": "no", "ExecMainCode": "0", "ExecMainExitTimestampMonotonic": "0", "ExecMainPID": "0", "ExecMainStartTimestampMonotonic": "0", "ExecMainStatus": "0", "ExecStart": "{ path=/usr/sbin/vsftpd ; argv[]=/usr/sbin/vsftpd /etc/vsftpd/vsftpd.conf ; ignore_errors=no ; start_time=[n/a] ; stop_time=[n/a] ; pid=0 ; code=(null) ; status=0/0 }", "ExecStartEx": "{ path=/usr/sbin/vsftpd ; argv[]=/usr/sbin/vsftpd /etc/vsftpd/vsftpd.conf ; flags= ; start_time=[n/a] ; stop_time=[n/a] ; pid=0 ; code=(null) ; status=0/0 }", "ExitType": "main", "FailureAction": "none", "FileDescriptorStoreMax": "0", "FinalKillSignal": "9", "FragmentPath": "/usr/lib/systemd/system/vsftpd.service", "FreezerState": "running", "GID": "[not set]", "GuessMainPID": "yes", "IOAccounting": "no", "IOReadBytes": "18446744073709551615", "IOReadOperations": "18446744073709551615", "IOSchedulingClass": "2", "IOSchedulingPriority": "4", "IOWeight": "[not set]", "IOWriteBytes": "18446744073709551615", "IOWriteOperations": "18446744073709551615", "IPAccounting": "no", "IPEgressBytes": "[no data]", "IPEgressPackets": "[no data]", "IPIngressBytes": "[no data]", "IPIngressPackets": "[no data]", "Id": "vsftpd.service", "IgnoreOnIsolate": "no", "IgnoreSIGPIPE": "yes", "InactiveEnterTimestampMonotonic": "0", "InactiveExitTimestampMonotonic": "0", "JobRunningTimeoutUSec": "infinity", "JobTimeoutAction": "none", "JobTimeoutUSec": "infinity", "KeyringMode": "private", "KillMode": "control-group", "KillSignal": "15", "LimitAS": "infinity", "LimitASSoft": "infinity", "LimitCORE": "infinity", "LimitCORESoft": "infinity", "LimitCPU": "infinity", "LimitCPUSoft": "infinity", "LimitDATA": "infinity", "LimitDATASoft": "infinity", "LimitFSIZE": "infinity", "LimitFSIZESoft": "infinity", "LimitLOCKS": "infinity", "LimitLOCKSSoft": "infinity", "LimitMEMLOCK": "67108864", "LimitMEMLOCKSoft": "67108864", "LimitMSGQUEUE": "819200", "LimitMSGQUEUESoft": "819200", "LimitNICE": "0", "LimitNICESoft": "0", "LimitNOFILE": "1048576", "LimitNOFILESoft": "1024", "LimitNPROC": "infinity", "LimitNPROCSoft": "infinity", "LimitRSS": "infinity", "LimitRSSSoft": "infinity", "LimitRTPRIO": "0", "LimitRTPRIOSoft": "0", "LimitRTTIME": "infinity", "LimitRTTIMESoft": "infinity", "LimitSIGPENDING": "256962", "LimitSIGPENDINGSoft": "256962", "LimitSTACK": "infinity", "LimitSTACKSoft": "8388608", "LoadState": "loaded", "LockPersonality": "no", "LogLevelMax": "-1", "LogRateLimitBurst": "0", "LogRateLimitIntervalUSec": "0", "LogsDirectoryMode": "0755", "MainPID": "0", "ManagedOOMMemoryPressure": "auto", "ManagedOOMMemoryPressureLimit": "0", "ManagedOOMPreference": "none", "ManagedOOMSwap": "auto", "MemoryAccounting": "yes", "MemoryAvailable": "infinity", "MemoryCurrent": "[not set]", "MemoryDenyWriteExecute": "no", "MemoryHigh": "infinity", "MemoryLimit": "infinity", "MemoryLow": "0", "MemoryMax": "infinity", "MemoryMin": "0", "MemorySwapMax": "infinity", "MountAPIVFS": "no", "NFileDescriptorStore": "0", "NRestarts": "0", "NUMAPolicy": "n/a", "Names": "vsftpd.service", "NeedDaemonReload": "no", "Nice": "0", "NoNewPrivileges": "no", "NonBlocking": "no", "NotifyAccess": "none", "OOMPolicy": "stop", "OOMScoreAdjust": "0", "OnFailureJobMode": "replace", "OnSuccessJobMode": "fail", "Perpetual": "no", "PrivateDevices": "no", "PrivateIPC": "no", "PrivateMounts": "no", "PrivateNetwork": "no", "PrivateTmp": "no", "PrivateUsers": "no", "ProcSubset": "all", "ProtectClock": "no", "ProtectControlGroups": "no", "ProtectHome": "no", "ProtectHostname": "no", "ProtectKernelLogs": "no", "ProtectKernelModules": "no", "ProtectKernelTunables": "no", "ProtectProc": "default", "ProtectSystem": "no", "RefuseManualStart": "no", "RefuseManualStop": "no", "ReloadResult": "success", "ReloadSignal": "1", "RemainAfterExit": "no", "RemoveIPC": "no", "Requires": "sysinit.target system.slice", "Restart": "no", "RestartKillSignal": "15", "RestartUSec": "100ms", "RestrictNamespaces": "no", "RestrictRealtime": "no", "RestrictSUIDSGID": "no", "Result": "success", "RootDirectoryStartOnly": "no", "RuntimeDirectoryMode": "0755", "RuntimeDirectoryPreserve": "no", "RuntimeMaxUSec": "infinity", "RuntimeRandomizedExtraUSec": "0", "SameProcessGroup": "no", "SecureBits": "0", "SendSIGHUP": "no", "SendSIGKILL": "yes", "Slice": "system.slice", "StandardError": "inherit", "StandardInput": "null", "StandardOutput": "journal", "StartLimitAction": "none", "StartLimitBurst": "5", "StartLimitIntervalUSec": "10s", "StartupBlockIOWeight": "[not set]", "StartupCPUShares": "[not set]", "StartupCPUWeight": "[not set]", "StartupIOWeight": "[not set]", "StateChangeTimestampMonotonic": "0", "StateDirectoryMode": "0755", "StatusErrno": "0", "StopWhenUnneeded": "no", "SubState": "dead", "SuccessAction": "none", "SyslogFacility": "3", "SyslogLevel": "6", "SyslogLevelPrefix": "yes", "SyslogPriority": "30", "SystemCallErrorNumber": "2147483646", "TTYReset": "no", "TTYVHangup": "no", "TTYVTDisallocate": "no", "TasksAccounting": "yes", "TasksCurrent": "[not set]", "TasksMax": "411140", "TimeoutAbortUSec": "1min 30s", "TimeoutCleanUSec": "infinity", "TimeoutStartFailureMode": "terminate", "TimeoutStartUSec": "1min 30s", "TimeoutStopFailureMode": "terminate", "TimeoutStopUSec": "1min 30s", "TimerSlackNSec": "50000", "Transient": "no", "Type": "forking", "UID": "[not set]", "UMask": "0022", "UnitFilePreset": "disabled", "UnitFileState": "disabled", "UtmpMode": "init", "WatchdogSignal": "6", "WatchdogTimestampMonotonic": "0", "WatchdogUSec": "infinity"}}

PLAY RECAP *********************************************************************************************************************
stapp01                    : ok=3    changed=2    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
stapp02                    : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
stapp03                    : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   

thor@jumphost ~/ansible$
[18-Oct-25 10:14 AM] Meta AI: The issue seems to be with the vsftpd service on stapp01. The service is not starting properly, and the Ansible playbook is reporting a changed state but the service is actually in a dead state.

The relevant output from the Ansible playbook run is:


changed: [stapp01] => {"changed": true, "enabled": true, "name": "vsftpd", "state": "started", "status": {"ActiveState": "inactive" ...


And later in the output:


"SubState": "dead"


This indicates that the vsftpd service is not running on stapp01.

Some potential reasons for this issue could be:

1. Configuration errors: There might be errors in the vsftpd configuration file (/etc/vsftpd/vsftpd.conf) that are preventing the service from starting.
2. Port conflicts: Another process might be using the port that vsftpd is trying to bind to.
3. Dependency issues: There might be dependency issues with other services that vsftpd relies on.

To troubleshoot this issue, you can try the following:

1. *Check the vsftpd logs*: Check the logs for any error messages that might indicate why the service is not starting.
2. Verify the configuration: Verify that the vsftpd configuration file is correct and there are no syntax errors.
3. Check for port conflicts: Use tools like netstat or ss to check if any other process is using the port that vsftpd is trying to bind to.
4. Try starting the service manually: Try starting the vsftpd service manually on stapp01 to see if it starts successfully.

You can also try adding some debug tasks to your Ansible playbook to gather more information about the issue. For example, you can use the shell module to run commands like systemctl status vsftpd or journalctl -u vsftpd to get more information about the service's status.
[18-Oct-25 10:17 AM] Deepak Ranjan Mishra: [tony@stapp01 ~]$ systemctl status vsftpd
● vsftpd.service - Vsftpd ftp daemon
     Loaded: loaded (/usr/lib/systemd/system/vsf
tpd.service; enabled; preset: disabled)
     Active: active (running) since Sat 2025-10-18 04:45:42 UTC; 2min 39s ago
    Process: 4627 ExecStart=/usr/sbin/vsftpd /etc/vsftpd/vsftpd.conf (code=exited, status=0/SUCCESS)
   Main PID: 4628 (vsftpd)
      Tasks: 1 (limit: 411140)
     Memory: 852.0K
     CGroup: /docker/0eb6492a24e44206a2dfa3945046c96c20a2c8d9b8ee59c8ec5d344acb4ebe39/system.slice/vsftpd.service
             └─4628 /usr/sbin/vsftpd /etc/vsftpd/vsftpd.conf

Oct 18 04:45:42 stapp01.stratos.xfusioncorp.com systemd[1]: Starting Vsftpd ftp daemon...
Oct 18 04:45:42 stapp01.stratos.xfusioncorp.com systemd[4627]: vsftpd.service: Executing: /usr/s
bin/vsftpd /etc/vsftpd/vsftpd.conf
Oct 18 04:45:42 stapp01.stratos.xfusioncorp.com systemd[1]: vsftpd.service: Child 4627 belongs t
o vsftpd.service.
Oct 18 04:45:42 stapp01.stratos.xfusioncorp.com systemd[1]: vsftpd.service: Control process exit
ed, code=exited, status=0/SUCCESS (success)
Oct 18 04:45:42 stapp01.stratos.xfusioncorp.com systemd[1]: vsftpd.service: Got final SIGCHLD fo
r state start.
Oct 18 04:45:42 stapp01.stratos.xfusioncorp.com systemd[1]: vsftpd.service: Main PID guessed: 46
28
--More--
[18-Oct-25 10:17 AM] Meta AI: It seems like the vsftpd service is actually running on stapp01. The systemctl status vsftpd command shows that the service is active and running.

The Ansible playbook output might be showing a changed state because the service was restarted or reloaded during the playbook run.

Given that the service is running, it's likely that the issue is with the Ansible playbook's reporting of the service state. You can try adding a task to the playbook to check the service state after starting it, to ensure that it's indeed running.

Here's an example:


- name: Check vsftpd service status
  service:
    name: vsftpd
    state: started
    enabled: yes
  register: service_status

- name: Print service status
  debug:
    msg: "{{ service_status }}"


This will print the status of the vsftpd service after attempting to start it, which can help you diagnose any issues.
[18-Oct-25 10:18 AM] Meta AI: You can add the additional tasks to your existing Ansible playbook. Here's an updated version of the playbook:


---
- name: Install and configure vsftpd
  hosts: all
  become: yes
  tasks:
  - name: Install vsftpd package
    yum:
      name: vsftpd
      state: present

  - name: Start and enable vsftpd service
    service:
      name: vsftpd
      state: started
      enabled: yes

  - name: Check vsftpd service status
    service:
      name: vsftpd
      state: started
      enabled: yes
    register: service_status

  - name: Print service status
    debug:
      msg: "{{ service_status }}"


Add the last two tasks to your existing playbook, making sure to indent them correctly under the tasks section.

After adding these tasks, run the playbook again using the ansible-playbook command. The additional tasks will help you gather more information about the vsftpd service status on each host.
[18-Oct-25 10:18 AM] Meta AI: You want to check the service status and print it. Here's the corrected formatting:


- name: Check vsftpd service status
  service:
    name: vsftpd
    state: started
    enabled: yes
  register: service_status

- name: Print service status
  debug:
    msg: "{{ service_status }}"


This will ensure the vsftpd service is started and enabled, and then print the service status for verification.
