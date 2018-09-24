{
    system("./iplookup.sh "$0" ips | mysql -utest -p1234567 myssh")
    #system("./iplookup.sh "$0" ips >> test")
}
