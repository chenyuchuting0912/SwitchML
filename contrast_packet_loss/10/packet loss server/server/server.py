#udp服务端
import socket
import struct
import time
WORKER1_IP="10.0.0.1"
WORKER2_IP="10.0.0.2"
WORKER3_IP="10.0.0.3"
WORKER4_IP="10.0.0.4"
WORKER5_IP="10.0.0.5"
WORKER6_IP="10.0.0.6"
WORKER7_IP="10.0.0.7"
WORKER8_IP="10.0.0.8"
WORKER9_IP="10.0.0.9"
WORKER10_IP="10.0.0.10"
SERVER_IP="10.0.0.11"
multi_ip="10.0.0.12"
SML_PORT=8888
k = 32
s = 32
worker_num=8
ip_port=(SERVER_IP,SML_PORT)
buffer_size=102400
udp_server=socket.socket(socket.AF_INET,socket.SOCK_DGRAM) #数据报

udp_server.bind(ip_port)
worker1_addr=(WORKER1_IP,SML_PORT)
worker2_addr=(WORKER2_IP,SML_PORT)
worker3_addr=(WORKER3_IP,SML_PORT)
worker4_addr=(WORKER4_IP,SML_PORT)
worker5_addr=(WORKER5_IP,SML_PORT)
worker6_addr=(WORKER6_IP,SML_PORT)
worker7_addr=(WORKER7_IP,SML_PORT)
worker8_addr=(WORKER8_IP,SML_PORT)
worker9_addr=(WORKER9_IP,SML_PORT)
worker10_addr=(WORKER10_IP,SML_PORT)
multi_addr=(multi_ip,SML_PORT)
N=5000
internal=1/N
countr=0
counts=0

#定义数据包类
# p=[]
# for i in range(0,s):
#     p.append(i)
#
# class packet:
#     def __init__(self,i):
#         self.wid = 1
#         self.ver = 0
#         self.idx = i
#         self.off = 0
#         self.vector = []
# for i in range(0, s):
#     p[i] = packet(i+1)
#定义两个个字典去做那些事情，一个pool的字典，一个count的字典。
#两个字典的键都是idx
#定义并初始化
pool=[]
count={}
seen=[]
###############
#pool[ver][idx-1][k]
for i in range(2):
    pool.append([])
    for ii in range(s):
        pool[i].append([])
        for iii in range(k):
            pool[i][ii].append(0)
#############  ver= 0,1  idx=1,2,3....   wid= 1,2
#count[ver][idx-1]
for i in range(2):
    for ii in range(s):
        count.setdefault(i,[]).append(0)
#print(count)
# ############
# seen[ver][idx-1][wid-1]
for i in range(2):
    seen.append([])
    for ii in range(s):
        seen[i].append([])
        for iii in range(2):
            seen[i][ii].append(0)


