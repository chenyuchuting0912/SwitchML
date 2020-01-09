import socket
import struct
import time
#import numpy
import threading
import math
k = 32
s = 32
WORKER1_IP="10.0.0.1"
WORKER2_IP="10.0.0.2"
WORKER3_IP="10.0.0.3"
WORKER4_IP="10.0.0.4"
WORKER5_IP="10.0.0.5"
WORKER6_IP="10.0.0.6"
WORKER7_IP="10.0.0.7"
WORKER8_IP="10.0.0.8"
SERVER_IP="10.0.0.9"
SML_PORT=8888
N=5000
interval=1/N
counts=0
##################################
# 32个定时器，数组表示,重发数量 recounts
timers=[]
recounts=0
#定时器任务
def retrans(idx):
    global recounts
    global timers
    re_sent_vector = sent_data[p[idx-1].off:p[idx-1].off + k]
    re_wid_field = struct.pack(">i", p[idx-1].wid)
    re_ver_field = struct.pack(">i", p[idx-1].ver)
    re_idx_field = struct.pack(">i",p[idx-1].idx)
    re_off_field = struct.pack("i", p[idx-1].off)
    re_sent_packet = re_wid_field + re_ver_field + re_idx_field + re_off_field
    for i in range(len(re_sent_vector)):
        re_sent_vector[i] = int(re_sent_vector[i] * 2 ** 29)
        re_sent_packet += struct.pack("i", re_sent_vector[i])
        # re_sent_packet += struct.pack("f", sent_vector[ii])
    #print("re_sent idx={0} off={1} ver={2} again:".format(idx,p[idx-1].off,p[idx-1].ver))
    #print("re_sent length:",len(re_sent_packet))
    ss.sendto(re_sent_packet, sent_addr)
    timers[idx-1]=threading.Timer(0.02,retrans,args=[idx,])
    timers[idx-1].start()
    recounts +=1
    print("resent_counts",recounts)  
    # print(sent_packet)
# u=(32,32)
# U=numpy.zeros(u)
# print(U)
work_data = "work_data"
u_data ="u_data"
#定义数据包类
p=[]
for i in range(0,s):
    p.append(i)
class packet:
    def __init__(self,i):
        self.wid = 2
        self.ver = 2
        self.idx = i
        self.off = 0
        self.vector = []
for i in range(0,s):
    p[i]=packet(i)
# 生成socket对象
ss = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
ss.bind((WORKER2_IP,SML_PORT))
# 链接要链接的ip和port（端口）
sent_addr=(SERVER_IP,SML_PORT)
# 读取梯度值
f1 = open(work_data, "r")
f2 = open(u_data, "w")
sent_data = f1.read()
sent_data = sent_data.split()
sent_data = list(map(float, sent_data))  # 把数据转换成浮点数
# p.off=0
# 发送数据
t1=time.time()
for i in range(1, s+1):
    p[i-1].idx = i
    p[i-1].off = k * i-k
    if p[i-1].off + k <= len(sent_data):
        sent_vector = sent_data[p[i-1].off:p[i-1].off + k]
        wid_field = struct.pack(">i", p[i-1].wid)
        ver_field = struct.pack(">i", p[i-1].ver)
        idx_field = struct.pack(">i", p[i-1].idx)
        off_field = struct.pack("i", p[i-1].off)
        sent_packet = wid_field + ver_field + idx_field + off_field
        for ii in range(len(sent_vector)):
            sent_vector[ii] = int(sent_vector[ii] * 2 ** 29)
            sent_packet += struct.pack("i", sent_vector[ii])
        #print("sent idx={0} off={1} ver={2} again:".format(p[i-1].idx,p[i-1].off,p[i-1].ver))
        #print("sent packet length:",len(sent_packet))
        ss.sendto(sent_packet, sent_addr)
        # for ii in range(len(sent_vector)):
        #     sent_packet += struct.pack("f", sent_vector[ii])
        timers.append(threading.Timer(5,retrans,args=[p[i-1].idx,]))
        timers[p[i-1].idx-1].start()
        counts=counts+1
        print("sent counts:",counts)
        #print("yes")
        time.sleep(interval)
        # print(vector)
    else:
        wid_field = struct.pack(">i", p[i-1].wid)
        ver_field = struct.pack(">i", p[i-1].ver)
        idx_field = struct.pack(">i", p[i-1].idx)
        off_field = struct.pack("i", p[i-1].off)
        sent_packet = wid_field + ver_field + idx_field + off_field
        sent_vector = sent_data[p[i-1].off:]
        for iii in range(len(sent_vector)):
            sent_vector[iii] = int(sent_vector[iii] * 2 ** 29)
            sent_packet += struct.pack("i", sent_vector[iii])
            # sent_packet += struct.pack("f", sent_vector[iii])
        # print(vector)
    # print(p[i].off)
