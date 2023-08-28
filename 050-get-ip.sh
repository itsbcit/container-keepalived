export PRIMARY_INTERFACE=$(ip -4 route show default|cut -d" " -f5)
export PRIMARY_ADDRESS=$(ip -4 addr show dev ${PRIMARY_INTERFACE} | grep inet | tr -s " " | head -n 1 | cut -d" " -f3 | cut -d "/" -f1)
export PRIMARY_CIDR=$(ip -4 addr show dev ${PRIMARY_INTERFACE} | grep inet | tr -s " " | head -n 1 | cut -d" " -f3 | cut -d "/" -f2)
echo "Primary interface: ${PRIMARY_INTERFACE}"
echo "Source Address: ${PRIMARY_ADDRESS} CIDR: ${PRIMARY_CIDR}"
