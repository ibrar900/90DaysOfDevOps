# Day 14 – Networking Fundamentals & Hands-on Checks

<img width="1396" height="733" alt="Screenshot 2026-02-08 203831" src="https://github.com/user-attachments/assets/d45de6e6-2106-4107-b38c-d94b8353ff9d" />

The **OSI vs TCP/IP models** in your own words

OSI Model

<img width="1402" height="721" alt="Screenshot 2026-02-08 203954" src="https://github.com/user-attachments/assets/6c14c918-66f2-45d5-a18a-dc10ac213618" />

OSI is a conceptual model that defines network communication. It consists of 7 layers where each layer performs a specific function 

Application L7 - User interaction ( Browsers, Email clents) - Protocols HTTP HTTPS SMTP FTP
Presentation L6 - Data compress, encryption/ decompress, decryption, format conversion to end user readable
Session L5 - Establish/manage/terminate sessions between local and remote applications
Transport L4 - Handle end to end communication and error correction (TCP/UDP).
Netwrok L3 -  the best physical path for data routing, IP addressing, routing.
Data Link L2 - Error‑free node‑to‑node delivery. mac address table maintaing
Physical L1 - SWitches routers Hardware, cables, fiber signal wireless signals 

- TCP/IP stack (Link, Internet, Transport, Application)

<img width="1388" height="729" alt="Screenshot 2026-02-08 204237" src="https://github.com/user-attachments/assets/2b33db64-b0d2-45b8-8bf9-a0199308a740" />

- Where **IP**, **TCP/UDP**, **HTTP/HTTPS**, **DNS** sit in the stack
- One real example: “`curl https://trainwithshubham.com` = App layer over TCP over IP” ( Whole Website it will show in programming )

- **Identity:** `hostname -I` (or `ip addr show`) — note your IP.
 <img width="1542" height="427" alt="Screenshot 2026-02-08 211132" src="https://github.com/user-attachments/assets/fafc70ff-c6dd-40c7-96ae-2f5eebc20514" />

- **Reachability:** `ping <target>` — mention latency and packet loss.
  <img width="1540" height="313" alt="image" src="https://github.com/user-attachments/assets/d408993a-1820-426f-8c63-3bde7c8a707c" />

- **Path:** `traceroute <target>` (or `tracepath`) — note any long hops/timeouts.
  <img width="1522" height="846" alt="image" src="https://github.com/user-attachments/assets/70095178-9f82-4cce-ad0a-5a46c7d4b4bd" />

- **Ports:** `ss -tulpn` (or `netstat -tulpn`) — list one listening service and its port.
  <img width="1514" height="506" alt="image" src="https://github.com/user-attachments/assets/da21a240-480b-4c46-913d-c9c162fc42c0" />

- **Name resolution:** `dig <domain>` or `nslookup <domain>` — record the resolved IP.
  <img width="1512" height="578" alt="image" src="https://github.com/user-attachments/assets/e64940df-fb4f-4245-a052-370ca81e6648" />
  <img width="1524" height="285" alt="image" src="https://github.com/user-attachments/assets/7c7b3fab-7008-4792-8929-0183af5e6788" />

- **HTTP check:** `curl -I <http/https-url>` — note the HTTP status code.
  <img width="1528" height="535" alt="image" src="https://github.com/user-attachments/assets/619e59e4-4d42-4437-b66a-844dcdf9d07a" />

- **Connections snapshot:** `netstat -an | head` — count ESTABLISHED vs LISTEN (rough).
  <img width="1529" height="590" alt="image" src="https://github.com/user-attachments/assets/074d3624-29fe-43da-a963-0a4ffdab477c" />

- **Network Gateway:** 'ip r' it will route network gateway path.
  <img width="1535" height="137" alt="image" src="https://github.com/user-attachments/assets/35918bf6-bcff-4b10-abd7-431881bae12b" />

## Mini Task: Port Probe & Interpret
1) Identify one listening port from `ss -tulpn` (e.g., SSH on 22 or a local web app).
<img width="1529" height="675" alt="image" src="https://github.com/user-attachments/assets/b29dbd3c-c6aa-400f-a1a8-cbf0396d63b8" />


Use hashtags:  
#90DaysOfDevOps  
#DevOpsKaJosh  
#TrainWithShubham

Happy Learning  
**TrainWithShubham**
