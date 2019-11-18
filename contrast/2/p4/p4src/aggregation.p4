
/*存储vector的寄存器*/


register vector_1_reg { 
    width: 32; 
    instance_count: CACHE_NUM; 
}
register vector_2_reg { 
    width: 32; 
    instance_count: CACHE_NUM; 
}
register vector_3_reg { 
    width: 32; 
    instance_count: CACHE_NUM; 
}
register vector_4_reg { 
    width: 32; 
    instance_count: CACHE_NUM; 
}
register vector_5_reg { 
    width: 32; 
    instance_count: CACHE_NUM; 
}
register vector_6_reg { 
    width: 32; 
    instance_count: CACHE_NUM; 
}
register vector_7_reg { 
    width: 32; 
    instance_count: CACHE_NUM; 
}
register vector_8_reg { 
    width: 32; 
    instance_count: CACHE_NUM; 
}
register vector_9_reg { 
    width: 32; 
    instance_count: CACHE_NUM; 
}
register vector_10_reg { 
    width: 32; 
    instance_count: CACHE_NUM; 
}
register vector_11_reg { 
    width: 32; 
    instance_count: CACHE_NUM; 
}
register vector_12_reg { 
    width: 32; 
    instance_count: CACHE_NUM; 
}
register vector_13_reg { 
    width: 32; 
    instance_count: CACHE_NUM; 
}
register vector_14_reg { 
    width: 32; 
    instance_count: CACHE_NUM; 
}
register vector_15_reg { 
    width: 32; 
    instance_count: CACHE_NUM; 
}
register vector_16_reg { 
    width: 32; 
    instance_count: CACHE_NUM; 
}
register vector_17_reg { 
    width: 32; 
    instance_count: CACHE_NUM; 
}
register vector_18_reg { 
    width: 32; 
    instance_count: CACHE_NUM; 
}
register vector_19_reg { 
    width: 32; 
    instance_count: CACHE_NUM; 
}
register vector_20_reg { 
    width: 32; 
    instance_count: CACHE_NUM; 
}
register vector_21_reg { 
    width: 32; 
    instance_count: CACHE_NUM; 
}
register vector_22_reg { 
    width: 32; 
    instance_count: CACHE_NUM; 
}
register vector_23_reg { 
    width: 32; 
    instance_count: CACHE_NUM; 
}
register vector_24_reg { 
    width: 32; 
    instance_count: CACHE_NUM; 
}
register vector_25_reg { 
    width: 32; 
    instance_count: CACHE_NUM; 
}
register vector_26_reg { 
    width: 32; 
    instance_count: CACHE_NUM; 
}
register vector_27_reg { 
    width: 32; 
    instance_count: CACHE_NUM; 
}
register vector_28_reg { 
    width: 32; 
    instance_count: CACHE_NUM; 
}
register vector_29_reg { 
    width: 32; 
    instance_count: CACHE_NUM; 
}
register vector_30_reg { 
    width: 32; 
    instance_count: CACHE_NUM; 
}
register vector_31_reg { 
    width: 32; 
    instance_count: CACHE_NUM; 
}
register vector_32_reg { 
    width: 32; 
    instance_count: CACHE_NUM; 
}

/*接下来的部分希望，定义count的并行哎*/
register count_reg { 
    width: 8; 
    instance_count: CACHE_NUM; 
}



/*处理count+1的操作是需要元数据的帮助，两数相加也需要元数据的帮助吧*/


/*定义记录意经聚合的vector的元数据*/
header_type meta_count_t { 
    fields { 
        count_value: 8; 
    } 
}
metadata meta_count_t meta_count;


table count_add { 
    actions { 
        count_add_act; 
    } 
}

action count_add_act() { 
    register_read(meta_count.count_value, count_reg, location.index);
    add_to_field(meta_count.count_value,1);
    register_write(count_reg, location.index, meta_count.count_value);
}





/*接下来就是vector的加减*，也得定义一个元元数据去作为中间量*/

