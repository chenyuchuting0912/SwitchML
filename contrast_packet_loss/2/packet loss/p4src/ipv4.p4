action set_egress(egress_spec) {
    modify_field(standard_metadata.egress_spec, egress_spec);
    add_to_field(ipv4.ttl, -1);
}

table ipv4_route {
    reads {
        ipv4.dstAddr : exact;
    }
    actions {
        set_egress;
    }
    size : 8192;
}

//多播
action set_output_mcg(mcast_group) {
    modify_field(intrinsic_metadata.mcast_grp, mcast_group);
    add_to_field(ipv4.ttl, -1);
}

table ipv4_routeM {
    reads {
        ipv4.dstAddr: exact;
    }
    actions {
        set_output_mcg;
    }
    size : 16384;
}
