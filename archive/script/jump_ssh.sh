#!/usr/bin/expect
set timeout 10  
set jump_user     [lindex $argv 0]
set jump_ip       [lindex $argv 1]
set jump_port     [lindex $argv 2]
set jump_password [lindex $argv 3]
set bind_port     [lindex $argv 4]
set to_bind_ip    [lindex $argv 5]
set to_bind_port  [lindex $argv 6]


spawn ssh -p $jump_port -fCPNL $bind_port:$to_bind_ip:$to_bind_port $jump_user@$jump_ip
expect "*password*"
send "$jump_password\r"
interact
