#include "includes/defines.p4"
#include "includes/headers.p4"
#include "includes/parsers.p4"
#include "includes/checksum.p4"

#include "aggregation"
#include "ipv4.p4"
#include "routing.p4"

control ingress {
    process_cache();
    process_aggregation();

    apply (ipv4_route);
}

control egress {

    apply (update_route);
}


