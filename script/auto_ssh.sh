#!/usr/bin/expect
set timeout 10
set username [lindex $argv 0]
set password [lindex $argv 1]
set hostname [lindex $argv 2]

set port 22
if {$argc > 3} {
    set port [lindex $argv 3]
}

spawn ssh $username@$hostname -p $port
expect "*password*"
send "$password\r"
interact
