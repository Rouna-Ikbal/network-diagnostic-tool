#!/bin/bash

mkdir -p logs
mkdir -p reports

TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
LOGFILE="logs/network_${TIMESTAMP}.log"
REPORTFILE="reports/report_${TIMESTAMP}.txt"

log_message()
{
    echo "[$(date)] $1" >> "$LOGFILE"
}

ping_test()
{
    echo "=== Ping selected ===" >> "$REPORTFILE"
    read -p "Enter host: " host
    ping -c 4 "$host" >> "$REPORTFILE" 2>&1
    log_message "Ping test executed for $host"
}

dns_lookup()
{
    echo "=== DNS Lookup selected ===" >> "$REPORTFILE"
    read -p "Enter domain: " domain
    nslookup "$domain" >> "$REPORTFILE" 2>&1
    log_message "DNS lookup executed for $domain"
}

trace_route()
{
    echo "=== Trace route selected ===" >> "$REPORTFILE"
    read -p "Enter host: " host
    traceroute "$host" >> "$REPORTFILE" 2>&1
    log_message "Traceroute executed for $host"
}

port_check()
{
    echo "=== Port check selected ===" >> "$REPORTFILE"
    read -p "Enter host: " host
    read -p "Enter port: " port
    nc -zv "$host" "$port" >> "$REPORTFILE" 2>&1
    log_message "Port check executed for $host:$port"
}

show_report_location()
{
    echo 
    echo "Report File : $REPORTFILE"
    echo "Log File : $LOGFILE"
    echo
}

while true
do
    echo
    echo "======================="
    echo "NETWORK DIAGNOSTIC TOOL"
    echo "======================="
    echo "1. Ping Host"
    echo "2. DNS Lookup"
    echo "3. Trace Route"
    echo "4. Port Check"
    echo "5. Show Report Location"
    echo "6. Exit"
    echo

    read -p "Enter choice: " choice
    case $choice in
        1)
            ping_test
            ;;
        2)
            dns_lookup
            ;;
        3)
            trace_route
            ;;
        4)
            port_check
            ;;
        5)
            show_report_location
            ;;
        6)
            echo "Exiting..."
            exit 0
            ;;
        *)
            echo "Invalid choice"
            ;;
    esac
done