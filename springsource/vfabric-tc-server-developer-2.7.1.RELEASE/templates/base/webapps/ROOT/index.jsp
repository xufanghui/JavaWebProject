<%@ page import="org.apache.catalina.util.ServerInfo;" session="false" %>
<!DOCTYPE HTML>
<html>

<head>
	<link rel="shortcut icon" href="http://www.springsource.com/sites/all/themes/zen/springsource2/favicon.ico" type="image/x-icon">
	<title>VMware vFabric tc Server &#8212; Developer Edition with Spring Insight</title>
	<link type="text/css" rel="stylesheet" href="splash.css">
</head>

<body>
	<div id="container">

		<!-- Header -->
		<div id="hdr"><span class="utility"><a href="http://www.vmware.com/products/vfabric/" title="VMware vFabric, Cloud Application Platform">VMware vFabric, Cloud Application Platform</a></span><a href="http://www.vmware.com/" title="VMware"><h1>VMware</h1></a></div>
		<div class="clearfix"></div>

		<!-- Body -->
		<div id="content">
			<div id="intro">
				<h4>VMware vFabric</h4>
				<h2>tc Server &#8212; Developer Edition with Spring Insight</h2>
				<h3 class="title">Congratulations! You have successfully setup and started vFabric tc Server Developer Edition.  You are ready to go!</h3>
			</div>

			<div class="bodyrule"><hr /></div>

			<div id="toc">
				<!-- Table of Contents -->
				<h4 class="modHdr">vFabric tc Server Developer Edition Online</h4>
				<ul>
					<li><a href="http://www.springsource.com/developer/tcserver">Home</a></li>
					<li><a href="http://www.vmware.com/support/pubs/vfabric-tcserver.html">Documentation</a></li>
					<li><a href="http://forum.springsource.org/forumdisplay.php?f=71">Discussion</a></li>
					<li><a href="https://issuetracker.springsource.com/browse/INSIGHT">Issues</a></li>
					<li><a href="http://www.springsource.com/developer/sts">SpringSource Tool Suite (STS)</a></li>
				</ul>
			</div>

			<div>
				<h3>More information can be found at:</h3>
				<ul>
					<li>
						<a href="http://www.springsource.com/products/tcserver/devedition">vFabric tc Server Developer Edition Homepage</a><br />The official home for the Developer Edition and Spring Insight.
						<ul>
							<li><a href="http://www.vmware.com/support/pubs/vfabric-tcserver.html">vFabric tc Server Documentation</a><br />Find out what it does, how to use it, and other useful information.</li>
							<li><a href="http://forum.springsource.org/forumdisplay.php?f=71">vFabric tc Server Discussion Forum</a><br />Tell us what you think, start a conversation with other users and discuss application performance.</li>
							<li><a href="https://issuetracker.springsource.com/browse/INSIGHT">vFabric tc Server Issues &amp; Improvements (Jira)</a><br />Found a problem or a bug? Got an idea about how to make Spring Insight better? Open a ticket in JIRA and let us know about it.</li>
							<li><a href="http://www.springsource.com/products/sts">SpringSource Tool Suite (STS)</a><br />Go here to download the latest STS release with Spring Insight bundled in!</li>
						</ul>
					</li>
					<li><a href="http://www.vmware.com/products/vfabric-tcserver/">vFabric tc Server Standard Edition Homepage</a><br />The official home for vFabric tc Server Standard Edition.</li>
				</ul>
			</div>
		</div>

		<div class="clearfix"></div>
		<div id="versions">
			VMware vFabric tc Server Developer Edition 2.7.1.RELEASE<br/>
			<% out.println(ServerInfo.getServerInfo()); %>
		</div>
		<div id="ftr">&copy; 2011 VMware, Inc. All rights reserved.</div>
	</div>

</body>
</html>
