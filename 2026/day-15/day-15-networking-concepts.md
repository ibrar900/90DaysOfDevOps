# Day 15 – Networking Concepts: DNS, IP, Subnets & Ports

You will:
- Understand how **DNS** resolves names to IPs
- <img width="1864" height="834" alt="Screenshot 2026-02-08 225351" src="https://github.com/user-attachments/assets/57f55a80-338e-43c4-af74-1aef1dfcab81" />

DNS acts as an address book. It translates human-readable domain names (google.com) to machine-readable IP addresses (142.251.46.238).

To achieve better scalability, the DNS servers are organized in a hierarchical tree structure.There are 3 basic levels of DNS servers:

Root name server (.). It stores the IP addresses of Top Level Domain (TLD) name servers. There are 13 logical root name servers globally. google.com microsoft.com facebook.com

TLD name server. It stores the IP addresses of authoritative name servers. There are several types of TLD names. For example, generic TLD (.com, .org), country code TLD (.us), test TLD (.test).

Authoritative name server. It provides actual answers to the DNS query. You can register authoritative name servers with domain name registrar such as GoDaddy, Namecheap, etc.

- Learn **IP addressing** (IPv4, public vs private)
  
  <img width="969" height="676" alt="image" src="https://github.com/user-attachments/assets/9d97aa05-3e63-446f-b6bd-5e392e1db82c" />

Ip address classes are devided in to 5 classes
Class            Range                        subnet mask                no of Networks      No of Hosts
A        1.0.0.0 - 126.0.0.1                  255.0.0.0 / 8               126                16,777,214
B        128.0.0.0 - 191.255.255.255          255.255.0.0 / 16            16,384             16,534
C        192.0.0.0 - 223.255.255.255          255.255.255.0 / 24          2,097,152          254
D        224.0.0.0 - 239.255.255.255          -------------               -----------        ---------- Reserved For Testing and Muticasting
E        240.0.0.0 - 254.255.255.255          -------------               -----------        ---------- Experiments
Every Class or subnet ip range's First ip (Network ip) and Last ip address (Braodcast ip) reserved can't be used.
127.0.0.0 - 127.255.255.255 range ip are reserved for OS testing loop back address ex: ping: 127.0.0.0 (localaddress)  
  
- Break down **CIDR notation** and **subnetting** basics
<img width="4800" height="7801" alt="CIDR_Chart-1" src="https://github.com/user-attachments/assets/5c96090f-aa4f-43c2-b349-d8c316880439" />

- Know common **ports** and why they matter
<img width="2360" height="2720" alt="common-port numbers" src="https://github.com/user-attachments/assets/735d0253-62a2-407b-aac6-c59bebeae78d" />

FTP (File Transfer Protocol)        : Port 21
SSH (Secure Shell for Login)        : Port 22
Telnet                              : Port 23 for remote login
SMTP (Simple Mail Transfer Protocol): Port 25
DNS                                 : Port 53 for DNS queries
DHCP Server                         : Port 67
DHCP Client                         : Port 68
HTTP (Hypertext Transfer Protocol)  : Port 80
POP3 (Post Office Protocol V3)      : Port 110
NTP (Network Time Protocol)         : Port 123
NetBIOS                             : Port 139 for NetBIOS service
IMAP (Internet Message Access Protocol):Port 143
HTTPS (Secure HTTP)                 : Port 443
SMB (Server Message Block)          : Port 445
Oracle DB                           : Port 1521 for Oracle database communication port
MySQL                               : Port 3306 for MySQL database communication port
RDP                                 : Port 3389 for Remote Desktop Protocol
PostgreSQL                          : Port 5432 for PostgreSQL database communication

<img width="468" height="622" alt="image" src="https://github.com/user-attachments/assets/59ca5ba3-2254-4685-9b24-d7808b12ab42" />


## Challenge Tasks

### Task 1: DNS – How Names Become IPs
1. Explain in 3–4 lines: what happens when you type `google.com` in a browser?
the browser resolves the domain name to an IP address via DNS, establishes a secure connection (HTTPS), and sends a request to Google's servers. Google then redirects to the regional site (e.g., .co.in or .com), fetching HTML, CSS, and JavaScript to display the search homepage. 
   
3. What are these record types? Write one line each:
   - `A`, `AAAA`, `CNAME`, `MX`, `NS`
