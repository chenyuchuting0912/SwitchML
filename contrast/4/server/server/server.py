#udp服务端
import socket
import struct
import time
WORKER1_IP="10.0.0.1"
SERVER_IP="10.0.0.5"
SML_PORT=8888
k = 32
s = 32
worker_num=4
ip_port=(SERVER_IP,SML_PORT)
buffer_size=10240
udp_server=socket.socket(socket.AF_INET,socket.SOCK_DGRAM) #数据报
udp_server.bind(ip_port)
worker1_addr=(WORKER1_IP,SML_PORT)
countr=0
counts=0
N=5000
internal=1/N





#定义数据包类
class p:
    def __init__(self):
        self.idx = 0
        self.off = 0
        self.vector = []
#定义两个个字典去做那些事情，一个pool的字典，一个count的字典。
#两个字典的键都是idx
#定义并初始化
pool={}
count={}
for i in range(0,s):
    for j in range(0,k):
        pool.setdefault(i,[]).append(0)
for i in range(0,s):
    count[i]=0   

while True: #通信循环
    # 接收数据
    recv_packet,recv_addr=udp_server.recvfrom(buffer_size)
    countr=countr+1
    print("countr:",countr)
    recv_data=[]
    p.idx=int(struct.unpack(">i",recv_packet[0:4])[0])
    p.off=int(struct.unpack("i",recv_packet[4:8])[0])
    for d in range(8,len(recv_packet),4):
        recv_data.append(struct.unpack("f",recv_packet[d:d+4])[0])
    #print(recv_data)
    print("idx={0},offset={1}".format(p.idx,p.off))
    recv_vector=recv_data
    for i in range(0,k):
        pool[p.idx][i]=pool[p.idx][i]+recv_vector[i]
    count[p.idx]=count[p.idx]+1
    #time.sleep(0.01)
    
    if count[p.idx]==worker_num:
        #发送数据
        idx_field = struct.pack(">i", p.idx)
        off_field = struct.pack("i", p.off)
        sent_packet = idx_field + off_field
        for i in range(0,k):
            sent_packet += struct.pack("f", pool[p.idx][i])
        for i in range(0,k):
            pool[p.idx][0]=0
        count[p.idx]=0
        udp_server.sendto(sent_packet,worker1_addr) 
  
        counts=counts+1
        print("counts:",counts)
        time.sleep(internal)

        

udp_server.close()

            
