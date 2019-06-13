header_type ethernet_t {
    fields {
        dstAddr : 48;
        srcAddr : 48;
        etherType : 16;
    }
}
header ethernet_t ethernet;

header_type ipv4_t {
    fields {
        version : 4;
        ihl : 4;
        diffserv : 8;
        totalLen : 16;
        identification : 16;
        flags : 3;
        fragOffset : 13;
        ttl : 8;
        protocol : 8;
        hdrChecksum : 16;
        srcAddr : 32;
        dstAddr: 32;
    }
}
header ipv4_t ipv4;

header_type tcp_t {
    fields {
        srcPort : 16;
        dstPort : 16;
        seqNo : 32;
        ackNo : 32;
        dataOffset : 4;
        res : 3;
        ecn : 3;
        ctrl : 6;
        window : 16;
        checksum : 16;
        urgentPtr : 16;
    }   
}
header tcp_t tcp;

header_type udp_t {
    fields {
        srcPort : 16;
        dstPort : 16;
        len : 16;
        checksum : 16;
    }
}
header udp_t udp;

/*  在pool中的偏移量，以及数据编号 */
/* idx与off的值是暂时定为这么多，真正的需要等到找到数据集之后再看*/
header_type sml_hdr_t{
    fields{
        idx : 10;
        off : 16;
    }
}

header sml_hdr_t sml_hdr;

/*vector 数据的部分*，这里在aggregation中定义了，稍后看看是否需要修改*/
/*这一部分似乎是没用的， 在netcache是用来计数的。
header_type sml_load_t{
    fields{
    load_1: 32;
    load_2: 32;
    load_3: 32;
    load_4: 32;
    load_5: 32;
    load_6: 32;
    load_7: 32;
    load_8: 32;
    load_9: 32;
    load_10: 32;
    load_11: 32;
    load_12: 32;
    load_13: 32;
    load_14: 32;
    load_15: 32;
    load_16: 32;
    load_17: 32;
    load_18: 32;
    load_19: 32;
    load_20: 32;
    load_21: 32;
    load_22: 32;
    load_23: 32;
    load_24: 32;
    load_25: 32;
    load_26: 32;
    load_27: 32;
    load_28: 32;
    load_29: 32;
    load_30: 32;
    load_31: 32;
    load_32: 32;


    }
}
header sml_load_t sml_load;
*/