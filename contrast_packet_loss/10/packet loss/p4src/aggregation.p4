/*主程序，定义寄存器，元数据，各种action，以及处理的逻辑*/

/*寄存器*/
/*存储vector的寄存器 pool*/
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

/*count的寄存器*/
register count_reg { 
    width: 8; 
    instance_count: CACHE_NUM; 
}


/*seen的寄存器*/
register seen_reg{
	width: 8;
	instance_count: CACHE_NUM;
}


/*元数据*/
/*count的元数据*/
header_type meta_count_t { 
    fields { 
        count_value: 8; 
    } 
}
metadata meta_count_t meta_count;

/*vector的元数据*/
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

/*seen的元数据*/
header_type meta_seen_t { 
    fields { 
        seen_value: 8; 
    } 
}
metadata meta_seen_t meta_seen;

/*有一个元数据来表示最后是单播还是多播*/
header_type singleorm_t {
    fields {
        state: 16;
    }
}
metadata singleorm_t singleorm;




/*读取seen，以及count的表和动作*/
/*读取count*/
table count_read { 
    actions { 
        count_read_act; 
    } 
}

action count_read_act() { 
    register_read(meta_count.count_value, count_reg, pclocation.index);
}


/*读取seen*/
table seen_read { 
    actions { 
        seen_read_act; 
    } 
}

action seen_read_act() { 
    register_read(meta_seen.seen_value, seen_reg, seenlocation.index);
}

/*与seen有关的赋值动作*/
/*seen置1*/
table seen_set1 { 
    actions { 
        seen_set1_act; 
    } 
}

action seen_set1_act() { 
    register_write(seen_reg, seenlocation.index, 1);
}


/*seen置0，将!ver置0*/
table seen_set0 { 
    actions { 
        seen_set0_act; 
    } 
}

action seen_set0_act() { 
    register_write(seen_reg, seenlocation1.index,0);
}

/*singleorm的置0(单播)，置1(多播)操作*/
/*置0的表与action*/
table singleorm_set0 { 
    actions { 
        singleorm_set0_act; 
    } 
}

action singleorm_set0_act() { 
    modify_field(singleorm.state, 0);
}

/*singleorm置1的table和action*/
table singleorm_set1 { 
    actions { 
        singleorm_set1_act; 
    } 
}

action singleorm_set1_act() { 
    modify_field(singleorm.state, 1);
}

/*singleorm置2,3的table和action,2,3diubao*/
table singleorm_set2 { 
    actions { 
        singleorm_set2_act; 
    } 
}

action singleorm_set2_act() { 
    modify_field(singleorm.state, 2);
}

table singleorm_set3 { 
    actions { 
        singleorm_set3_act; 
    } 
}

action singleorm_set3_act() { 
    modify_field(singleorm.state, 3);
}






/*count的操作*/
/*count循环自增*/
table count_add { 
    actions { 
        count_add_act; 
    } 
}

action count_add_act() { 
    register_read(meta_count.count_value, count_reg, pclocation.index);
    modify_field(meta_count.count_value,(meta_count.count_value+1)%WORKER_NUM);
    register_write(count_reg, pclocation.index, meta_count.count_value);
}


/*vector的读取，对寄存器的赋值，累加的table与action*/

table vector_read_1_1 { 
    actions { 
        vector_read_1_act; 
    } 
}

/*读的表与action*/
table vector_read_1_2 { 
    actions { 
        vector_read_2_act; 
    } 
}
table vector_read_1_3 { 
    actions { 
        vector_read_3_act; 
    } 
}
table vector_read_1_4 { 
    actions { 
        vector_read_4_act; 
    } 
}
table vector_read_1_5 { 
    actions { 
        vector_read_5_act; 
    } 
}

table vector_read_1_6 { 
    actions { 
        vector_read_6_act; 
    } 
}
table vector_read_1_7 { 
    actions { 
        vector_read_7_act; 
    } 
}
table vector_read_1_8 { 
    actions { 
        vector_read_8_act; 
    } 
}
table vector_read_1_9 { 
    actions { 
        vector_read_9_act; 
    } 
}

table vector_read_1_10 { 
    actions { 
        vector_read_10_act; 
    } 
}
table vector_read_1_11 { 
    actions { 
        vector_read_11_act; 
    } 
}
table vector_read_1_12 { 
    actions { 
        vector_read_12_act; 
    } 
}
table vector_read_1_13 { 
    actions { 
        vector_read_13_act; 
    } 
}