header_type sml_vector_meta_t { 
    fields { 
        meta_vector_1: 32; 
        meta_vector_2: 32; 
        meta_vector_3: 32; 
        meta_vector_4: 32; 
        meta_vector_5: 32; 
        meta_vector_6: 32; 
        meta_vector_7: 32; 
        meta_vector_8: 32; 
        meta_vector_9: 32; 
        meta_vector_10: 32; 
        meta_vector_11: 32; 
        meta_vector_12: 32; 
        meta_vector_13: 32; 
        meta_vector_14: 32; 
        meta_vector_15: 32; 
        meta_vector_16: 32; 
        meta_vector_17: 32; 
        meta_vector_18: 32; 
        meta_vector_19: 32; 
        meta_vector_20: 32; 
        meta_vector_21: 32; 
        meta_vector_22: 32; 
        meta_vector_23: 32; 
        meta_vector_24: 32; 
        meta_vector_25: 32; 
        meta_vector_26: 32; 
        meta_vector_27: 32; 
        meta_vector_28: 32; 
        meta_vector_29: 32; 
        meta_vector_30: 32; 
        meta_vector_31: 32; 
        meta_vector_32: 32; 
    } 
} 
metadata sml_vector_meta_t sml_vector_meta;



/*聚合操作的表和action，取出值至元数据，调整元数据，再将值存入寄存器*/
action vector_add_1_act() { 
    register_read(sml_vector_meta.meta_vector_1, vector_1_reg, location.index); 
    add_to_field(sml_vector_meta.meta_vector_1,sml_vector.vector_1); 
    register_write(vector_1_reg, location.index, sml_vector_meta.meta_vector_1);
}
action vector_add_2_act() { 
    register_read(sml_vector_meta.meta_vector_2, vector_2_reg, location.index); 
    add_to_field(sml_vector_meta.meta_vector_2,sml_vector.vector_2); 
    register_write(vector_2_reg, location.index, sml_vector_meta.meta_vector_2);
}
action vector_add_3_act() { 
    register_read(sml_vector_meta.meta_vector_3, vector_3_reg, location.index); 
    add_to_field(sml_vector_meta.meta_vector_3,sml_vector.vector_3); 
    register_write(vector_3_reg, location.index, sml_vector_meta.meta_vector_3);
}
action vector_add_4_act() { 
    register_read(sml_vector_meta.meta_vector_4, vector_4_reg, location.index); 
    add_to_field(sml_vector_meta.meta_vector_4,sml_vector.vector_4); 
    register_write(vector_4_reg, location.index, sml_vector_meta.meta_vector_4);
}
action vector_add_5_act() { 
    register_read(sml_vector_meta.meta_vector_5, vector_5_reg, location.index); 
    add_to_field(sml_vector_meta.meta_vector_5,sml_vector.vector_5); 
    register_write(vector_5_reg, location.index, sml_vector_meta.meta_vector_5);
}
action vector_add_6_act() { 
    register_read(sml_vector_meta.meta_vector_6, vector_6_reg, location.index); 
    add_to_field(sml_vector_meta.meta_vector_6,sml_vector.vector_6); 
    register_write(vector_6_reg, location.index, sml_vector_meta.meta_vector_6);
}
action vector_add_7_act() { 
    register_read(sml_vector_meta.meta_vector_7, vector_7_reg, location.index); 
    add_to_field(sml_vector_meta.meta_vector_7,sml_vector.vector_7); 
    register_write(vector_7_reg, location.index, sml_vector_meta.meta_vector_7);
}
action vector_add_8_act() { 
    register_read(sml_vector_meta.meta_vector_8, vector_8_reg, location.index); 
    add_to_field(sml_vector_meta.meta_vector_8,sml_vector.vector_8); 
    register_write(vector_8_reg, location.index, sml_vector_meta.meta_vector_8);
}
action vector_add_9_act() { 
    register_read(sml_vector_meta.meta_vector_9, vector_9_reg, location.index); 
    add_to_field(sml_vector_meta.meta_vector_9,sml_vector.vector_9); 
    register_write(vector_9_reg, location.index, sml_vector_meta.meta_vector_9);
}
action vector_add_10_act() { 
    register_read(sml_vector_meta.meta_vector_10, vector_10_reg, location.index); 
    add_to_field(sml_vector_meta.meta_vector_10,sml_vector.vector_10); 
    register_write(vector_10_reg, location.index, sml_vector_meta.meta_vector_10);
}
action vector_add_11_act() { 
    register_read(sml_vector_meta.meta_vector_11, vector_11_reg, location.index); 
    add_to_field(sml_vector_meta.meta_vector_11,sml_vector.vector_11); 
    register_write(vector_11_reg, location.index, sml_vector_meta.meta_vector_11);
}
action vector_add_12_act() { 
    register_read(sml_vector_meta.meta_vector_12, vector_12_reg, location.index); 
    add_to_field(sml_vector_meta.meta_vector_12,sml_vector.vector_12); 
    register_write(vector_12_reg, location.index, sml_vector_meta.meta_vector_12);
}
action vector_add_13_act() { 
    register_read(sml_vector_meta.meta_vector_13, vector_13_reg, location.index); 
    add_to_field(sml_vector_meta.meta_vector_13,sml_vector.vector_13); 
    register_write(vector_13_reg, location.index, sml_vector_meta.meta_vector_13);
}
action vector_add_14_act() { 
    register_read(sml_vector_meta.meta_vector_14, vector_14_reg, location.index); 
    add_to_field(sml_vector_meta.meta_vector_14,sml_vector.vector_14); 
    register_write(vector_14_reg, location.index, sml_vector_meta.meta_vector_14);
}
action vector_add_15_act() { 
    register_read(sml_vector_meta.meta_vector_15, vector_15_reg, location.index); 
    add_to_field(sml_vector_meta.meta_vector_15,sml_vector.vector_15); 
    register_write(vector_15_reg, location.index, sml_vector_meta.meta_vector_15);
}
action vector_add_16_act() { 
    register_read(sml_vector_meta.meta_vector_16, vector_16_reg, location.index); 
    add_to_field(sml_vector_meta.meta_vector_16,sml_vector.vector_16); 
    register_write(vector_16_reg, location.index, sml_vector_meta.meta_vector_16);
}
action vector_add_17_act() { 
    register_read(sml_vector_meta.meta_vector_17, vector_17_reg, location.index); 
    add_to_field(sml_vector_meta.meta_vector_17,sml_vector.vector_17); 
    register_write(vector_17_reg, location.index, sml_vector_meta.meta_vector_17);
}
action vector_add_18_act() { 
    register_read(sml_vector_meta.meta_vector_18, vector_18_reg, location.index); 
    add_to_field(sml_vector_meta.meta_vector_18,sml_vector.vector_18); 
    register_write(vector_18_reg, location.index, sml_vector_meta.meta_vector_18);
}
action vector_add_19_act() { 
    register_read(sml_vector_meta.meta_vector_19, vector_19_reg, location.index); 
    add_to_field(sml_vector_meta.meta_vector_19,sml_vector.vector_19); 
    register_write(vector_19_reg, location.index, sml_vector_meta.meta_vector_19);
}
action vector_add_20_act() { 
    register_read(sml_vector_meta.meta_vector_20, vector_20_reg, location.index); 
    add_to_field(sml_vector_meta.meta_vector_20,sml_vector.vector_20); 
    register_write(vector_20_reg, location.index, sml_vector_meta.meta_vector_20);
}
action vector_add_21_act() { 
    register_read(sml_vector_meta.meta_vector_21, vector_21_reg, location.index); 
    add_to_field(sml_vector_meta.meta_vector_21,sml_vector.vector_21); 
    register_write(vector_21_reg, location.index, sml_vector_meta.meta_vector_21);
}
action vector_add_22_act() { 
    register_read(sml_vector_meta.meta_vector_22, vector_22_reg, location.index); 
    add_to_field(sml_vector_meta.meta_vector_22,sml_vector.vector_22); 
    register_write(vector_22_reg, location.index, sml_vector_meta.meta_vector_22);
}
action vector_add_23_act() { 
    register_read(sml_vector_meta.meta_vector_23, vector_23_reg, location.index); 
    add_to_field(sml_vector_meta.meta_vector_23,sml_vector.vector_23); 
    register_write(vector_23_reg, location.index, sml_vector_meta.meta_vector_23);
}
action vector_add_24_act() { 
    register_read(sml_vector_meta.meta_vector_24, vector_24_reg, location.index); 
    add_to_field(sml_vector_meta.meta_vector_24,sml_vector.vector_24); 
    register_write(vector_24_reg, location.index, sml_vector_meta.meta_vector_24);
}
action vector_add_25_act() { 
    register_read(sml_vector_meta.meta_vector_25, vector_25_reg, location.index); 
    add_to_field(sml_vector_meta.meta_vector_25,sml_vector.vector_25); 
    register_write(vector_25_reg, location.index, sml_vector_meta.meta_vector_25);
}
action vector_add_26_act() { 
    register_read(sml_vector_meta.meta_vector_26, vector_26_reg, location.index); 
    add_to_field(sml_vector_meta.meta_vector_26,sml_vector.vector_26); 
    register_write(vector_26_reg, location.index, sml_vector_meta.meta_vector_26);
}
action vector_add_27_act() { 
    register_read(sml_vector_meta.meta_vector_27, vector_27_reg, location.index); 
    add_to_field(sml_vector_meta.meta_vector_27,sml_vector.vector_27); 
    register_write(vector_27_reg, location.index, sml_vector_meta.meta_vector_27);
}
action vector_add_28_act() { 
    register_read(sml_vector_meta.meta_vector_28, vector_28_reg, location.index); 
    add_to_field(sml_vector_meta.meta_vector_28,sml_vector.vector_28); 
    register_write(vector_28_reg, location.index, sml_vector_meta.meta_vector_28);
}
action vector_add_29_act() { 
    register_read(sml_vector_meta.meta_vector_29, vector_29_reg, location.index); 
    add_to_field(sml_vector_meta.meta_vector_29,sml_vector.vector_29); 
    register_write(vector_29_reg, location.index, sml_vector_meta.meta_vector_29);
}
action vector_add_30_act() { 
    register_read(sml_vector_meta.meta_vector_30, vector_30_reg, location.index); 
    add_to_field(sml_vector_meta.meta_vector_30,sml_vector.vector_30); 
    register_write(vector_30_reg, location.index, sml_vector_meta.meta_vector_30);
}
action vector_add_31_act() { 
    register_read(sml_vector_meta.meta_vector_31, vector_31_reg, location.index); 
    add_to_field(sml_vector_meta.meta_vector_31,sml_vector.vector_31); 
    register_write(vector_31_reg, location.index, sml_vector_meta.meta_vector_31);
}
action vector_add_32_act() { 
    register_read(sml_vector_meta.meta_vector_32, vector_32_reg, location.index); 
    add_to_field(sml_vector_meta.meta_vector_32,sml_vector.vector_32); 
    register_write(vector_32_reg, location.index, sml_vector_meta.meta_vector_32);
}


