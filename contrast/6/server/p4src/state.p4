header_type singleorm_t {
    fields {
        state: 16;
    }
}
metadata singleorm_t singleorm;

action check_s_act(state) {
    modify_field(singleorm.state, state);
}

table check_s {
    reads {
        ipv4.dstAddr: exact;
    }
    actions {
        check_s_act;
    }
    size:8192;
}

control check_state {
    apply (check_s);
  
}