table vector_read_1_14 { 
    actions { 
        vector_read_14_act; 
    } 
}
table vector_read_1_15 { 
    actions { 
        vector_read_15_act; 
    } 
}
table vector_read_1_16 { 
    actions { 
        vector_read_16_act; 
    } 
}
table vector_read_1_17 { 
    actions { 
        vector_read_17_act; 
    } 
}

table vector_read_1_18 { 
    actions { 
        vector_read_18_act; 
    } 
}
table vector_read_1_19 { 
    actions { 
        vector_read_19_act; 
    } 
}
table vector_read_1_20 { 
    actions { 
        vector_read_20_act; 
    } 
}
table vector_read_1_21 { 
    actions { 
        vector_read_21_act; 
    } 
}

table vector_read_1_22 { 
    actions { 
        vector_read_22_act; 
    } 
}
table vector_read_1_23 { 
    actions { 
        vector_read_23_act; 
    } 
}
table vector_read_1_24 { 
    actions { 
        vector_read_24_act; 
    } 
}
table vector_read_1_25 { 
    actions { 
        vector_read_25_act; 
    } 
}

table vector_read_1_26 { 
    actions { 
        vector_read_26_act; 
    } 
}
table vector_read_1_27 { 
    actions { 
        vector_read_27_act; 
    } 
}
table vector_read_1_28 { 
    actions { 
        vector_read_28_act; 
    } 
}
table vector_read_1_29 { 
    actions { 
        vector_read_29_act; 
    } 
}

table vector_read_1_30 { 
    actions { 
        vector_read_30_act; 
    } 
}
table vector_read_1_31 { 
    actions { 
        vector_read_31_act; 
    } 
}

table vector_read_1_32 { 
    actions { 
        vector_read_32_act; 
    } 
}

table vector_read_2_1 { 
    actions { 
        vector_read_1_act; 
    } 
}
table vector_read_2_2 { 
    actions { 
        vector_read_2_act; 
    } 
}
table vector_read_2_3 { 
    actions { 
        vector_read_3_act; 
    } 
}
table vector_read_2_4 { 
    actions { 
        vector_read_4_act; 
    } 
}
table vector_read_2_5 { 
    actions { 
        vector_read_5_act; 
    } 
}

table vector_read_2_6 { 
    actions { 
        vector_read_6_act; 
    } 
}
table vector_read_2_7 { 
    actions { 
        vector_read_7_act; 
    } 
}
table vector_read_2_8 { 
    actions { 
        vector_read_8_act; 
    } 
}
table vector_read_2_9 { 
    actions { 
        vector_read_9_act; 
    } 
}

table vector_read_2_10 { 
    actions { 
        vector_read_10_act; 
    } 
}
table vector_read_2_11 { 
    actions { 
        vector_read_11_act; 
    } 
}
table vector_read_2_12 { 
    actions { 
        vector_read_12_act; 
    } 
}
table vector_read_2_13 { 
    actions { 
        vector_read_13_act; 
    } 
}

table vector_read_2_14 { 
    actions { 
        vector_read_14_act; 
    } 
}
table vector_read_2_15 { 
    actions { 
        vector_read_15_act; 
    } 
}
table vector_read_2_16 { 
    actions { 
        vector_read_16_act; 
    } 
}
table vector_read_2_17 { 
    actions { 
        vector_read_17_act; 
    } 
}

table vector_read_2_18 { 
    actions { 
        vector_read_18_act; 
    } 
}
table vector_read_2_19 { 
    actions { 
        vector_read_19_act; 
    } 
}
table vector_read_2_20 { 
    actions { 
        vector_read_20_act; 
    } 
}
table vector_read_2_21 { 
    actions { 
        vector_read_21_act; 
    } 
}

table vector_read_2_22 { 
    actions { 
        vector_read_22_act; 
    } 
}
table vector_read_2_23 { 
    actions { 
        vector_read_23_act; 
    } 
}
table vector_read_2_24 { 
    actions { 
        vector_read_24_act; 
    } 
}
table vector_read_2_25 { 
    actions { 
        vector_read_25_act; 
    } 
}

table vector_read_2_26 { 
    actions { 
        vector_read_26_act; 
    } 
}
table vector_read_2_27 { 
    actions { 
        vector_read_27_act; 
    } 
}
table vector_read_2_28 { 
    actions { 
        vector_read_28_act; 
    } 
}
table vector_read_2_29 { 
    actions { 
        vector_read_29_act; 
    } 
}

