#!/usr/bin/perl
 {
 package Timeoutserver;
 
 use HTTP::Server::Simple::CGI;
 use base qw(HTTP::Server::Simple::CGI);
 
 
 sub handle_request {
     my $self = shift;
     my $cgi  = shift;
   
     my $path = $cgi->path_info();
     my $handler = \&response_handler;
 
     if (ref($handler) eq "CODE") {
         print "HTTP/1.0 200 OK\r\n";
         $handler->($cgi);
         
     } else {
         print "HTTP/1.0 404 Not found\r\n";
         print $cgi->header,
               $cgi->start_html('Not found'),
               $cgi->h1('Not found'),
               $cgi->end_html;
     }
 }
 
 sub response_handler {
    my $cgi  = shift;   # CGI.pm object

    return if !ref $cgi;
     
    my $timeout = $cgi->param('to') || 5;
    if($timeout !~ /^\d*$/) {
        $timeout = 5;

    }
    my $return = $cgi->param('return');
    if((not defined $return ) || $return eq '') {
      $return = "Timeout $timeout";
    }

    sleep($timeout);

     print $cgi->header;
     print $return;
     $cgi->end_html;
 }
 
 } 
 
 # start the server on port 8080
 my $pid = Timeoutserver->new(8080)->run;
 print "Use 'kill $pid' to stop server.\n";
