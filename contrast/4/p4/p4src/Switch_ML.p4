#include "includes/defines.p4"
#include "includes/headers.p4"
#include "includes/parsers.p4"
#include "includes/checksum.p4"
#include "includes/intrinsic.p4"


#include "aggregation.p4"
#include "ipv4.p4"
#include "routing.p4"
#include "cache.p4"

control ingress {
    process_cache();
    process_aggregation();

    apply (ipv4_route);
}

control egress {
    if(meta_count.count_value<4){
     apply(drop_packet);
}else{
     apply (update_route);
	
}

    
}