counter=0
print("recieve data:")
while True:
    # 接收数据
    #print(counter)
    recv_packet,recv_addr=ss.recvfrom(10240)
    counter=counter+1
    print("recv_counter:",counter)
    recv_data=[]
    recv_i=int(struct.unpack(">i",recv_packet[8:12])[0])
    print("recv_idx",recv_i)
    print("cancel timer{0} ".format(recv_i))
    timers[recv_i-1].cancel()
    #p[recv_i-1].wid=int(struct.unpack(">i",recv_packet[0:4])[0])
    p[recv_i-1].ver=int(struct.unpack(">i",recv_packet[4:8])[0])
    # p.off=int(struct.unpack("i",recv_packet[12:16])[0])
    for d in range(12,len(recv_packet),4):
        recv_data.append(struct.unpack("i",recv_packet[d:d+4])[0])
    #print(recv_data)
    p[recv_i-1].off=int(recv_data[0])
    #print("recv idx={0},off={1},ver={2}".format(p[recv_i-1].idx,p[recv_i-1].off,p[recv_i-1].ver))
    recv_vector=recv_data[1:]
    for i in range(len(recv_vector)):
        recv_vector[i]=float(recv_vector[i]/(2**29))
    #print(recv_vector)
    
    sent_data[p[recv_i-1].off:p[recv_i-1].off+k]=recv_vector
    p[recv_i-1].off += k*s
    print("p[recv_i-1].off:", p[recv_i-1].off)
    if p[recv_i-1].off<len(sent_data) and p[recv_i-1].off+k <= len(sent_data):
        p[recv_i-1].ver =p[recv_i-1].ver  % 2+1
        sent_vector = sent_data[p[recv_i-1].off:p[recv_i-1].off + k]
        wid_field = struct.pack(">i", p[recv_i-1].wid)
        ver_field = struct.pack(">i", p[recv_i-1].ver)
        idx_field = struct.pack(">i", p[recv_i-1].idx)
        off_field = struct.pack("i", p[recv_i-1].off)
        sent_packet = wid_field + ver_field + idx_field + off_field
        for ii in range(len(sent_vector)):
            sent_vector[ii] = int(sent_vector[ii] * 2 ** 29)
            sent_packet += struct.pack("i", sent_vector[ii])
        print("sent again:")
        #print("sent idx={0} off={1} ver={2} again:".format(recv_i,p[recv_i-1].off,p[recv_i-1].ver))
            # sent_packet += struct.pack("f", sent_vector[ii])  
        #print("sent again length:",len(sent_packet))
        ss.sendto(sent_packet, sent_addr)
        timers[recv_i-1]=threading.Timer(0.02,retrans,args=[recv_i])
        timers[recv_i-1].start()
        counts=counts+1
        print("sent counts:",counts)
        time.sleep(interval)
    elif p[recv_i-1].off<len(sent_data) and p[recv_i-1].off+k > len(sent_data):
        p[recv_i-1].ver = p[recv_i-1].ver  % 2+1
        wid_field = struct.pack(">i", p[recv_i-1].wid)
        ver_field = struct.pack(">i", p[recv_i-1].ver)
        idx_field = struct.pack(">i", p[recv_i-1].idx)
        off_field = struct.pack("i", p[recv_i-1].off)
        sent_packet = wid_field + ver_field + idx_field + off_field
        sent_vector = sent_data[p[recv_i-1].off:]
        for iii in range(len(sent_vector)):
            sent_vector[iii] = int(sent_vector[iii] * 2 ** 29)
            sent_packet += struct.pack("i", sent_vector[iii])
            # sent_packet += struct.pack("f", sent_vector[iii])
        ss.sendto(sent_packet, sent_addr)
        timers[recv_i-1] = threading.Timer(0.02, retrans, args=[recv_i])
        timers[recv_i-1].start()
    if counter == math.ceil(len(sent_data)/k):
        print("done!")
        break
t2=time.time()
print("t2-t1:",t2-t1)
for list_men in sent_data:
    # off=0
    # for i in range(k):
    f2.write(str(list_men)+ " ")
    # off=k*i
f2.flush()
f1.close()
f2.close()
for i in range(0,s):
   timers[i].cancel()
    # p.off = p.off + k
ss.close()
print("resent_counts",recounts)
print('Connection is broken')
for i in range(0,s):
   timers[i].cancel()
    # p.off = p.off + k
