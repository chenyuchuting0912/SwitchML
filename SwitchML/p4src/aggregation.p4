/*将之前的aggregation部分修改整理*/

/*定义数据的头，每个数据包携带32个数据*/
#define HEADER_VECTOR(i) \
    header_type sml_vector_##i##_t { \
        fields { \
            vector_##i##_1: 32; \
            vector_##i##_2: 32; \
            vector_##i##_3: 32; \
            vector_##i##_4: 32; \
            vector_##i##_5: 32; \
            vector_##i##_6: 32; \
            vector_##i##_7: 32; \
            vector_##i##_8: 32; \
            vector_##i##_9: 32; \
            vector_##i##_10: 32; \
            vector_##i##_11: 32; \
            vector_##i##_12: 32; \
            vector_##i##_13: 32; \
            vector_##i##_14: 32; \
            vector_##i##_15: 32; \
            vector_##i##_16: 32; \
            vector_##i##_17: 32; \
            vector_##i##_18: 32; \
            vector_##i##_19: 32; \
            vector_##i##_20: 32; \
            vector_##i##_21: 32; \
            vector_##i##_22: 32; \
            vector_##i##_23: 32; \
            vector_##i##_24: 32; \
            vector_##i##_25: 32; \
            vector_##i##_26: 32; \
            vector_##i##_27: 32; \
            vector_##i##_28: 32; \
            vector_##i##_29: 32; \
            vector_##i##_30: 32; \
            vector_##i##_31: 32; \
            vector_##i##_32: 32; \
        } \
    } \
    header sml_vector_##i##_t sml_vector_##i;

/*解析vector的头的部分*/
#define PARSER_VECTOR(i, ip1) \
    parser parse_sml_vector_##i { \
        extract (sml_vector_##i); \
        return parse_sml_vector_##ip1; \
    }


/*存储vector的寄存器*/

#define REGISTER_VECTOR_SLICE(i, j) \
    register vector_##i##_##j##_reg { \
        width: 32; \
        instance_count: CACHE_NUM; \
    }

/*define多个寄存器，这个感觉有些像把寄存器分块，一个index对应多个寄存器*/
#define REGISTER_VECTOR(i) \
    REGISTER_VECTOR_SLICE(i, 1) \
    REGISTER_VECTOR_SLICE(i, 2) \
    REGISTER_VECTOR_SLICE(i, 3) \
    REGISTER_VECTOR_SLICE(i, 4) \
    REGISTER_VECTOR_SLICE(i, 5) \
    REGISTER_VECTOR_SLICE(i, 6) \
    REGISTER_VECTOR_SLICE(i, 7) \
    REGISTER_VECTOR_SLICE(i, 8) \
    REGISTER_VECTOR_SLICE(i, 9) \
    REGISTER_VECTOR_SLICE(i, 10) \
    REGISTER_VECTOR_SLICE(i, 11) \
    REGISTER_VECTOR_SLICE(i, 12) \
    REGISTER_VECTOR_SLICE(i, 13) \
    REGISTER_VECTOR_SLICE(i, 14) \
    REGISTER_VECTOR_SLICE(i, 15) \
    REGISTER_VECTOR_SLICE(i, 16) \
    REGISTER_VECTOR_SLICE(i, 17) \
    REGISTER_VECTOR_SLICE(i, 18) \
    REGISTER_VECTOR_SLICE(i, 19) \
    REGISTER_VECTOR_SLICE(i, 20) \
    REGISTER_VECTOR_SLICE(i, 21) \
    REGISTER_VECTOR_SLICE(i, 22) \
    REGISTER_VECTOR_SLICE(i, 23) \
    REGISTER_VECTOR_SLICE(i, 24) \
    REGISTER_VECTOR_SLICE(i, 25) \
    REGISTER_VECTOR_SLICE(i, 26) \
    REGISTER_VECTOR_SLICE(i, 27) \
    REGISTER_VECTOR_SLICE(i, 28) \
    REGISTER_VECTOR_SLICE(i, 29) \
    REGISTER_VECTOR_SLICE(i, 30) \
    REGISTER_VECTOR_SLICE(i, 31) \
    REGISTER_VECTOR_SLICE(i, 32)    