table vector_read_2_30 { 
    actions { 
        vector_read_30_act; 
    } 
}
table vector_read_2_31 { 
    actions { 
        vector_read_31_act; 
    } 
}

table vector_read_2_32 { 
    actions { 
        vector_read_32_act; 
    } 
}




action vector_read_1_act() { 
    register_read(sml_vector.vector_1, vector_1_reg, pclocation.index); 


}
action vector_read_2_act() { 
    register_read(sml_vector.vector_2, vector_2_reg, pclocation.index); 
}
action vector_read_3_act() { 
    register_read(sml_vector.vector_3, vector_3_reg, pclocation.index); 
}
action vector_read_4_act() { 
    register_read(sml_vector.vector_4, vector_4_reg, pclocation.index); 
}

action vector_read_5_act() { 
    register_read(sml_vector.vector_5, vector_5_reg, pclocation.index); 
}
action vector_read_6_act() { 
    register_read(sml_vector.vector_6, vector_6_reg, pclocation.index);  
}
action vector_read_7_act() { 
    register_read(sml_vector.vector_7, vector_7_reg, pclocation.index); 
}
action vector_read_8_act() { 
    register_read(sml_vector.vector_8, vector_8_reg, pclocation.index); 
}

action vector_read_9_act() { 
    register_read(sml_vector.vector_9, vector_9_reg, pclocation.index); 
}
action vector_read_10_act() { 
    register_read(sml_vector.vector_10, vector_10_reg, pclocation.index); 
}
action vector_read_11_act() { 
    register_read(sml_vector.vector_11, vector_11_reg, pclocation.index); 
}
action vector_read_12_act() { 
    register_read(sml_vector.vector_12, vector_12_reg, pclocation.index); 
}

action vector_read_13_act() { 
    register_read(sml_vector.vector_13, vector_13_reg, pclocation.index); 
}
action vector_read_14_act() { 
    register_read(sml_vector.vector_14, vector_14_reg, pclocation.index); 
}
action vector_read_15_act() { 
    register_read(sml_vector.vector_15, vector_15_reg, pclocation.index); 
}
action vector_read_16_act() { 
    register_read(sml_vector.vector_16, vector_16_reg, pclocation.index); 
}
action vector_read_17_act() { 
    register_read(sml_vector.vector_17, vector_17_reg, pclocation.index); 
}
action vector_read_18_act() { 
    register_read(sml_vector.vector_18, vector_18_reg, pclocation.index); 
}
action vector_read_19_act() { 
    register_read(sml_vector.vector_19, vector_19_reg, pclocation.index); 
}
action vector_read_20_act() { 
    register_read(sml_vector.vector_20, vector_20_reg, pclocation.index); 
}

action vector_read_21_act() { 
    register_read(sml_vector.vector_21, vector_21_reg, pclocation.index); 
}
action vector_read_22_act() { 
    register_read(sml_vector.vector_22, vector_22_reg, pclocation.index); 
}
action vector_read_23_act() { 
    register_read(sml_vector.vector_23, vector_23_reg, pclocation.index); 
}
action vector_read_24_act() { 
    register_read(sml_vector.vector_24, vector_24_reg, pclocation.index); 
}

action vector_read_25_act() { 
    register_read(sml_vector.vector_25, vector_25_reg, pclocation.index); 
}
action vector_read_26_act() { 
    register_read(sml_vector.vector_26, vector_26_reg, pclocation.index); 
}
action vector_read_27_act() { 
    register_read(sml_vector.vector_27, vector_27_reg, pclocation.index); 
}
action vector_read_28_act() { 
    register_read(sml_vector.vector_28, vector_28_reg, pclocation.index); 
}

action vector_read_29_act() { 
    register_read(sml_vector.vector_29, vector_29_reg, pclocation.index);  
}
action vector_read_30_act() { 
    register_read(sml_vector.vector_30, vector_30_reg, pclocation.index); 
}
action vector_read_31_act() { 
    register_read(sml_vector.vector_31, vector_31_reg, pclocation.index);  
}
action vector_read_32_act() { 
    register_read(sml_vector.vector_32, vector_32_reg, pclocation.index); 
}