while True: #通信循环
    # 接收数据
    recv_packet,recv_addr=udp_server.recvfrom(buffer_size)
    countr=countr+1
    print("recv_countr:",countr)
    recv_vector=[]
    recv_wid = int(struct.unpack(">i",recv_packet[0:4])[0])
    recv_ver = int(struct.unpack(">i", recv_packet[4:8])[0])-1
    recv_idx = int(struct.unpack(">i", recv_packet[8:12])[0])
    recv_off = int(struct.unpack("i",recv_packet[12:16])[0])
    print("recv packet wid={0},ver={1},idx={2},off={3}".format(recv_wid,recv_ver,recv_idx,recv_off))
    for d in range(16,len(recv_packet),4):
        recv_vector.append(struct.unpack("f",recv_packet[d:d+4])[0])
    #print(recv_data)
    #print("idx={0},offset={1}".format(p.idx,p.off))
    # recv_vector=recv_data
    if seen[recv_ver][recv_idx-1][recv_wid-1]==0:
        seen[recv_ver][recv_idx - 1][recv_wid - 1]=1
        seen[(recv_ver+1)%2][recv_idx - 1][recv_wid - 1]=0
        count[recv_ver][recv_idx-1]=(count[recv_ver][recv_idx-1]+1)%worker_num
        if count[recv_ver][recv_idx-1]==1:
            pool[recv_ver][recv_idx-1]=recv_vector
        else:
            for i in range(0, k):
                pool[recv_ver][recv_idx-1][i] += recv_vector[i]
        if count[recv_ver][recv_idx-1]==0:
            # recv_vector = pool[recv_ver][recv_idx - 1]
            wid_field = struct.pack(">i", recv_wid)
            ver_field = struct.pack(">i", recv_ver)
            idx_field = struct.pack(">i", recv_idx)
            off_field = struct.pack("i", recv_off)
            sent_packet = wid_field + ver_field + idx_field + off_field
            for i in range(0,k):
                sent_packet += struct.pack("f", pool[recv_ver][recv_idx-1][i])
            udp_server.sendto(sent_packet, multi_addr)
            time.sleep(internal)
            print("return packet wid={0},ver={1},idx={2},off={3}".format(recv_wid,recv_ver,recv_idx,recv_off))
            counts = counts + 1
    else:
        if count[recv_ver][recv_idx-1]==0:
            # recv_vector = pool[recv_ver][recv_idx - 1]
            wid_field = struct.pack(">i", recv_wid)
            ver_field = struct.pack(">i", recv_ver)
            idx_field = struct.pack(">i", recv_idx)
            off_field = struct.pack("i", recv_off)
            sent_packet = wid_field + ver_field + idx_field + off_field
            for i in range(0, k):
                sent_packet += struct.pack("f", pool[recv_ver][recv_idx - 1][i])
            if recv_wid==1:
                udp_server.sendto(sent_packet, worker1_addr)
                print("re_sent packet to worker1,ver={0},idx={1},off={2}".format(recv_ver, recv_idx, recv_off))
                time.sleep(internal)
                counts = counts + 1
            elif recv_wid==2:
                udp_server.sendto(sent_packet,worker2_addr)
                print("re_sent packet to worker2,ver={0},idx={1},off={2}".format(recv_ver, recv_idx, recv_off))
                time.sleep(internal)
                counts=counts+1
            elif recv_wid==3:
                udp_server.sendto(sent_packet,worker3_addr)
                print("re_sent packet to worker3,ver={0},idx={1},off={2}".format(recv_ver, recv_idx, recv_off))
                time.sleep(internal)
                counts=counts+1
            elif recv_wid==4:
                udp_server.sendto(sent_packet,worker4_addr)
                print("re_sent packet to worker4,ver={0},idx={1},off={2}".format(recv_ver, recv_idx, recv_off))
                time.sleep(internal)
                counts=counts+1
            elif recv_wid==5:
                udp_server.sendto(sent_packet,worker5_addr)
                print("re_sent packet to worker4,ver={0},idx={1},off={2}".format(recv_ver, recv_idx, recv_off))
                time.sleep(internal)
                counts=counts+1
            elif recv_wid==6:
                udp_server.sendto(sent_packet,worker6_addr)
                print("re_sent packet to worker4,ver={0},idx={1},off={2}".format(recv_ver, recv_idx, recv_off))
                time.sleep(internal)
                counts=counts+1
            elif recv_wid==7:
                udp_server.sendto(sent_packet,worker7_addr)
                print("re_sent packet to worker4,ver={0},idx={1},off={2}".format(recv_ver, recv_idx, recv_off))
                time.sleep(internal)
                counts=counts+1
            elif recv_wid==8:
                udp_server.sendto(sent_packet,worker8_addr)
                print("re_sent packet to worker4,ver={0},idx={1},off={2}".format(recv_ver, recv_idx, recv_off))
                time.sleep(internal)
                counts=counts+1
            elif recv_wid==9:
                udp_server.sendto(sent_packet,worker9_addr)
                print("re_sent packet to worker4,ver={0},idx={1},off={2}".format(recv_ver, recv_idx, recv_off))
                time.sleep(internal)
                counts=counts+1
            elif recv_wid==10:
                udp_server.sendto(sent_packet,worker10_addr)
                print("re_sent packet to worker4,ver={0},idx={1},off={2}".format(recv_ver, recv_idx, recv_off))
                time.sleep(internal)
                counts=counts+1
            print("sent counts:",counts)

udp_server.close()