/*上面的一部分是对vector头，以及寄存器的定义*/







/*接下来的部分希望，定义count的并行哎*/

#define REGISTER_COUNT(i) \
    register count_##i##_reg{\
    width: 4; \
    instance_count: CACHE_NUM; \

    }



/*处理count+1的操作是需要元数据的帮助，两数相加也需要元数据的帮助吧*/


/*定义记录意经聚合的vector的元数据*/
#define META_COUNT(i) \
    header_type meta_count_##i##_t{ \
    field{ \
    count_value_##i: 4; \
         } \
    }\
    metadate meta_count_##i##_t meta_count_##i;

/*对COUNT的元数据相加的TABLE和ACTION*/
#define TABLE_COUNT_ADD(i) \
    table count_add_##i{ \
        actions{ \
        count_add__##i##_act; \
        } \

    }

#define ACTION_COUNT_ADD(i) \
    action count_add_##i##_act(){ \
        register_read(meta_count_##i.count_value_##i, count_##i##_reg, location.index);
        add_to_field(meta_count_##i.count_value_##i, 1);
        register_write(count_##i##_reg, location.index, meta_count_##i.count_value_##i);
    } 










/#接下来就是vector的加减*，也得定义一个元元数据去作为中间量*/

#define HEADER_VALUE_MEAT(i) \
    header_type sml_vector_meta_##i##_t { \
        fields { \
            meta_vector_##i##_1: 32; \
            meta_vector_##i##_2: 32; \
            meta_vector_##i##_3: 32; \
            meta_vector_##i##_4: 32; \
            meta_vector_##i##_5: 32; \
            meta_vector_##i##_6: 32; \
            meta_vector_##i##_7: 32; \
            meta_vector_##i##_8: 32; \
            meta_vector_##i##_9: 32; \
            meta_vector_##i##_10: 32; \
            meta_vector_##i##_11: 32; \
            meta_vector_##i##_12: 32; \
            meta_vector_##i##_13: 32; \
            meta_vector_##i##_14: 32; \
            meta_vector_##i##_15: 32; \
            meta_vector_##i##_16: 32; \
            meta_vector_##i##_17: 32; \
            meta_vector_##i##_18: 32; \
            meta_vector_##i##_19: 32; \
            meta_vector_##i##_20: 32; \
            meta_vector_##i##_21: 32; \
            meta_vector_##i##_22: 32; \
            meta_vector_##i##_23: 32; \
            meta_vector_##i##_24: 32; \
            meta_vector_##i##_25: 32; \
            meta_vector_##i##_26: 32; \
            meta_vector_##i##_27: 32; \
            meta_vector_##i##_28: 32; \
            meta_vector_##i##_29: 32; \
            meta_vector_##i##_30: 32; \
            meta_vector_##i##_31: 32; \
            meta_vector_##i##_32: 32; \
        } \
    } \
    header sml_vector_meta_##i##_t sml_vector_meta_##i;



/*聚合操作的表和action，取出值至元数据，调整元数据，再将值存入寄存器*/
#define ACTION_VECTOR_ADD_SLICE(i, j) \
    action vector_add_##i##_##j##_act() { \
        register_read(sml_vector_meta_##i.meta_vector_##i##_##j, vector_##i##_##j##_reg, location.index); \
        add_to_field(sml_vector_meta_##i.meta_vector_##i##_##j,sml_vector_##i.vector_##i##_##j); \
        register_write(vector_##i##_##j##_reg, location.index, sml_vector_meta_##i.meta_vector_##i##_##j);

    }

#define ACTION_VECTOR_ADD(i) \
    ACTION_VECTOR_ADD_SLICE(i, 1) \
    ACTION_VECTOR_ADD_SLICE(i, 2) \
    ACTION_VECTOR_ADD_SLICE(i, 3) \
    ACTION_VECTOR_ADD_SLICE(i, 4) \
    ACTION_VECTOR_ADD_SLICE(i, 5) \
    ACTION_VECTOR_ADD_SLICE(i, 6) \
    ACTION_VECTOR_ADD_SLICE(i, 7) \
    ACTION_VECTOR_ADD_SLICE(i, 8) \
    ACTION_VECTOR_ADD_SLICE(i, 9) \
    ACTION_VECTOR_ADD_SLICE(i, 10) \
    ACTION_VECTOR_ADD_SLICE(i, 11) \
    ACTION_VECTOR_ADD_SLICE(i, 12) \
    ACTION_VECTOR_ADD_SLICE(i, 13) \
    ACTION_VECTOR_ADD_SLICE(i, 14) \
    ACTION_VECTOR_ADD_SLICE(i, 15) \
    ACTION_VECTOR_ADD_SLICE(i, 16) \
    ACTION_VECTOR_ADD_SLICE(i, 17) \
    ACTION_VECTOR_ADD_SLICE(i, 18) \
    ACTION_VECTOR_ADD_SLICE(i, 19) \
    ACTION_VECTOR_ADD_SLICE(i, 20) \
    ACTION_VECTOR_ADD_SLICE(i, 21) \
    ACTION_VECTOR_ADD_SLICE(i, 22) \
    ACTION_VECTOR_ADD_SLICE(i, 23) \
    ACTION_VECTOR_ADD_SLICE(i, 24) \
    ACTION_VECTOR_ADD_SLICE(i, 25) \
    ACTION_VECTOR_ADD_SLICE(i, 26) \
    ACTION_VECTOR_ADD_SLICE(i, 27) \
    ACTION_VECTOR_ADD_SLICE(i, 28) \
    ACTION_VECTOR_ADD_SLICE(i, 29) \
    ACTION_VECTOR_ADD_SLICE(i, 30) \
    ACTION_VECTOR_ADD_SLICE(i, 31) \
    ACTION_VECTOR_ADD_SLICE(i, 32) 


#define TABLE_VECTOR_ADD_SLICE(i, j) \
    table vector_add_##i##_##j { \
        actions { \
            vector_add_##i##_##j##_act; \
        } \
    }

#define TABLE_VECTOR_ADD(i) \
    TABLE_VECTOR_ADD_SLICE(i, 1) \
    TABLE_VECTOR_ADD_SLICE(i, 2) \
    TABLE_VECTOR_ADD_SLICE(i, 3) \
    TABLE_VECTOR_ADD_SLICE(i, 4) \
    TABLE_VECTOR_ADD_SLICE(i, 5) \
    TABLE_VECTOR_ADD_SLICE(i, 6) \
    TABLE_VECTOR_ADD_SLICE(i, 7) \
    TABLE_VECTOR_ADD_SLICE(i, 8) \
    TABLE_VECTOR_ADD_SLICE(i, 9) \
    TABLE_VECTOR_ADD_SLICE(i, 10) \
    TABLE_VECTOR_ADD_SLICE(i, 11) \
    TABLE_VECTOR_ADD_SLICE(i, 12) \
    TABLE_VECTOR_ADD_SLICE(i, 13) \
    TABLE_VECTOR_ADD_SLICE(i, 14) \
    TABLE_VECTOR_ADD_SLICE(i, 15) \
    TABLE_VECTOR_ADD_SLICE(i, 16) \
    TABLE_VECTOR_ADD_SLICE(i, 17) \
    TABLE_VECTOR_ADD_SLICE(i, 18) \
    TABLE_VECTOR_ADD_SLICE(i, 19) \
    TABLE_VECTOR_ADD_SLICE(i, 20) \
    TABLE_VECTOR_ADD_SLICE(i, 21) \
    TABLE_VECTOR_ADD_SLICE(i, 22) \
    TABLE_VECTOR_ADD_SLICE(i, 23) \
    TABLE_VECTOR_ADD_SLICE(i, 24) \
    TABLE_VECTOR_ADD_SLICE(i, 25) \
    TABLE_VECTOR_ADD_SLICE(i, 26) \
    TABLE_VECTOR_ADD_SLICE(i, 27) \
    TABLE_VECTOR_ADD_SLICE(i, 28) \
    TABLE_VECTOR_ADD_SLICE(i, 29) \
    TABLE_VECTOR_ADD_SLICE(i, 30) \
    TABLE_VECTOR_ADD_SLICE(i, 31) \
    TABLE_VECTOR_ADD_SLICE(i, 32)








/*接下来是在count等于主机数的时候，需要将数据写到包里面*，并且可以把寄存器的值置0了/

#define ACTION_VECTOR_READ_SLICE(i, j) \
    action vector_read_##i##_##j##_act() { \
        register_read(sml_vector_##i.vector_##i##_##j, vector_##i##_##j##_reg, location.index); \
        register_write(vector_##i##_##j##_reg, location.index, 0); \
    }

#define ACTION_VECTOR_READ(i) \
    ACTION_VECTOR_READ_SLICE(i, 1) \
    ACTION_VECTOR_READ_SLICE(i, 2) \
    ACTION_VECTOR_READ_SLICE(i, 3) \
    ACTION_VECTOR_READ_SLICE(i, 4) \
    ACTION_VECTOR_READ_SLICE(i, 5) \
    ACTION_VECTOR_READ_SLICE(i, 6) \
    ACTION_VECTOR_READ_SLICE(i, 7) \
    ACTION_VECTOR_READ_SLICE(i, 8) \
    ACTION_VECTOR_READ_SLICE(i, 9) \
    ACTION_VECTOR_READ_SLICE(i, 10) \
    ACTION_VECTOR_READ_SLICE(i, 11) \
    ACTION_VECTOR_READ_SLICE(i, 12) \
    ACTION_VECTOR_READ_SLICE(i, 13) \
    ACTION_VECTOR_READ_SLICE(i, 14) \
    ACTION_VECTOR_READ_SLICE(i, 15) \
    ACTION_VECTOR_READ_SLICE(i, 16) \
    ACTION_VECTOR_READ_SLICE(i, 17) \
    ACTION_VECTOR_READ_SLICE(i, 18) \
    ACTION_VECTOR_READ_SLICE(i, 19) \
    ACTION_VECTOR_READ_SLICE(i, 20) \
    ACTION_VECTOR_READ_SLICE(i, 21) \
    ACTION_VECTOR_READ_SLICE(i, 22) \
    ACTION_VECTOR_READ_SLICE(i, 23) \
    ACTION_VECTOR_READ_SLICE(i, 24) \
    ACTION_VECTOR_READ_SLICE(i, 25) \
    ACTION_VECTOR_READ_SLICE(i, 26) \
    ACTION_VECTOR_READ_SLICE(i, 27) \
    ACTION_VECTOR_READ_SLICE(i, 28) \
    ACTION_VECTOR_READ_SLICE(i, 29) \
    ACTION_VECTOR_READ_SLICE(i, 30) \
    ACTION_VECTOR_READ_SLICE(i, 31) \
    ACTION_VECTOR_READ_SLICE(i, 32)


#define TABLE_VECTOR_READ_SLICE(i, j) \
    table vector_read_##i##_##j { \
        actions { \
            vector_read_##i##_##j##_act; \
        } \
    }

#define TABLE_VECTOR_READ(i) \
    TABLE_VECTOR_READ_SLICE(i, 1) \
    TABLE_VECTOR_READ_SLICE(i, 2) \
    TABLE_VECTOR_READ_SLICE(i, 3) \
    TABLE_VECTOR_READ_SLICE(i, 4) \
    TABLE_VECTOR_READ_SLICE(i, 5) \
    TABLE_VECTOR_READ_SLICE(i, 6) \
    TABLE_VECTOR_READ_SLICE(i, 7) \
    TABLE_VECTOR_READ_SLICE(i, 8) \
    TABLE_VECTOR_READ_SLICE(i, 9) \
    TABLE_VECTOR_READ_SLICE(i, 10) \
    TABLE_VECTOR_READ_SLICE(i, 11) \
    TABLE_VECTOR_READ_SLICE(i, 12) \
    TABLE_VECTOR_READ_SLICE(i, 13) \
    TABLE_VECTOR_READ_SLICE(i, 14) \
    TABLE_VECTOR_READ_SLICE(i, 15) \
    TABLE_VECTOR_READ_SLICE(i, 16) \
    TABLE_VECTOR_READ_SLICE(i, 17) \
    TABLE_VECTOR_READ_SLICE(i, 18) \
    TABLE_VECTOR_READ_SLICE(i, 19) \
    TABLE_VECTOR_READ_SLICE(i, 20) \
    TABLE_VECTOR_READ_SLICE(i, 21) \
    TABLE_VECTOR_READ_SLICE(i, 22) \
    TABLE_VECTOR_READ_SLICE(i, 23) \
    TABLE_VECTOR_READ_SLICE(i, 24) \
    TABLE_VECTOR_READ_SLICE(i, 25) \
    TABLE_VECTOR_READ_SLICE(i, 26) \
    TABLE_VECTOR_READ_SLICE(i, 27) \
    TABLE_VECTOR_READ_SLICE(i, 28) \
    TABLE_VECTOR_READ_SLICE(i, 29) \
    TABLE_VECTOR_READ_SLICE(i, 30) \
    TABLE_VECTOR_READ_SLICE(i, 31) \
    TABLE_VECTOR_READ_SLICE(i, 32) 






/*在count等于主机数的情况下，把寄存器存的读取到包里
，还需要将寄存器里的值以及count的值置为0，为了以后调试，
还是分开写。
*/

/*这是将寄存器中count置0的table与action*/
#define ACTION_SET_COUNT_TO_ZERO(i){ \
    action set_count_to_zero_##i##_act(){ \
        register_write(count_##i##_reg, location.index,0); \
    } \
}

#define TABLE_SET_COUNT_TO_ZERO(i){ \
    table set_count_to_zero_##i{ \
    actions{ \
         set_count_to_zero_##i##_act; \
    } \
    } \
}