table vector_add_1 { 
    actions { 
        vector_add_1_act;        
    } 
}
table vector_add_2 { 
    actions { 
        vector_add_2_act;        
    } 
}
table vector_add_3 { 
    actions { 
        vector_add_3_act;        
    } 
}
table vector_add_4 { 
    actions { 
        vector_add_4_act;        
    } 
}
table vector_add_5 { 
    actions { 
        vector_add_5_act;        
    } 
}
table vector_add_6 { 
    actions { 
        vector_add_6_act;        
    } 
}
table vector_add_7 { 
    actions { 
        vector_add_7_act;        
    } 
}
table vector_add_8 { 
    actions { 
        vector_add_8_act;        
    } 
}
table vector_add_9 { 
    actions { 
        vector_add_9_act;        
    } 
}
table vector_add_10 { 
    actions { 
        vector_add_10_act;        
    } 
}
table vector_add_11 { 
    actions { 
        vector_add_11_act;        
    } 
}
table vector_add_12 { 
    actions { 
        vector_add_12_act;        
    } 
}
table vector_add_13 { 
    actions { 
        vector_add_13_act;        
    } 
}
table vector_add_14 { 
    actions { 
        vector_add_14_act;        
    } 
}
table vector_add_15 { 
    actions { 
        vector_add_15_act;        
    } 
}
table vector_add_16 { 
    actions { 
        vector_add_16_act;        
    } 
}