/*vector_read综合到一起*/
control vector_read_1 {
    apply(vector_read_1_1); 
    apply(vector_read_1_2); 
    apply(vector_read_1_3); 
    apply(vector_read_1_4); 
    apply(vector_read_1_5); 
    apply(vector_read_1_6); 
    apply(vector_read_1_7); 
    apply(vector_read_1_8); 
    apply(vector_read_1_9); 
    apply(vector_read_1_10); 
    apply(vector_read_1_11); 
    apply(vector_read_1_12); 
    apply(vector_read_1_13); 
    apply(vector_read_1_14); 
    apply(vector_read_1_15); 
    apply(vector_read_1_16); 
    apply(vector_read_1_17); 
    apply(vector_read_1_18); 
    apply(vector_read_1_19); 
    apply(vector_read_1_20); 
    apply(vector_read_1_21); 
    apply(vector_read_1_22); 
    apply(vector_read_1_23); 
    apply(vector_read_1_24); 
    apply(vector_read_1_25); 
    apply(vector_read_1_26); 
    apply(vector_read_1_27); 
    apply(vector_read_1_28); 
    apply(vector_read_1_29); 
    apply(vector_read_1_30); 
    apply(vector_read_1_31); 
    apply(vector_read_1_32);      
}

control vector_read_2 {
    apply(vector_read_2_1); 
    apply(vector_read_2_2); 
    apply(vector_read_2_3); 
    apply(vector_read_2_4); 
    apply(vector_read_2_5); 
    apply(vector_read_2_6); 
    apply(vector_read_2_7); 
    apply(vector_read_2_8); 
    apply(vector_read_2_9); 
    apply(vector_read_2_10); 
    apply(vector_read_2_11); 
    apply(vector_read_2_12); 
    apply(vector_read_2_13); 
    apply(vector_read_2_14); 
    apply(vector_read_2_15); 
    apply(vector_read_2_16); 
    apply(vector_read_2_17); 
    apply(vector_read_2_18); 
    apply(vector_read_2_19); 
    apply(vector_read_2_20); 
    apply(vector_read_2_21); 
    apply(vector_read_2_22); 
    apply(vector_read_2_23); 
    apply(vector_read_2_24); 
    apply(vector_read_2_25); 
    apply(vector_read_2_26); 
    apply(vector_read_2_27); 
    apply(vector_read_2_28); 
    apply(vector_read_2_29); 
    apply(vector_read_2_30); 
    apply(vector_read_2_31); 
    apply(vector_read_2_32);      
}

/*存vector*/
table vector_store_1 { 
    actions { 
        vector_store_1_act;        
    } 
}
table vector_store_2 { 
    actions { 
        vector_store_2_act;        
    } 
}
table vector_store_3 { 
    actions { 
        vector_store_3_act;        
    } 
}
table vector_store_4 { 
    actions { 
        vector_store_4_act;        
    } 
}
table vector_store_5 { 
    actions { 
        vector_store_5_act;        
    } 
}
table vector_store_6 { 
    actions { 
        vector_store_6_act;        
    } 
}
table vector_store_7 { 
    actions { 
        vector_store_7_act;        
    } 
}
table vector_store_8 { 
    actions { 
        vector_store_8_act;        
    } 
}
table vector_store_9 { 
    actions { 
        vector_store_9_act;        
    } 
}
table vector_store_10 { 
    actions { 
        vector_store_10_act;        
    } 
}
table vector_store_11 { 
    actions { 
        vector_store_11_act;        
    } 
}
table vector_store_12 { 
    actions { 
        vector_store_12_act;        
    } 
}
table vector_store_13 { 
    actions { 
        vector_store_13_act;        
    } 
}
table vector_store_14 { 
    actions { 
        vector_store_14_act;        
    } 
}
table vector_store_15 { 
    actions { 
        vector_store_15_act;        
    } 
}
table vector_store_16 { 
    actions { 
        vector_store_16_act;        
    } 
}

