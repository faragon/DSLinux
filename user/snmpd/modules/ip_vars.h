#ifndef		_IPVARS_H_
#define		_IPVARS_H_

CVoidType	ipInit (void);

#define IPFORWARDING	0
#define IPDEFAULTTTL	1
#define IPINRECEIVES	2
#define IPINHDRERRORS	3
#define IPINADDRERRORS	4
#define IPFORWDATAGRAMS 5
#define IPINUNKNOWNPROTOS 6
#define IPINDISCARDS	7
#define IPINDELIVERS	8
#define IPOUTREQUESTS	9
#define IPOUTDISCARDS	10
#define IPOUTNOROUTES	11
#define IPREASMTIMEOUT	12
#define IPREASMREQDS	13
#define IPREASMOKS	14
#define IPREASMFAILS	15
#define IPFRAGOKS	16
#define IPFRAGFAILS	17
#define IPFRAGCREATES	18

#endif		/*	_IPVARS_H_	*/