DNS records (A, AAAA, CNAME, MX, NS) are instructions in the Domain Name System that map domain names to IP addresses or other resources. A records map domains to IPv4 addresses, AAAA maps to IPv6, CNAME aliases names to other names, MX directs mail, and NS defines authoritative name servers. 
Here is a breakdown of the specific record types:
A Record (Address): Maps a domain or subdomain to a 32-bit IPv4 address, directly connecting a website name to its server.
AAAA Record (IPv6 Address): Maps a domain or subdomain to a 128-bit IPv6 address, acting as the modern counterpart to the A record.
CNAME Record (Canonical Name): Acts as an alias that maps a hostname (subdomain) to another hostname, rather than an IP address. It cannot be used for the root domain (e.g., example.com), only subdomains (e.g., www.example.com).
MX Record (Mail Exchanger): Specifies the mail servers responsible for receiving email on behalf of a domain, directing traffic to the correct mail server.
NS Record (Name Server): Identifies which DNS servers are authoritative for a domain, meaning they hold the actual, up-to-date DNS records and are responsible for answering queries about that domain.

4. Run: `dig google.com` — identify the A record and TTL from the output
<img width="1512" height="578" alt="Screenshot 2026-02-08 212030" src="https://github.com/user-attachments/assets/8276ec62-9d17-4485-bf1f-68182e3713ae" />

---

### Task 2: IP Addressing
1. What is an IPv4 address? How is it structured? (e.g., `192.168.1.10`)
<img width="509" height="279" alt="image" src="https://github.com/user-attachments/assets/7717edd1-a733-429c-8e91-3e94130fcbb2" />

2. Difference between **public** and **private** IPs — give one example of each
Public IP addresses are globally unique identifiers assigned by ISPs for direct internet access.
private IPs are used for local, secure communication within a home or office network (assigned by routers DHCP)

3. What are the private IP ranges?
    10.0.0.0     - 10.255.255.255
    172.16.0.0   - 172.31.255.255
    192.168.0.0  - 192.168.255.255

4. Run: `ip addr show` — identify which of your IPs are private
<img width="1542" height="427" alt="Screenshot 2026-02-08 211132" src="https://github.com/user-attachments/assets/48b4e0fa-fb38-4e6d-8888-0197a0430584" />

---

### Task 3: CIDR & Subnetting
1. What does `/24` mean in `192.168.1.0/24`?
   24 bits of the IP address are used to identify the network
   
2. How many usable hosts in a `/24`? A `/16`? A `/28`?
  /24 (255.255.255.0): 2^{8}-2 = 254 usable hosts.( 256 Total ip addresses first network ip and last broadcast ip not usable )
  /16 (255.255.0.0): 2^{16}-2 = 65,534 usable hosts.( 65,536 Total ip addresses first network ip and last broadcast ip not usable )
  /28 (255.255.255.240): 2^{4}-2 = 14 usable hosts. ( 16 Total ip addresses first network ip and last broadcast ip not usable )

3. Explain in your own words: why do we subnet?
   Make large network in to samll small networks to secure and easily manage
   
4. Quick exercise — fill in:

| CIDR | Subnet Mask      | Total IPs | Usable Hosts |
|------|------------------|-----------|--------------|
| /24  | 255.0.0.0        | 256       | 254          |
| /16  | 255.255.0.0      | 65,536    | 65,534       |
| /28  | 255.255.255.240  | 16        | 14           |

---

### Task 4: Ports – The Doors to Services
1. What is a port? Why do we need them?
  Port number is 16-bit identifier used in networking protocols for a specific application program to use inside computer OS 
3. Document these common ports:

| Port | Service |
|------|---------|
| 22   | SSH     |
| 80   | HTTP    |
| 443  | HTTPS   |
| 53   | DNS     |
| 3306 | MySQl DB|
| 6379 | REDIS   |
| 27017| MangoDB |

3. Run `ss -tulpn` — match at least 2 listening ports to their services
<img width="1529" height="675" alt="Screenshot 2026-02-08 212846" src="https://github.com/user-attachments/assets/f2dde110-4d65-4a15-ac32-1f09558420d4" />

---

### Task 5: Putting It Together
Answer in 2–3 lines each:
- You run `curl http://myapp.com:8080` — what networking concepts from today are involved?
- Your app can't reach a database at `10.0.1.50:3306` — what would you check first?

---

## Documentation

- Command outputs from `dig` and `ss`
<img width="1512" height="578" alt="Screenshot 2026-02-08 212030" src="https://github.com/user-attachments/assets/a66c8a13-57c1-4c9f-96cd-2d18e827b74f" />
<img width="1529" height="675" alt="Screenshot 2026-02-08 212846" src="https://github.com/user-attachments/assets/d69f3c75-0a88-4e7a-9d73-4869c2fce1e9" />

- The filled CIDR table
- What you learned (3 key points)
  IP Class Ranges and Subnet mask
  service port numers for system applications
  How internet works and what are all services behinnd the records

## Learn in Public

Share what you learned about DNS, subnets, or ports on LinkedIn.

```
#90DaysOfDevOps #DevOpsKaJosh #TrainWithShubham
```

Happy Learning!
**TrainWithShubham**
