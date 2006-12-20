##
#
# 
# This script was written by KK Liu 
# [LSD] Critical security vulnerability in Microsoft Operating Systems 
# Check methods based on Eeye's MSRPC scanner 1.03
# 
# Updated 7/29/2003 - Now works for NT4
# Updated 8/13/2003 - Now works for Win 95/98/ME
#
#

if(description)
{
 script_id(11808);
 script_cve_id("CAN-2003-0352");
 if(defined_func("script_xref"))script_xref(name:"IAVA", value:"2003-A-0011");
 script_bugtraq_id(8205);
 script_version ("$Revision$");
 
 name["english"] = "Microsoft RPC Interface Buffer Overrun (823980)";
 script_name(english:name["english"]);
 
 desc["english"] = "
The remote host is running a version of Windows which has a flaw in 
its RPC interface which may allow an attacker to execute arbitrary code 
and gain SYSTEM privileges.  There is at least one Worm which is 
currently exploiting this vulnerability.  Namely, the MsBlaster worm.
 
 Solution: see http://www.microsoft.com/technet/security/bulletin/MS03-026.asp 
 Risk factor : Serious";
 
 script_description(english:desc["english"]);
 
 summary["english"] = "[LSD] Critical security vulnerability in Microsoft Operating Systems";
 script_summary(english:summary["english"]);
 
 script_category(ACT_ATTACK);
 
 script_copyright(english:"This script is Copyright (C) 2003 KK LIU");
 family["english"] = "Gain root remotely";
 script_family(english:family["english"]);
 script_dependencies("msrpc_dcom2.nasl");
 script_require_ports("Services/msrpc", 135, 593); 
 exit(0);
}



#
# The script code starts here
#

if(get_kb_item("SMB/KB824146"))exit(0);
if(get_kb_item("SMB/KB824146_cant_be_verified"))exit(0);

function dcom_recv(socket)
{
 local_var buf, len;
 
 buf = recv(socket:socket, length:9);
 if(strlen(buf) != 9)return NULL;
 
 len = ord(buf[8]);
 buf += recv(socket:socket, length:len - 9);
 return buf;
}
 

debug = 0;

bindwinme = raw_string(
0x05,0x00,0x0b,0x03,0x10,0x00,0x00,0x00,0x48,0x00,0x00,0x00,0x53,0x53,0x56,0x41,
0xd0,0x16,0xd0,0x16,0x00,0x00,0x00,0x00,0x01,0x00,0x00,0x00,0x00,0x00,0x01,0x00,
0xe6,0x73,0x0c,0xe6,0xf9,0x88,0xcf,0x11,0x9a,0xf1,0x00,0x20,0xaf,0x6e,0x72,0xf4,
0x02,0x00,0x00,0x00,0x04,0x5d,0x88,0x8a,0xeb,0x1c,0xc9,0x11,0x9f,0xe8,0x08,0x00,
0x2b,0x10,0x48,0x60,0x02,0x00,0x00,0x00
);

bindstr = raw_string(
0x05,0x00,0x0b,0x03,0x10,0x00,0x00,0x00,0x48,0x00,0x00,0x00,0x53,0x53,0x56,0x41,
0xd0,0x16,0xd0,0x16,0x00,0x00,0x00,0x00,0x01,0x00,0x00,0x00,0x00,0x00,0x01,0x00,
0xb8,0x4a,0x9f,0x4d,0x1c,0x7d,0xcf,0x11,0x86,0x1e,0x00,0x20,0xaf,0x6e,0x7c,0x57,
0x00,0x00,0x00,0x00,0x04,0x5d,0x88,0x8a,0xeb,0x1c,0xc9,0x11,0x9f,0xe8,0x08,0x00,
0x2b,0x10,0x48,0x60,0x02,0x00,0x00,0x00
);

request= raw_string(
0x05,0x00,0x00,0x03,0x10,0x00,0x00,0x00,0xc6,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
0xae,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x05,0x00,0x01,0x00,0x00,0x00,0x00,0x00,
0x00,0x00,0x00,0x00,0x5b,0x4e,0x45,0x53,0x53,0x55,0x53,0x5d,0x5b,0x4e,0x45,0x53,
0x53,0x55,0x53,0x5d,0x00,0x00,0x00,0x00,0x53,0x53,0x56,0x41,0x32,0x30,0x30,0x33,
0x53,0x53,0x56,0x41,0x32,0x30,0x30,0x33,0x68,0x0f,0x0b,0x00,0x1e,0x00,0x00,0x00,
0x00,0x00,0x00,0x00,0x1e,0x00,0x00,0x00,0x5c,0x00,0x5c,0x00,0x53,0x4f,0x43,0x00,
0x00,0x00,0x00,0x00,0x63,0x00,0x24,0x00,0x5c,0x00,0x53,0x00,0x53,0x00,0x56,0x00,
0x41,0x00,0x5f,0x00,0x32,0x00,0x30,0x00,0x30,0x00,0x33,0x00,0x5f,0x00,0x4e,0x00,
0x45,0x00,0x53,0x00,0x53,0x00,0x45,0x00,0x53,0x00,0x2e,0x00,0x74,0x00,0x78,0x00,
0x74,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x02,0x00,0x00,0x00,0x02,0x00,0x00,0x00,
0x01,0x00,0x00,0x00,0xb8,0xeb,0x0b,0x00,0x01,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x01,0x00,0x00,0x00,
0x01,0x00,0x00,0x00,0x07,0x00
);


chk[0] = raw_string (0x00,0x04,0x00,0x08); 
chk[1] = raw_string (0x00,0x05,0x00,0x07);
chk[2] = raw_string (0x00,0x00,0x20,0x00);
chk[3] = raw_string (0x02,0x00,0x01,0x00);

report = "";
port = 135;
if(!get_port_state(port))
{
 port = 593;
}
else
{
 soc = open_sock_tcp(port);
 if(!soc)port = 593;
 else close(soc);
}

if(get_port_state(port))
{
    soc = open_sock_tcp(port);
	if(soc)
	{
	    send(socket:soc,data:bindwinme);
            rwinme  = dcom_recv(socket:soc);
            if(!strlen(rwinme))exit(0);
	    lenwinme = strlen(rwinme);
	    stubwinme = substr(rwinme, lenwinme-24, lenwinme-21);
	    if (debug)
	    {
	    	display('len = ', lenwinme, '\n');
		display('stub  = ', hexstr(stubwinme), '\n');
		display('r = ', hexstr(rwinme), '\n');
	    }
	    if (stubwinme >< chk[3])
	    {
	    	if (debug) display("Windows 95/98/ME found secure!\n");
		exit(0);
            }
	    close(soc);
	}
	soc = open_sock_tcp(port);
	if(soc)
	{
	    send(socket:soc, data:bindstr);
	    r  = dcom_recv(socket:soc);
	    if(!strlen(r))exit(0);
	    send(socket:soc, data:request);
	    r  = dcom_recv(socket:soc);
	    if(!strlen(r))
	    {
	    	exit(0);
	    }
	    close(soc);
	    
	    len = strlen(r);
	    stub = substr(r, len-25, len-22);
	    if (debug) 
	    {
	    	display('running second test\n');
	    	display('len  = ', len, '\n');
		display('r = ', hexstr(r), '\n');
	    	display('stub = ', hexstr(stub),  '\n');
	    }
		if ((stub >!< chk[0]) && (stub >!< chk[1]) && (stub >!< chk[2]))
		{
	        if (debug) display("Warning: Vulnerable MSRPC host found!\n");
		security_hole(port:port);
		}
 
    }
}

