import socket
import struct
import time
import random
k = 32
s = 32
offset = 0
work_data = "work_data"
u_data ="u_data"
#定义数据包类
class p:
    def __init__(self):
        self.idx = 0
        self.off = 0
        self.vector = []
#随机产生梯度值

# 生成socket对象
ss = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
# 链接要链接的ip和port（端口）
sent_addr=("localhost",9999)
# while循环
while True:

    # 读取梯度值
    f1 = open(work_data, "r")
    f2 = open(u_data, "w")
    sent_data = f1.read()
    sent_data = sent_data.split()
    sent_data = list(map(float, sent_data))#把数据转换成浮点数
    # p.off=0
    # 发送数据
    for i in range(0, s):
        p.idx = i
        p.off = k*i
        if p.off + k <= len(sent_data):
            sent_vector = sent_data[p.off:p.off + k]
            idx_field=struct.pack("i",p.idx)
            off_field=struct.pack("i",p.off)
            sent_packet=idx_field+off_field
            for ii in range(len(sent_vector)):
                sent_vector[ii]=int(sent_vector[ii]*2**29)
                sent_packet+=struct.pack("i",sent_vector[ii])
            print(sent_packet)
            ss.sendto(sent_packet,sent_addr)
            time.sleep(0.01)
            # print(vector)
        else:
            idx_field = struct.pack("i", p.idx)
            off_field = struct.pack("i", p.off)
            sent_packet = idx_field + off_field
            sent_vector = sent_data[p.off:]
            for iii in range(len(sent_vector)):
                sent_vector[iii] = int(sent_vector[iii] * 2 ** 29)
                sent_packet += struct.pack("i", sent_vector[iii])
            # print(vector)
            break
        print(p.off)

    # 接收数据
    recv_packet,recv_addr=ss.recvfrom(1024)
    recv_data=[]
    for d in range(0,len(recv_packet),4):
        recv_data.append(struct.unpack("i",recv_packet[d:d+4])[0])
    print(recv_data)
    p.idx=int(recv_data[0])
    # p.off=int(recv_packet[1])
    recv_vector=recv_data[2:]
    for i in range(len(recv_vector)):
        recv_vector[i]=float(recv_vector[i]/(2**29))
        f2.write(str(recv_vector[i])+' ')
    f2.write("\n")
    f2.flush()
    if p.off+k>len(sent_data):
        f1.close()
        f2.close()
        break
    # p.off = p.off + k
ss.close()
print('Connection is broken')