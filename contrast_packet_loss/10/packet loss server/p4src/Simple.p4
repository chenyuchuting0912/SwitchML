#include "includes/defines.p4"
#include "includes/headers.p4"
#include "includes/parsers.p4"
#include "includes/checksum.p4"
#include "includes/intrinsic.p4"



#include "ipv4.p4"
#include "ethernet.p4"
#include "state.p4"


control ingress {
    check_state();

    if (singleorm.state==0) {
            apply (ipv4_route);
        }
        else if (singleorm.state==1) {
            apply (ipv4_routeM);
        }

}

control egress {

    if (singleorm.state==0) {
            apply (ethernet_set_mac);
        }
        else if (singleorm.state==1) {
            apply (update_route);
        }

}
