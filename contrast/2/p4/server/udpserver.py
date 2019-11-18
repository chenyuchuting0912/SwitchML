#udp服务端
import socket
import struct
WORKER1_IP="10.0.0.1"
WORKER2_IP="10.0.0.2"
SERVER_IP="10.0.0.3"
SML_PORT=8888
ip_port=(SERVER_IP,SML_PORT)
buffer_size=1024
udp_server=socket.socket(socket.AF_INET,socket.SOCK_DGRAM) #数据报
udp_server.bind(ip_port)
test="text.txt"
f3=open(test, "w")
while True: #通信循环
    # 接收数据
    recv_packet,recv_addr=udp_server.recvfrom(buffer_size)
    recv_data=[]
    for d in range(0,len(recv_packet),4):
        recv_data.append(struct.unpack("i",recv_packet[d:d+4])[0])
    print(recv_data)
    idx=int(recv_data[0])
    off = int(recv_data[1])
    print(idx,off)
    recv_vector=recv_data[2:]
    for i in range(len(recv_vector)):
        recv_vector[i]=float(recv_vector[i]/(2**29))
        print(recv_vector)
        f3.write(str(recv_vector[i])+' ')
    f3.write("\n")
    f3.flush()
f3.close()
udp_server.close()