/*丢弃包的部分，当然也是并行的，table和action*/
#define ACTION_DROP_PACKET(i) \
action drop_packet_##i##_act() { \
    drop(); \
}


#define TABLE_DROP_PACKET(i) \
table drop_packet_##i { \
    actions { \
        drop_packet_act_##i##_act; \
    } \
}









/*其实就是将上面整个流程串起来的 process_vector*/
#define CONTROL_PROCESS_VALUE(i) \
    control process_vector_##i { \
    apply(vector_add_##i##_1); \
    apply(vector_add_##i##_2); \
    apply(vector_add_##i##_3); \
    apply(vector_add_##i##_4); \
    apply(vector_add_##i##_5); \
    apply(vector_add_##i##_6); \
    apply(vector_add_##i##_7); \
    apply(vector_add_##i##_8); \
    apply(vector_add_##i##_9); \
    apply(vector_add_##i##_10); \
    apply(vector_add_##i##_11); \
    apply(vector_add_##i##_12); \
    apply(vector_add_##i##_13); \
    apply(vector_add_##i##_14); \
    apply(vector_add_##i##_15); \
    apply(vector_add_##i##_16); \
    apply(vector_add_##i##_17); \
    apply(vector_add_##i##_18); \
    apply(vector_add_##i##_19); \
    apply(vector_add_##i##_20); \
    apply(vector_add_##i##_21); \
    apply(vector_add_##i##_22); \
    apply(vector_add_##i##_23); \
    apply(vector_add_##i##_24); \
    apply(vector_add_##i##_25); \
    apply(vector_add_##i##_26); \
    apply(vector_add_##i##_27); \
    apply(vector_add_##i##_28); \
    apply(vector_add_##i##_29); \
    apply(vector_add_##i##_30); \
    apply(vector_add_##i##_31); \
    apply(vector_add_##i##_32); \
    apply(count_add_##i); \
    if(meta_count_##i.count_value_##i==WORKER_NUM){ \
    apply(vector_read_##i##_1); \
    apply(vector_read_##i##_2); \
    apply(vector_read_##i##_3); \
    apply(vector_read_##i##_4); \
    apply(vector_read_##i##_5); \
    apply(vector_read_##i##_6); \
    apply(vector_read_##i##_7); \
    apply(vector_read_##i##_8); \
    apply(vector_read_##i##_9); \
    apply(vector_read_##i##_10); \
    apply(vector_read_##i##_11); \
    apply(vector_read_##i##_12); \
    apply(vector_read_##i##_13); \
    apply(vector_read_##i##_14); \
    apply(vector_read_##i##_15); \
    apply(vector_read_##i##_16); \
    apply(vector_read_##i##_17); \
    apply(vector_read_##i##_18); \
    apply(vector_read_##i##_19); \
    apply(vector_read_##i##_20); \
    apply(vector_read_##i##_21); \
    apply(vector_read_##i##_22); \
    apply(vector_read_##i##_23); \
    apply(vector_read_##i##_24); \
    apply(vector_read_##i##_25); \
    apply(vector_read_##i##_26); \
    apply(vector_read_##i##_27); \
    apply(vector_read_##i##_28); \
    apply(vector_read_##i##_29); \
    apply(vector_read_##i##_30); \
    apply(vector_read_##i##_31); \
    apply(vector_read_##i##_32); \
    apply(set_count_to_zero_##i); \
    } \
    }else{ \
    apply(drop_packet_##i); \
    }




/*define 各个部分*/

#define HANDLE_VECOTR(i, ip1) \
    #define HEADER_VECTOR(i) \
    #define PARSER_VECTOR(i, ip1) \
    #define REGISTER_VECTOR(i) \
    #define REGISTER_COUNT(i) \
    #define TABLE_COUNT_ADD(i) \
    #define ACTION_COUNT_ADD(i) \
    #define HEADER_VALUE_MEAT(i) \
    #define ACTION_VECTOR_ADD(i) \
    #define TABLE_VECTOR_ADD(i) \
    #define ACTION_VECTOR_READ(i) \
    #define TABLE_VECTOR_READ(i) \
    #define ACTION_SET_COUNT_TO_ZERO(i) \
    #define TABLE_SET_COUNT_TO_ZERO(i) \
    #define ACTION_DROP_PACKET(i) \
    #define TABLE_DROP_PACKET(i) \
    #define CONTROL_PROCESS_VALUE(i)




#define FINAL_PARSER(i) \
    parser parse_sml_vector_##i { \
        return ingress; \
    }

HANDLE_VECTOR(1, 2)
HANDLE_VECTOR(2, 3)
HANDLE_VECTOR(3, 4)
HANDLE_VECTOR(4, 5)
HANDLE_VECTOR(5, 6)
HANDLE_VECTOR(6, 7)
HANDLE_VECTOR(7, 8)
HANDLE_VECTOR(8, 9)
FINAL_PARSER(9)









/*主逻辑相当于主函数的部分，突出一个并行*/
control process_aggregation() {    
 
    process_vector_1();
    process_vector_2();
    process_vector_3();
    process_vector_4();
    process_vector_5();
    process_vector_6();
    process_vector_7();
    process_vector_8();

    }
}






