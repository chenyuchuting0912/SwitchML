/*找到包的内容，所对应的寄存器号*/


header_type location_t {
    fields {
        index: 16;
    }
}
metadata location_t location;

action find_index_act(index) {
    modify_field(location.index, index);
}

table find_index {
    reads {
        sml_hdr.key: exact;
    }
    actions {
        find_index_act;
    }
}

control process_cache {
    apply (find_index);
  
}
