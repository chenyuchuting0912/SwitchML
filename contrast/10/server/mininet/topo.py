#coding=utf-8
#!/usr/bin/python

# Copyright 2013-present Barefoot Networks, Inc. 
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

from mininet.net import Mininet
from mininet.topo import Topo
from mininet.log import setLogLevel, info
from mininet.cli import CLI
from mininet.link import TCLink

from p4_mininet import P4Switch, P4Host

import argparse
from time import sleep
import os
import subprocess

_THIS_DIR = os.path.dirname(os.path.realpath(__file__))#返回file所在的目录
_THRIFT_BASE_PORT = 22222

parser = argparse.ArgumentParser(description='Mininet demo')#创建一个解析对象
parser.add_argument('--behavioral-exe', help='Path to behavioral executable',
                    type=str, action="store", required=True)
parser.add_argument('--json', help='Path to JSON config file',
                    type=str, action="store", required=True)
parser.add_argument('--cli', help='Path to BM CLI',
                    type=str, action="store", required=True)

args = parser.parse_args()#从指定的选项中返回一些数据

class MyTopo(Topo):
    def __init__(self, sw_path, json_path, nb_hosts, nb_switches, links, **opts):
        # Initialize topology and default options
        # 初始化拓扑和默认选项
        Topo.__init__(self, **opts)

        for i in range(nb_switches):
            switch = self.addSwitch('s%d' % (i + 1),
                                    sw_path = sw_path,
                                    json_path = json_path,
                                    thrift_port = _THRIFT_BASE_PORT + i,
                                    pcap_dump = True,
                                    device_id = i)
        
        for h in range(nb_hosts):
            #host = self.addHost('h%d' % (h + 1),cpu=.5/nb_hosts)
            host=self.addHost('h%d' % (h + 1))

        for a, b in links:
            #linkopt={'bw':10,'delay':'5ms','loss':0,'max_queue_size':1000}
            #self.addLink(a, b, cls=TCLink, **linkopt)
            if a=='h11':
                self.addLink(a, b, cls=TCLink, bw=10, delay='5ms', loss=0, max_queue_size=1000, use_htb=True)
            else :
                self.addLink(a, b, cls=TCLink, bw=10, delay='5ms', loss=0, max_queue_size=1000, use_htb=True)
        
            #self.addLink(a,b)


def read_topo():
    nb_hosts = 0
    nb_switches = 0
    links = []
    with open("topo.txt", "r") as f:
        line = f.readline()[:-1]
        w, nb_switches = line.split()
        assert(w == "switches")
        line = f.readline()[:-1]
        w, nb_hosts = line.split()
        assert(w == "hosts")
        for line in f:
            if not f: break
            a, b = line.split()
            links.append( (a, b) )
    return int(nb_hosts), int(nb_switches), links
            

def main():
    nb_hosts, nb_switches, links = read_topo()

    topo = MyTopo(args.behavioral_exe,
                  args.json,
                  nb_hosts, nb_switches, links)

    net = Mininet(topo = topo,
                  #link=TCLink,
                  host = P4Host,
                  switch = P4Switch,
                  controller = None,
                  autoStaticArp=True )
    net.start()

    for n in range(nb_hosts):
        h = net.get('h%d' % (n + 1))
        for off in ["rx", "tx", "sg"]:
            cmd = "/sbin/ethtool --offload eth0 %s off" % off
            print(cmd)
            h.cmd(cmd)
        print("disable ipv6")
        h.cmd("sysctl -w net.ipv6.conf.all.disable_ipv6=1")
        h.cmd("sysctl -w net.ipv6.conf.default.disable_ipv6=1")
        h.cmd("sysctl -w net.ipv6.conf.lo.disable_ipv6=1")
        h.cmd("sysctl -w net.ipv4.tcp_congestion_control=reno")
        h.cmd("iptables -I OUTPUT -p icmp --icmp-type destination-unreachable -j DROP")

        #设置ip
        h.setIP("10.0.0.%d" % (n + 1))
        h.setMAC("aa:bb:cc:dd:ee:0%d" % (n + 1))
        for i in range(nb_hosts):
            if (i != n):
                h.setARP("10.0.0.%d" % (i + 1), "aa:bb:cc:dd:ee:0%x" % (i + 1))
        net.get('s1').setMAC("aa:bb:cc:dd:ee:1%x" % (n + 1), "s1-eth%d" % (n + 1))

    sleep(1)

    for i in range(nb_switches):
        #cmd = [args.cli, "--json", args.json, "--thrift-port", str(_THRIFT_BASE_PORT + i)]
        cmd = [args.cli, args.json, str(_THRIFT_BASE_PORT + i)]
        with open("commands.txt", "r") as f:
            print(" ".join(cmd))
            try:
                output = subprocess.check_output(cmd, stdin = f)
                print(output)
            except subprocess.CalledProcessError as e:
                print(e)
                print (e.output)

    sleep(1)

    print("Ready !")

    CLI( net )
    net.stop()

if __name__ == '__main__':
    setLogLevel( 'info' )
    main()