table vector_store_17 { 
    actions { 
        vector_store_17_act;        
    } 
}
table vector_store_18 { 
    actions { 
        vector_store_18_act;        
    } 
}
table vector_store_19 { 
    actions { 
        vector_store_19_act;        
    } 
}
table vector_store_20 { 
    actions { 
        vector_store_20_act;        
    } 
}
table vector_store_21 { 
    actions { 
        vector_store_21_act;        
    } 
}
table vector_store_22 { 
    actions { 
        vector_store_22_act;        
    } 
}
table vector_store_23 { 
    actions { 
        vector_store_23_act;        
    } 
}
table vector_store_24 { 
    actions { 
        vector_store_24_act;        
    } 
}
table vector_store_25 { 
    actions { 
        vector_store_25_act;        
    } 
}
table vector_store_26 { 
    actions { 
        vector_store_26_act;        
    } 
}
table vector_store_27 { 
    actions { 
        vector_store_27_act;        
    } 
}
table vector_store_28 { 
    actions { 
        vector_store_28_act;        
    } 
}
table vector_store_29 { 
    actions { 
        vector_store_29_act;        
    } 
}
table vector_store_30 { 
    actions { 
        vector_store_30_act;        
    } 
}
table vector_store_31 { 
    actions { 
        vector_store_31_act;        
    } 
}
table vector_store_32 { 
    actions { 
        vector_store_32_act;        
    } 
}

action vector_store_1_act() { 
    register_write(vector_1_reg, pclocation.index, sml_vector.vector_1);
}
action vector_store_2_act() { 
    register_write(vector_2_reg, pclocation.index, sml_vector.vector_2);
}
action vector_store_3_act() { 
    register_write(vector_3_reg, pclocation.index, sml_vector.vector_3);
}
action vector_store_4_act() { 
    register_write(vector_4_reg, pclocation.index, sml_vector.vector_4);
}
action vector_store_5_act() { 
    register_write(vector_5_reg, pclocation.index, sml_vector.vector_5);
}
action vector_store_6_act() { 
    register_write(vector_6_reg, pclocation.index, sml_vector.vector_6);
}
action vector_store_7_act() { 
    register_write(vector_7_reg, pclocation.index, sml_vector.vector_7);
}
action vector_store_8_act() { 
    register_write(vector_8_reg, pclocation.index, sml_vector.vector_8);
}
action vector_store_9_act() { 
    register_write(vector_9_reg, pclocation.index, sml_vector.vector_9);
}
action vector_store_10_act() { 
    register_write(vector_10_reg, pclocation.index, sml_vector.vector_10);
}
action vector_store_11_act() { 
    register_write(vector_11_reg, pclocation.index, sml_vector.vector_11);
}
action vector_store_12_act() { 
    register_write(vector_12_reg, pclocation.index, sml_vector.vector_12);
}
action vector_store_13_act() { 
    register_write(vector_13_reg, pclocation.index, sml_vector.vector_13);
}
action vector_store_14_act() { 
    register_write(vector_14_reg, pclocation.index, sml_vector.vector_14);
}
action vector_store_15_act() { 
    register_write(vector_15_reg, pclocation.index, sml_vector.vector_15);
}
action vector_store_16_act() {  
    register_write(vector_16_reg, pclocation.index, sml_vector.vector_16);
}
action vector_store_17_act() {  
    register_write(vector_17_reg, pclocation.index, sml_vector.vector_17);
}
action vector_store_18_act() { 
    register_write(vector_18_reg, pclocation.index, sml_vector.vector_18);
}
action vector_store_19_act() {  
    register_write(vector_19_reg, pclocation.index, sml_vector.vector_19);
}
action vector_store_20_act() { 
    register_write(vector_20_reg, pclocation.index, sml_vector.vector_20);
}
action vector_store_21_act() {  
    register_write(vector_21_reg, pclocation.index, sml_vector.vector_21);
}
action vector_store_22_act() {  
    register_write(vector_22_reg, pclocation.index, sml_vector.vector_22);
}
action vector_store_23_act() { 
    register_write(vector_23_reg, pclocation.index, sml_vector.vector_23);
}
action vector_store_24_act() { 
    register_write(vector_24_reg, pclocation.index, sml_vector.vector_24);
}
action vector_store_25_act() { 
    register_write(vector_25_reg, pclocation.index, sml_vector.vector_25);
}
action vector_store_26_act() { 
    register_write(vector_26_reg, pclocation.index, sml_vector.vector_26);
}
action vector_store_27_act() { 
    register_write(vector_27_reg, pclocation.index, sml_vector.vector_27);
}
action vector_store_28_act() { 
    register_write(vector_28_reg, pclocation.index, sml_vector.vector_28);
}
action vector_store_29_act() { 
    register_write(vector_29_reg, pclocation.index, sml_vector.vector_29);
}
action vector_store_30_act() { 
    register_write(vector_30_reg, pclocation.index, sml_vector.vector_30);
}
action vector_store_31_act() { 
    register_write(vector_31_reg, pclocation.index, sml_vector.vector_31);
}
action vector_store_32_act() { 
    register_write(vector_32_reg, pclocation.index, sml_vector.vector_32);
}