table vector_add_17 { 
    actions { 
        vector_add_17_act;        
    } 
}
table vector_add_18 { 
    actions { 
        vector_add_18_act;        
    } 
}
table vector_add_19 { 
    actions { 
        vector_add_19_act;        
    } 
}
table vector_add_20 { 
    actions { 
        vector_add_20_act;        
    } 
}
table vector_add_21 { 
    actions { 
        vector_add_21_act;        
    } 
}
table vector_add_22 { 
    actions { 
        vector_add_22_act;        
    } 
}
table vector_add_23 { 
    actions { 
        vector_add_23_act;        
    } 
}
table vector_add_24 { 
    actions { 
        vector_add_24_act;        
    } 
}
table vector_add_25 { 
    actions { 
        vector_add_25_act;        
    } 
}
table vector_add_26 { 
    actions { 
        vector_add_26_act;        
    } 
}
table vector_add_27 { 
    actions { 
        vector_add_27_act;        
    } 
}
table vector_add_28 { 
    actions { 
        vector_add_28_act;        
    } 
}
table vector_add_29 { 
    actions { 
        vector_add_29_act;        
    } 
}
table vector_add_30 { 
    actions { 
        vector_add_30_act;        
    } 
}
table vector_add_31 { 
    actions { 
        vector_add_31_act;        
    } 
}
table vector_add_32 { 
    actions { 
        vector_add_32_act;        
    } 
}


