# timeoutserver
A simple webserver that can be used for producing timeouts for developing purposes

Usage: perl timeoutserver.pl to start server. It connects to port 8080.

A simple request to the server: `curl localhost:8080` Default timeout: 5s.

To set own timeout: `curl localhost:8080?to=5`.
To set own return-value: `curl localhost:8080?return=ready`.
To set own return-value and timeout: `curl localhost:8080?to=10&return=ready`.



