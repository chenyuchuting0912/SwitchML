import socket
import struct
import time
# import numpy
import math
k = 32
s = 32
WORKER1_IP="10.0.0.1"
WORKER2_IP="10.0.0.2"
SERVER_IP="10.0.0.3"
SML_PORT=8888

# u=(32,32)
# U=numpy.zeros(u)
# print(U)
work_data = "work_data"
u_data ="u_data"
#定义数据包类
class p:
    def __init__(self):
        self.idx = 0
        self.off = 0
        self.vector = []
# 生成socket对象
ss = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
ss.bind((WORKER1_IP,SML_PORT))
# 链接要链接的ip和port（端口）
sent_addr=("10.0.0.3",SML_PORT)
# 读取梯度值
f1 = open(work_data, "r")
f2 = open(u_data, "w")
sent_data = f1.read()
sent_data = sent_data.split()
sent_data = list(map(float, sent_data))  # 把数据转换成浮点数
# p.off=0
# 发送数据
for i in range(0, s):
    p.idx = i
    p.off = k * i
    if p.off + k <= len(sent_data):
        sent_vector = sent_data[p.off:p.off + k]
        idx_field = struct.pack(">i", p.idx)
        off_field = struct.pack("i", p.off)
        sent_packet = idx_field + off_field
        for ii in range(len(sent_vector)):
            sent_packet += struct.pack("f", sent_vector[ii])
        print(sent_packet)
        ss.sendto(sent_packet, sent_addr)
        print("yes")
        time.sleep(0.01)
        # print(vector)
    else:
        idx_field = struct.pack(">i", p.idx)
        off_field = struct.pack("i", p.off)
        sent_packet = idx_field + off_field
        sent_vector = sent_data[p.off:]
        for iii in range(len(sent_vector)):
            sent_packet += struct.pack("f", sent_vector[iii])
        # print(vector)
    print(p.off)
counter=0
print("recieve data:")
while True:
    # 接收数据
    #print(counter)
    recv_packet,recv_addr=ss.recvfrom(1024)
    counter=counter+1
    recv_data=[]
    p.idx=int(struct.unpack(">i",recv_packet[0:4])[0])
    p.off=int(struct.unpack("i",recv_packet[4:8])[0])
    for d in range(8,len(recv_packet),4):
        recv_data.append(struct.unpack("f",recv_packet[d:d+4])[0])
    #print(recv_data)
    #p.idx=int(recv_data[0])
    print("idx={0},offset={1}".format(p.idx,p.off))
    recv_vector=recv_data
    print(recv_vector)
    sent_data[p.off:p.off+k]=recv_vector
    p.off += k*s
    time.sleep(0.01)
    if p.off<len(sent_data) and p.off+k <= len(sent_data):
        sent_vector = sent_data[p.off:p.off + k]
        idx_field = struct.pack(">i", p.idx)
        off_field = struct.pack("i", p.off)
        sent_packet = idx_field + off_field
        for ii in range(len(sent_vector)):
            sent_packet += struct.pack("f", sent_vector[ii])
        print("sent again:")
        print(sent_packet)
        ss.sendto(sent_packet, sent_addr)
        time.sleep(0.01)
    elif p.off<len(sent_data) and p.off+k > len(sent_data):
        idx_field = struct.pack(">i", p.idx)
        off_field = struct.pack("i", p.off)
        sent_packet = idx_field + off_field
        sent_vector = sent_data[p.off:]
        for iii in range(len(sent_vector)):
            sent_packet += struct.pack("f", sent_vector[iii])
        ss.sendto(sent_packet, sent_addr)
    if counter == math.ceil(len(sent_data)/k):
        print("done!")
        break

for list_men in sent_data:
    # off=0
    # for i in range(k):
    f2.write(str(list_men)+ " ")
    # off=k*i
f2.flush()
f1.close()
f2.close()

    # p.off = p.off + k
ss.close()
print('Connection is broken')