/*接下来是在count等于主机数的时候，需要将数据写到包里面*，并且可以把寄存器的值置0了*/


action vector_read_1_act() { 
    register_read(sml_vector.vector_1, vector_1_reg, location.index); 
    register_write(vector_1_reg, location.index, 0); 
}
action vector_read_2_act() { 
    register_read(sml_vector.vector_2, vector_2_reg, location.index); 
    register_write(vector_2_reg, location.index, 0); 
}
action vector_read_3_act() { 
    register_read(sml_vector.vector_3, vector_3_reg, location.index); 
    register_write(vector_3_reg, location.index, 0); 
}
action vector_read_4_act() { 
    register_read(sml_vector.vector_4, vector_4_reg, location.index); 
    register_write(vector_4_reg, location.index, 0); 
}

action vector_read_5_act() { 
    register_read(sml_vector.vector_5, vector_5_reg, location.index); 
    register_write(vector_5_reg, location.index, 0); 
}
action vector_read_6_act() { 
    register_read(sml_vector.vector_6, vector_6_reg, location.index); 
    register_write(vector_6_reg, location.index, 0); 
}
action vector_read_7_act() { 
    register_read(sml_vector.vector_7, vector_7_reg, location.index); 
    register_write(vector_7_reg, location.index, 0); 
}
action vector_read_8_act() { 
    register_read(sml_vector.vector_8, vector_8_reg, location.index); 
    register_write(vector_8_reg, location.index, 0); 
}

action vector_read_9_act() { 
    register_read(sml_vector.vector_9, vector_9_reg, location.index); 
    register_write(vector_9_reg, location.index, 0); 
}
action vector_read_10_act() { 
    register_read(sml_vector.vector_10, vector_10_reg, location.index); 
    register_write(vector_10_reg, location.index, 0); 
}
action vector_read_11_act() { 
    register_read(sml_vector.vector_11, vector_11_reg, location.index); 
    register_write(vector_11_reg, location.index, 0); 
}
action vector_read_12_act() { 
    register_read(sml_vector.vector_12, vector_12_reg, location.index); 
    register_write(vector_12_reg, location.index, 0); 
}

action vector_read_13_act() { 
    register_read(sml_vector.vector_13, vector_13_reg, location.index); 
    register_write(vector_13_reg, location.index, 0); 
}
action vector_read_14_act() { 
    register_read(sml_vector.vector_14, vector_14_reg, location.index); 
    register_write(vector_14_reg, location.index, 0); 
}
action vector_read_15_act() { 
    register_read(sml_vector.vector_15, vector_15_reg, location.index); 
    register_write(vector_15_reg, location.index, 0); 
}
action vector_read_16_act() { 
    register_read(sml_vector.vector_16, vector_16_reg, location.index); 
    register_write(vector_16_reg, location.index, 0); 
}
action vector_read_17_act() { 
    register_read(sml_vector.vector_17, vector_17_reg, location.index); 
    register_write(vector_17_reg, location.index, 0); 
}
action vector_read_18_act() { 
    register_read(sml_vector.vector_18, vector_18_reg, location.index); 
    register_write(vector_18_reg, location.index, 0); 
}
action vector_read_19_act() { 
    register_read(sml_vector.vector_19, vector_19_reg, location.index); 
    register_write(vector_19_reg, location.index, 0); 
}
action vector_read_20_act() { 
    register_read(sml_vector.vector_20, vector_20_reg, location.index); 
    register_write(vector_20_reg, location.index, 0); 
}

