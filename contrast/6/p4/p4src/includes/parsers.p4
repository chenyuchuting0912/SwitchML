parser start {
    return parse_ethernet;
}

#define ETHER_TYPE_IPV4 0x0800
parser parse_ethernet {
    extract (ethernet);
    return select (latest.etherType) {
        ETHER_TYPE_IPV4: parse_ipv4;
        default: ingress;
    }
}

#define IPV4_PROTOCOL_TCP 6
#define IPV4_PROTOCOL_UDP 17
parser parse_ipv4 {
    extract(ipv4);
    return select (latest.protocol) {
        IPV4_PROTOCOL_TCP: parse_tcp;
        IPV4_PROTOCOL_UDP: parse_udp;
        default: ingress;
    }
}

parser parse_tcp {
    extract (tcp);
    return ingress;
}

parser parse_udp {
    extract (udp);
    return select (latest.dstPort) {
        SML_PORT: parse_sml_hdr;
        default: ingress;
    }
}

/*解析sml_hdr的头，依旧不是很明白为什么需要绕一个圈*/
parser parse_sml_hdr{
    extract (sml_hdr);
    return parse_vector;
} 

parser parse_vector {
    extract (sml_vector);
    return ingress;
}


