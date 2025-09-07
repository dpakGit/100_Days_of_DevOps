### Most important article : https://tundedamian.medium.com/day-14-of-100-days-of-devops-linux-process-troubleshooting-3b86d8fae5ad



### Task Breakdown: Fixing Apache Service Unavailability

The task involves identifying and fixing an issue with the Apache service on one of the app servers in Stratos DC, ensuring Apache is up and running on all app hosts on port 8082.

Step 1: Identify the Faulty App Host
- Use telnet to check connectivity to Apache on port 8082 (though the search result indicates port 8087 was used in a similar task) on each app server (e.g., stapp01, stapp02, stapp03) from a jump host.
- Look for a "Connection refused" message indicating the faulty server.

Step 2: Fix the Issue on the Faulty App Host
- SSH into the faulty app server and switch to the root user.
- Check Apache (httpd) service status using systemctl status httpd.
- If Apache failed to start, check if another service is using port 8082 using netstat -tulnp | grep :8082.
- If a conflict is found (like sendmail using the port in a similar task), stop and disable that service ¹.
- Start Apache using systemctl start httpd and verify its status.

Step 3: Ensure Apache is Running on Port 8082
- Verify Apache is listening on port 8082 on all app servers.
- Check Apache configuration (/etc/httpd/conf/httpd.conf) for the Listen directive to ensure it's set to port 8082.

Verification
- Use telnet from the jump host to verify connectivity to Apache on port 8082 on all app servers.

#### In short :
1. Check and start Apache (`httpd`) if needed.
2. Verify port 3002 usage with `ss`/`netstat`.
3. Stop/disable `sendmail`.
4. Restart Apache.
5. Re-check port 3002.
6. Verify Apache status.


## What I Did
------------------------------
```
systemctl status httpd
systemctl start httpd

ss -tulnp | grep :3002
ss -tlnp | grep :3002

netstat -tulnp | grep :3002
netstat -tlnp | grep :3002

systemctl stop sendmail
systemctl disable sendmail
systemctl restart httpd

ss -tulnp | grep :3002
ss -tlnp | grep :3002
netstat -tlnp | grep :3002

systemctl status httpd
```
------------------------------

#### Explanation of the above commands sequentially and what they do:

Explanation of Each Command and Process:

1. ```systemctl status httpd``` : Checks the current status of the Apache HTTP server (httpd).

2. ```systemctl start httpd``` : Starts the Apache HTTP server if it's not running.

3. ```ss -tulnp | grep :3002``` : Checks if any process is listening on port 3002 for both TCP and UDP.

4. ```ss -tlnp | grep :3002``` : Checks if any TCP process is listening on port 3002.

5. ```netstat -tulnp | grep :3002``` : Similar to ss -tulnp, checks TCP/UDP listeners on port 3002 using netstat.

6. ```netstat -tlnp | grep :3002``` : Similar to ss -tlnp, checks TCP listeners on port 3002 using netstat.

7. ```systemctl stop sendmail``` : Stops the sendmail service.

8. ```systemctl disable sendmail``` : Disables sendmail from starting automatically on boot.

9. ```systemctl restart httpd``` : Restarts the Apache HTTP server.

10. ```Repeated checks with ss/netstat on port 3002``` : Re-check if anything listens on port 3002 after changes.

11. ```systemctl status httpd``` : Checks Apache HTTP server status again after restart.

##### Entire Process Accomplished

- Initial check/start Apache: Check status, start if needed.

- Check port 3002 usage: Using ss and netstat, for TCP/UDP.

- *Manage sendmail*: Stop and disable it (likely to free up a port like 8082 earlier).

- Restart Apache: After sendmail changes.

- Re-check port 3002: Verify if anything listens on port 3002.

- Final Apache status check.

-----------------------------------------------


**Note:**

**Difference Between ss -tulnp and ss -tlnp**
- *ss -tulnp*:
    - -t: Show TCP sockets.
    - -u: Show UDP sockets.
    - -l: Show listening sockets.
    - -n: Don't resolve names.
    - -p: Show processes using sockets.
- *ss -tlnp*:
    - Shows *only TCP (-t)* listening (-l) sockets.
    - No UDP sockets shown because -u is missing.

*Outcome for :3002*
- If something listens on TCP port 3002, both commands show it.
- If something listens on UDP port 3002, only *ss -tulnp* shows it.


*Example: ss Commands with Port 3002*
- Suppose:
    - A TCP service listens on port 3002.
    - A UDP service listens on port 3003.

Output
- *ss -tlnp | grep :3002*:
    - Shows the TCP service on port 3002.
- *ss -tulnp | grep :3002*:
    - Shows the TCP service on port 3002 (no UDP on 3002).
- *ss -tulnp | grep :3003*:
    - Shows the UDP service on port 3003.

Example Commands:

bash
- Shows TCP on 3002
ss -tlnp | grep :3002

- Shows TCP + UDP listeners on 3002
ss -tulnp | grep :3002

-----------------------------------------

**Difference Between netstat -tulnp and netstat -tlnp**

- *netstat -tulnp*:
    - -t: Show TCP sockets.
    - -u: Show UDP sockets.
    - -l: Show listening sockets.
    - -n: Don't resolve names.
    - -p: Show processes using sockets.
- *netstat -tlnp*:
    - Shows *only TCP (-t)* listening (-l) sockets.
    - No UDP sockets shown because -u is missing.

Example with Port 3002
- Suppose:
    - A TCP service listens on port 3002.
    - A UDP service listens on port 3003.

Output
- *netstat -tlnp | grep :3002*:
    - Shows the TCP service on port 3002.
- *netstat -tulnp | grep :3002*:
    - Shows the TCP service on port 3002 (no UDP on 3002).
- *netstat -tulnp | grep :3003*:
    - Shows the UDP service on port 3003.



**Difference Between ss and netstat**
- *ss vs netstat*:
    - Both show socket statistics.
    - *ss* is newer, part of iproute2 package.
    - *netstat* is part of net-tools, considered legacy on some systems.
- Output is similar for same options (-tulnp).
- *ss often faster* and more efficient.

Example with Port 3002
- *ss -tulnp | grep :3002* and *netstat -tulnp | grep :3002*:
    - Both show TCP/UDP listeners on port 3002 if any.

Availability
- On modern Linux, *ss* likely available; *netstat* might need net-tools install.