action vector_read_21_act() { 
    register_read(sml_vector.vector_21, vector_21_reg, location.index); 
    register_write(vector_21_reg, location.index, 0); 
}
action vector_read_22_act() { 
    register_read(sml_vector.vector_22, vector_22_reg, location.index); 
    register_write(vector_22_reg, location.index, 0); 
}
action vector_read_23_act() { 
    register_read(sml_vector.vector_23, vector_23_reg, location.index); 
    register_write(vector_23_reg, location.index, 0); 
}
action vector_read_24_act() { 
    register_read(sml_vector.vector_24, vector_24_reg, location.index); 
    register_write(vector_24_reg, location.index, 0); 
}

action vector_read_25_act() { 
    register_read(sml_vector.vector_25, vector_25_reg, location.index); 
    register_write(vector_25_reg, location.index, 0); 
}
action vector_read_26_act() { 
    register_read(sml_vector.vector_26, vector_26_reg, location.index); 
    register_write(vector_26_reg, location.index, 0); 
}
action vector_read_27_act() { 
    register_read(sml_vector.vector_27, vector_27_reg, location.index); 
    register_write(vector_27_reg, location.index, 0); 
}
action vector_read_28_act() { 
    register_read(sml_vector.vector_28, vector_28_reg, location.index); 
    register_write(vector_28_reg, location.index, 0); 
}

action vector_read_29_act() { 
    register_read(sml_vector.vector_29, vector_29_reg, location.index); 
    register_write(vector_29_reg, location.index, 0); 
}
action vector_read_30_act() { 
    register_read(sml_vector.vector_30, vector_30_reg, location.index); 
    register_write(vector_30_reg, location.index, 0); 
}
action vector_read_31_act() { 
    register_read(sml_vector.vector_31, vector_31_reg, location.index); 
    register_write(vector_31_reg, location.index, 0); 
}
action vector_read_32_act() { 
    register_read(sml_vector.vector_32, vector_32_reg, location.index); 
    register_write(vector_32_reg, location.index, 0); 
}


table vector_read_1 { 
    actions { 
        vector_read_1_act; 
    } 
}


table vector_read_2 { 
    actions { 
        vector_read_2_act; 
    } 
}
table vector_read_3 { 
    actions { 
        vector_read_3_act; 
    } 
}
table vector_read_4 { 
    actions { 
        vector_read_4_act; 
    } 
}
table vector_read_5 { 
    actions { 
        vector_read_5_act; 
    } 
}

table vector_read_6 { 
    actions { 
        vector_read_6_act; 
    } 
}
table vector_read_7 { 
    actions { 
        vector_read_7_act; 
    } 
}
table vector_read_8 { 
    actions { 
        vector_read_8_act; 
    } 
}
table vector_read_9 { 
    actions { 
        vector_read_9_act; 
    } 
}

table vector_read_10 { 
    actions { 
        vector_read_10_act; 
    } 
}
table vector_read_11 { 
    actions { 
        vector_read_11_act; 
    } 
}
table vector_read_12 { 
    actions { 
        vector_read_12_act; 
    } 
}
table vector_read_13 { 
    actions { 
        vector_read_13_act; 
    } 
}

table vector_read_14 { 
    actions { 
        vector_read_14_act; 
    } 
}
table vector_read_15 { 
    actions { 
        vector_read_15_act; 
    } 
}
table vector_read_16 { 
    actions { 
        vector_read_16_act; 
    } 
}
table vector_read_17 { 
    actions { 
        vector_read_17_act; 
    } 
}

