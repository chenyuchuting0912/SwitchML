#include "includes/defines.p4"
#include "includes/headers.p4"
#include "includes/parsers.p4"
#include "includes/checksum.p4"
#include "includes/intrinsic.p4"


#include "aggregation.p4"
#include "ipv4.p4"
#include "routing.p4"
#include "findindex.p4"

control ingress {
    find_index();
    process_aggregation();
    if (singleorm.state==0) {
            apply (ipv4_route);
        }
        else if (singleorm.state==1) {
            apply (ipv4_routeM);
        }
}

control egress {
    if  (singleorm.state==0) {
            apply (ethernet_set_mac);
        }
        else if (singleorm.state==1) {
            apply (update_route);
        }else {
            apply(drop_packet);
        }
}


