#/bin/sh
#os version: CentOS-7-x86_64-Minimal-1503-01.iso

# 0. change repo to aliyun
mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup
curl -o /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo
yum makecache

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
yum install -y vim strace telnet lsof wget

# 5. change ssh port
yum -y install policycoreutils-python
semanage port -a -t ssh_port_t -p tcp 3520
cp -p /etc/ssh/sshd_config /etc/ssh/sshd_config.orig.$(date +%F)
sed -i 's/^#Port 22/Port 3520/g' /etc/ssh/sshd_config
firewall-cmd --permanent --zone=public --add-port=3520/tcp
firewall-cmd --reload
systemctl restart sshd.service
