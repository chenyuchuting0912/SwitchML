#include "includes/defines.p4"
#include "includes/headers.p4"
#include "includes/parsers.p4"
#include "includes/checksum.p4"


#include "ipv4.p4"
#include "ethernet.p4"


control ingress {

    apply (ipv4_route);
}

control egress {
    apply (ethernet_set_mac);

}
