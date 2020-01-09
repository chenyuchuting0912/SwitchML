/*pool count 以及seen的在寄存器偏移量，pool与count可以使用同一个*/

header_type pclocation_t {
    fields {
        index: 16;
    }
}
metadata pclocation_t pclocation;

header_type seenlocation_t {
    fields {
        index: 16;
    }
}
metadata seenlocation_t seenlocation;

/*（p.ver+1）%2的seen*/
header_type seenlocation1_t {
    fields {
        index: 16;
    } 
}
metadata seenlocation1_t seenlocation1;

/*存（p.ver+1）%2的元数据*/
header_type unver_t {
    fields {
        value: 32;
    } 
}
metadata unver_t unver;

/*存入元数据unver的table与action*/
table unver_read { 
    actions { 
        unver_read_act; 
    } 
}

action unver_read_act() { 
    modify_field(unver.value, (sml_hdr.ver)%2+1);
}





action find_pcindex_act(index) {
    modify_field(pclocation.index, index);
}

table find_pcindex {
    reads {
        sml_hdr.ver: exact;
        sml_hdr.idx: exact;
    }
    actions {
        find_pcindex_act;
    }
    size:CACHE_NUM;
}

action find_seenindex_act(index) {
    modify_field(seenlocation.index, index);
}

table find_seenindex {
    reads {
        sml_hdr.ver: exact;
        sml_hdr.idx: exact;
        sml_hdr.wid: exact;
    }
    actions {
        find_seenindex_act;
    }
    size:CACHE_NUM;
}
/*程序还会用到（p.ver+1）%2的seen*/
action find_seenindex1_act(index) {
    modify_field(seenlocation1.index, index);
}

table find_seenindex1 {
    reads {
        unver.value: exact;
        sml_hdr.idx: exact;
        sml_hdr.wid: exact;
    }
    actions {
        find_seenindex1_act;
    }
    size:CACHE_NUM;
}



control find_index {
    apply (find_seenindex);
    apply (find_pcindex);
    apply (unver_read);
    apply (find_seenindex1);  
}