/*vector_store综合*/
control vector_store {
    apply(vector_store_1); 
    apply(vector_store_2); 
    apply(vector_store_3); 
    apply(vector_store_4); 
    apply(vector_store_5); 
    apply(vector_store_6); 
    apply(vector_store_7); 
    apply(vector_store_8); 
    apply(vector_store_9); 
    apply(vector_store_10);
    apply(vector_store_11); 
    apply(vector_store_12); 
    apply(vector_store_13); 
    apply(vector_store_14); 
    apply(vector_store_15); 
    apply(vector_store_16); 
    apply(vector_store_17); 
    apply(vector_store_18); 
    apply(vector_store_19); 
    apply(vector_store_20); 
    apply(vector_store_21); 
    apply(vector_store_22); 
    apply(vector_store_23); 
    apply(vector_store_24); 
    apply(vector_store_25); 
    apply(vector_store_26); 
    apply(vector_store_27); 
    apply(vector_store_28); 
    apply(vector_store_29); 
    apply(vector_store_30); 
    apply(vector_store_31); 
    apply(vector_store_32);     
}

/*求和并存在寄存器的table和action*/
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

action vector_add_1_act() { 
    register_read(sml_vector_meta.meta_vector_1, vector_1_reg, pclocation.index); 
    add_to_field(sml_vector_meta.meta_vector_1,sml_vector.vector_1); 
    register_write(vector_1_reg, pclocation.index, sml_vector_meta.meta_vector_1);
}
action vector_add_2_act() { 
    register_read(sml_vector_meta.meta_vector_2, vector_2_reg, pclocation.index); 
    add_to_field(sml_vector_meta.meta_vector_2,sml_vector.vector_2); 
    register_write(vector_2_reg, pclocation.index, sml_vector_meta.meta_vector_2);
}
action vector_add_3_act() { 
    register_read(sml_vector_meta.meta_vector_3, vector_3_reg, pclocation.index); 
    add_to_field(sml_vector_meta.meta_vector_3,sml_vector.vector_3); 
    register_write(vector_3_reg, pclocation.index, sml_vector_meta.meta_vector_3);
}
action vector_add_4_act() { 
    register_read(sml_vector_meta.meta_vector_4, vector_4_reg, pclocation.index); 
    add_to_field(sml_vector_meta.meta_vector_4,sml_vector.vector_4); 
    register_write(vector_4_reg, pclocation.index, sml_vector_meta.meta_vector_4);
}
action vector_add_5_act() { 
    register_read(sml_vector_meta.meta_vector_5, vector_5_reg, pclocation.index); 
    add_to_field(sml_vector_meta.meta_vector_5,sml_vector.vector_5); 
    register_write(vector_5_reg, pclocation.index, sml_vector_meta.meta_vector_5);
}
action vector_add_6_act() { 
    register_read(sml_vector_meta.meta_vector_6, vector_6_reg, pclocation.index); 
    add_to_field(sml_vector_meta.meta_vector_6,sml_vector.vector_6); 
    register_write(vector_6_reg, pclocation.index, sml_vector_meta.meta_vector_6);
}
action vector_add_7_act() { 
    register_read(sml_vector_meta.meta_vector_7, vector_7_reg, pclocation.index); 
    add_to_field(sml_vector_meta.meta_vector_7,sml_vector.vector_7); 
    register_write(vector_7_reg, pclocation.index, sml_vector_meta.meta_vector_7);
}
action vector_add_8_act() { 
    register_read(sml_vector_meta.meta_vector_8, vector_8_reg, pclocation.index); 
    add_to_field(sml_vector_meta.meta_vector_8,sml_vector.vector_8); 
    register_write(vector_8_reg, pclocation.index, sml_vector_meta.meta_vector_8);
}
action vector_add_9_act() { 
    register_read(sml_vector_meta.meta_vector_9, vector_9_reg, pclocation.index); 
    add_to_field(sml_vector_meta.meta_vector_9,sml_vector.vector_9); 
    register_write(vector_9_reg, pclocation.index, sml_vector_meta.meta_vector_9);
}
action vector_add_10_act() { 
    register_read(sml_vector_meta.meta_vector_10, vector_10_reg, pclocation.index); 
    add_to_field(sml_vector_meta.meta_vector_10,sml_vector.vector_10); 
    register_write(vector_10_reg, pclocation.index, sml_vector_meta.meta_vector_10);
}
action vector_add_11_act() { 
    register_read(sml_vector_meta.meta_vector_11, vector_11_reg, pclocation.index); 
    add_to_field(sml_vector_meta.meta_vector_11,sml_vector.vector_11); 
    register_write(vector_11_reg, pclocation.index, sml_vector_meta.meta_vector_11);
}
action vector_add_12_act() { 
    register_read(sml_vector_meta.meta_vector_12, vector_12_reg, pclocation.index); 
    add_to_field(sml_vector_meta.meta_vector_12,sml_vector.vector_12); 
    register_write(vector_12_reg, pclocation.index, sml_vector_meta.meta_vector_12);
}
action vector_add_13_act() { 
    register_read(sml_vector_meta.meta_vector_13, vector_13_reg, pclocation.index); 
    add_to_field(sml_vector_meta.meta_vector_13,sml_vector.vector_13); 
    register_write(vector_13_reg, pclocation.index, sml_vector_meta.meta_vector_13);
}
action vector_add_14_act() { 
    register_read(sml_vector_meta.meta_vector_14, vector_14_reg, pclocation.index); 
    add_to_field(sml_vector_meta.meta_vector_14,sml_vector.vector_14); 
    register_write(vector_14_reg, pclocation.index, sml_vector_meta.meta_vector_14);
}
action vector_add_15_act() { 
    register_read(sml_vector_meta.meta_vector_15, vector_15_reg, pclocation.index); 
    add_to_field(sml_vector_meta.meta_vector_15,sml_vector.vector_15); 
    register_write(vector_15_reg, pclocation.index, sml_vector_meta.meta_vector_15);
}
action vector_add_16_act() { 
    register_read(sml_vector_meta.meta_vector_16, vector_16_reg, pclocation.index); 
    add_to_field(sml_vector_meta.meta_vector_16,sml_vector.vector_16); 
    register_write(vector_16_reg, pclocation.index, sml_vector_meta.meta_vector_16);
}
action vector_add_17_act() { 
    register_read(sml_vector_meta.meta_vector_17, vector_17_reg, pclocation.index); 
    add_to_field(sml_vector_meta.meta_vector_17,sml_vector.vector_17); 
    register_write(vector_17_reg, pclocation.index, sml_vector_meta.meta_vector_17);
}
action vector_add_18_act() { 
    register_read(sml_vector_meta.meta_vector_18, vector_18_reg, pclocation.index); 
    add_to_field(sml_vector_meta.meta_vector_18,sml_vector.vector_18); 
    register_write(vector_18_reg, pclocation.index, sml_vector_meta.meta_vector_18);
}
action vector_add_19_act() { 
    register_read(sml_vector_meta.meta_vector_19, vector_19_reg, pclocation.index); 
    add_to_field(sml_vector_meta.meta_vector_19,sml_vector.vector_19); 
    register_write(vector_19_reg, pclocation.index, sml_vector_meta.meta_vector_19);
}
action vector_add_20_act() { 
    register_read(sml_vector_meta.meta_vector_20, vector_20_reg, pclocation.index); 
    add_to_field(sml_vector_meta.meta_vector_20,sml_vector.vector_20); 
    register_write(vector_20_reg, pclocation.index, sml_vector_meta.meta_vector_20);
}
action vector_add_21_act() { 
    register_read(sml_vector_meta.meta_vector_21, vector_21_reg, pclocation.index); 
    add_to_field(sml_vector_meta.meta_vector_21,sml_vector.vector_21); 
    register_write(vector_21_reg, pclocation.index, sml_vector_meta.meta_vector_21);
}
action vector_add_22_act() { 
    register_read(sml_vector_meta.meta_vector_22, vector_22_reg, pclocation.index); 
    add_to_field(sml_vector_meta.meta_vector_22,sml_vector.vector_22); 
    register_write(vector_22_reg, pclocation.index, sml_vector_meta.meta_vector_22);
}
action vector_add_23_act() { 
    register_read(sml_vector_meta.meta_vector_23, vector_23_reg, pclocation.index); 
    add_to_field(sml_vector_meta.meta_vector_23,sml_vector.vector_23); 
    register_write(vector_23_reg, pclocation.index, sml_vector_meta.meta_vector_23);
}
action vector_add_24_act() { 
    register_read(sml_vector_meta.meta_vector_24, vector_24_reg, pclocation.index); 
    add_to_field(sml_vector_meta.meta_vector_24,sml_vector.vector_24); 
    register_write(vector_24_reg, pclocation.index, sml_vector_meta.meta_vector_24);
}
action vector_add_25_act() { 
    register_read(sml_vector_meta.meta_vector_25, vector_25_reg, pclocation.index); 
    add_to_field(sml_vector_meta.meta_vector_25,sml_vector.vector_25); 
    register_write(vector_25_reg, pclocation.index, sml_vector_meta.meta_vector_25);
}
action vector_add_26_act() { 
    register_read(sml_vector_meta.meta_vector_26, vector_26_reg, pclocation.index); 
    add_to_field(sml_vector_meta.meta_vector_26,sml_vector.vector_26); 
    register_write(vector_26_reg, pclocation.index, sml_vector_meta.meta_vector_26);
}
action vector_add_27_act() { 
    register_read(sml_vector_meta.meta_vector_27, vector_27_reg, pclocation.index); 
    add_to_field(sml_vector_meta.meta_vector_27,sml_vector.vector_27); 
    register_write(vector_27_reg, pclocation.index, sml_vector_meta.meta_vector_27);
}
action vector_add_28_act() { 
    register_read(sml_vector_meta.meta_vector_28, vector_28_reg, pclocation.index); 
    add_to_field(sml_vector_meta.meta_vector_28,sml_vector.vector_28); 
    register_write(vector_28_reg, pclocation.index, sml_vector_meta.meta_vector_28);
}
action vector_add_29_act() { 
    register_read(sml_vector_meta.meta_vector_29, vector_29_reg, pclocation.index); 
    add_to_field(sml_vector_meta.meta_vector_29,sml_vector.vector_29); 
    register_write(vector_29_reg, pclocation.index, sml_vector_meta.meta_vector_29);
}
action vector_add_30_act() { 
    register_read(sml_vector_meta.meta_vector_30, vector_30_reg, pclocation.index); 
    add_to_field(sml_vector_meta.meta_vector_30,sml_vector.vector_30); 
    register_write(vector_30_reg, pclocation.index, sml_vector_meta.meta_vector_30);
}
action vector_add_31_act() { 
    register_read(sml_vector_meta.meta_vector_31, vector_31_reg, pclocation.index); 
    add_to_field(sml_vector_meta.meta_vector_31,sml_vector.vector_31); 
    register_write(vector_31_reg, pclocation.index, sml_vector_meta.meta_vector_31);
}
action vector_add_32_act() { 
    register_read(sml_vector_meta.meta_vector_32, vector_32_reg, pclocation.index); 
    add_to_field(sml_vector_meta.meta_vector_32,sml_vector.vector_32); 
    register_write(vector_32_reg, pclocation.index, sml_vector_meta.meta_vector_32);
}