table vector_read_18 { 
    actions { 
        vector_read_18_act; 
    } 
}
table vector_read_19 { 
    actions { 
        vector_read_19_act; 
    } 
}
table vector_read_20 { 
    actions { 
        vector_read_20_act; 
    } 
}
table vector_read_21 { 
    actions { 
        vector_read_21_act; 
    } 
}

table vector_read_22 { 
    actions { 
        vector_read_22_act; 
    } 
}
table vector_read_23 { 
    actions { 
        vector_read_23_act; 
    } 
}
table vector_read_24 { 
    actions { 
        vector_read_24_act; 
    } 
}
table vector_read_25 { 
    actions { 
        vector_read_25_act; 
    } 
}

table vector_read_26 { 
    actions { 
        vector_read_26_act; 
    } 
}
table vector_read_27 { 
    actions { 
        vector_read_27_act; 
    } 
}
table vector_read_28 { 
    actions { 
        vector_read_28_act; 
    } 
}
table vector_read_29 { 
    actions { 
        vector_read_29_act; 
    } 
}

table vector_read_30 { 
    actions { 
        vector_read_30_act; 
    } 
}
table vector_read_31 { 
    actions { 
        vector_read_31_act; 
    } 
}

table vector_read_32 { 
    actions { 
        vector_read_32_act; 
    } 
}




/*
在count等于主机数的情况下，把寄存器存的读取到包里
，还需要将寄存器里的值以及count的值置为0，为了以后调试，
还是分开写。
*/

action set_count_to_zero_act() { 
    register_write(count_reg, location.index,0); 
} 



table set_count_to_zero{ 
    actions{ 
         set_count_to_zero_act; 
    } 
}




/*丢弃包的部分，当然也是并行的，table和action*/
action drop_packet_act() { 
    drop();
}



table drop_packet { 
    actions { 
        drop_packet_act; 
    } 
}


/*其实就是将上面整个流程串起来的 process_vector*/

    control process_vector { 
    apply(vector_add_1); 
    apply(vector_add_2); 
    apply(vector_add_3); 
    apply(vector_add_4); 
    apply(vector_add_5); 
    apply(vector_add_6); 
    apply(vector_add_7); 
    apply(vector_add_8); 
    apply(vector_add_9); 
    apply(vector_add_10);
    apply(vector_add_11); 
    apply(vector_add_12); 
    apply(vector_add_13); 
    apply(vector_add_14); 
    apply(vector_add_15); 
    apply(vector_add_16); 
    apply(vector_add_17); 
    apply(vector_add_18); 
    apply(vector_add_19); 
    apply(vector_add_20); 
    apply(vector_add_21); 
    apply(vector_add_22); 
    apply(vector_add_23); 
    apply(vector_add_24); 
    apply(vector_add_25); 
    apply(vector_add_26); 
    apply(vector_add_27); 
    apply(vector_add_28); 
    apply(vector_add_29); 
    apply(vector_add_30); 
    apply(vector_add_31); 
    apply(vector_add_32); 
    apply(count_add); 
    if(meta_count.count_value==2) { 
        apply(vector_read_1); 
        apply(vector_read_2); 
        apply(vector_read_3); 
        apply(vector_read_4); 
        apply(vector_read_5); 
        apply(vector_read_6); 
        apply(vector_read_7); 
        apply(vector_read_8); 
        apply(vector_read_9); 
        apply(vector_read_10); 
        apply(vector_read_11); 
        apply(vector_read_12); 
        apply(vector_read_13); 
        apply(vector_read_14); 
        apply(vector_read_15); 
        apply(vector_read_16); 
        apply(vector_read_17); 
        apply(vector_read_18); 
        apply(vector_read_19); 
        apply(vector_read_20); 
        apply(vector_read_21); 
        apply(vector_read_22); 
        apply(vector_read_23); 
        apply(vector_read_24); 
        apply(vector_read_25); 
        apply(vector_read_26); 
        apply(vector_read_27); 
        apply(vector_read_28); 
        apply(vector_read_29); 
        apply(vector_read_30); 
        apply(vector_read_31); 
        apply(vector_read_32); 
        apply(set_count_to_zero); 
    } 

}
  /*  else{ 
        apply(drop_packet); 
    }
*/









/*主逻辑相当于主函数的部分，突出一个并行*/
control process_aggregation {   
 
    process_vector();

    
}






