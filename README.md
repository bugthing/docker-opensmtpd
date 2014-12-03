# docker-opensmtpd

Docker image providing a very simple opensmtpd service

Intended to accept mail for configured domains and relay onward to other email addresses

## Build

    docker build -t bugthing/docker-opensmtpd .

## Start

Before starting the container ensure you have done the following;

 - Write virtual-domains.txt
 - Write virtual-users.txt
 - Write secrets (if outgoing mail servers requires auth)
 - Write smtpd.conf

Once configure you can start the container like so:

    docker run -d -p 25:25 -v /custom/config:/etc/smtpd bugthing/docker-opensmtpd

## Config Files

I have tested this with the following files in a directory which was then mounted within the container at `/etc/smtpd`

### smtpd.conf

    listen on  0.0.0.0
    table secrets file:/etc/smtpd/secrets
    table vdoms file:/etc/smtpd/virtual-domains.txt
    table vusers file:/etc/smtpd/virtual-users.txt
    accept from any for domain <vdoms> virtual <vusers> deliver to mbox
    accept from local for any relay via smtps+auth://smtpauth@mail.btinternet.com:465 auth <secrets>

### secrets

    smtpauth supauser@btinternet.com:SupaSecret

### virtual-domains.txt

    exampledomain.com

### virtual-users.txt

    dave@exampledomain.com davenumber100@googlemail.com

## More Info

https://www.opensmtpd.org/smtpd.conf.5.html

https://wiki.archlinux.org/index.php/OpenSMTPD
