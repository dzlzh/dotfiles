#!/usr/bin/expect
set timeout 10
set hostname [lindex $argv 0]
set username [lindex $argv 1]
set port     [lindex $argv 2]
set password [lindex $argv 3]

spawn mycli -h $hostname -u $username -P $port -p
expect "*password*"
send "$password\r"
interact
