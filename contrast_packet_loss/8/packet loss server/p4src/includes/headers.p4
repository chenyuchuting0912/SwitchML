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
        wid : 32;
        ver : 32;
        idx : 32;
        off : 32;
    }
}

header sml_hdr_t sml_hdr;

header_type sml_vector_t { 
    fields { 
        vector_1: 32; 
        vector_2: 32; 
        vector_3: 32; 
        vector_4: 32; 
        vector_5: 32; 
        vector_6: 32; 
        vector_7: 32; 
        vector_8: 32; 
        vector_9: 32; 
        vector_10: 32; 
        vector_11: 32; 
        vector_12: 32; 
        vector_13: 32; 
        vector_14: 32; 
        vector_15: 32; 
        vector_16: 32; 
        vector_17: 32; 
        vector_18: 32; 
        vector_19: 32; 
        vector_20: 32; 
        vector_21: 32; 
        vector_22: 32; 
        vector_23: 32; 
        vector_24: 32; 
        vector_25: 32; 
        vector_26: 32; 
        vector_27: 32; 
        vector_28: 32; 
        vector_29: 32; 
        vector_30: 32; 
        vector_31: 32; 
        vector_32: 32; 
    } 
} 
header sml_vector_t sml_vector;
