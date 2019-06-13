/*action ethernet_set_mac_act (smac, dmac) {
    modify_field (ethernet.srcAddr, smac);
    modify_field (ethernet.dstAddr, dmac);
}
table ethernet_set_mac {
    reads {
        standard_metadata.egress_port: exact;
    }
    actions {
        ethernet_set_mac_act;
    }
}*/


/*设置对应的源目的ip*/

action do_update(dst_ip,src_ip) {
      modify_field(ipv4.dstAddr,dst_ip);
      modify_field(ipv4.srcAddr,src_ip);
      add_to_field(ipv4.ttl, -1);
}

table update_route {
    reads {
        intrinsic_metadata.egress_rid : exact;

    }
    actions {
        do_update;
        
    }
    size : 16384;
}
