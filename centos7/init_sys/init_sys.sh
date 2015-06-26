#/bin/sh
#os version: CentOS-7-x86_64-Minimal-1503-01.iso

# 0. change repo to 163
mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup
curl -0 /etc/yum.repos.d/CentOS7-Base-163.repo  http://mirrors.163.com/.help/CentOS7-Base-163.repo

# 1. update
yum -y update

# 2. ntp 
yum -y install ntp ntpdate
ntpdate pool.ntp.org
systemctl enable ntpd
systemctl start ntpd
timedatectl set-timezone Asia/Shanghai

# 3. close selinux
sed -i '/SELINUX/s/enforcing/disabled/' /etc/selinux/config 

# 4. sys tools
yum install -y vim strace telnet lsof