/*vector_add综合到一起*/
control vector_add {
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
}

/*丢包的table和action*/
table drop_packet { 
    actions { 
        drop_packet_act; 
    } 
}

action drop_packet_act() { 
    drop();
}





/*对于单个来说需要把ip反一下*/
header_type ip_exchange_info_md_t {
    fields {
        ipv4_srcAddr: 32;
        ipv4_dstAddr: 32;
    }
}

metadata ip_exchange_info_md_t ip_exchange_info_md;



action ip_exchange_act() {
    modify_field (ip_exchange_info_md.ipv4_srcAddr, ipv4.srcAddr);
    modify_field (ip_exchange_info_md.ipv4_dstAddr, ipv4.dstAddr);
    modify_field (ipv4.srcAddr, ip_exchange_info_md.ipv4_dstAddr);
    modify_field (ipv4.dstAddr, ip_exchange_info_md.ipv4_srcAddr);
}

table ip_exchange {
    actions {
        ip_exchange_act;
    }
}

/*主体*/


control process_aggregation {
    apply (seen_read);
    apply (count_read);
    if (meta_seen.seen_value==0){
        apply (seen_set1);
        apply (seen_set0);
        apply (count_add);
        if (meta_count.count_value==1){
            vector_store();
        }else{
            vector_add();
        }
        if (meta_count.count_value==0){
            vector_read_1();
            apply (singleorm_set1);
        }else{
            apply (singleorm_set2);
        }        
    }
    else{
        if (meta_count.count_value==0){
            vector_read_2();
            apply (singleorm_set0);
            apply (ip_exchange);
        }else{
            apply (singleorm_set3);
        }
    }      
}














