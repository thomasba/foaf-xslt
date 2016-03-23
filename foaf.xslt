<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:foaf="http://xmlns.com/foaf/spec/"
	xmlns:pos="http://www.w3.org/2003/01/geo/wgs84_pos#"
	xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
	xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
	xmlns:xsd="http://www.w3.org/2001/XMLSchema#">
<xsl:template match="/rdf:RDF">
	<html>
		<head>
			<meta charset="utf-8" />
			<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
			<meta name="viewport" content="width=device-width" />
			<title><xsl:value-of select="//foaf:person/foaf:name"/></title>
			<style type="text/css">
				body { max-width: 820px; margin: 0 auto; font-family: "Helvetica Neue",Helvetica,Arial,sans-serif; padding: 0 10px}
				div { -webkit-columns: 300px 2; -moz-columns: 300px 2; columns: 300px 2;  }
				h5  { margin-bottom: 0; }
				img { height:auto; width:auto; max-width:200px; max-height:200px; }
				ul, p { padding-left: 1.5em; }
				a   { color: #0096ff; }
				a:hover { color: #f3a234; }
				h1,h2,h3,h4,h5,h6 { color:#0c5dcb; }
				h1 { border-bottom:1px solid #0c5dcb; }
				h2 { border-bottom:1px dotted #0c5dcb; }
				.no-margin { margin: 0; padding: 0 }
			</style>
		</head>
		<body>
			<xsl:for-each select="foaf:person">
				<h1>
					<xsl:choose>
						<xsl:when test="foaf:name"><xsl:value-of select="foaf:name"/></xsl:when>
						<xsl:otherwise>
							<xsl:if test="foaf:firstname"><xsl:value-of select="foaf:firstname"/></xsl:if>
							<xsl:if test="foaf:lastname"><xsl:value-of select="foaf:lastname"/></xsl:if>
						</xsl:otherwise>
					</xsl:choose>
				</h1>
				<div>
					<xsl:if test="foaf:nick">
						<p class="no-margin">
							Nick: <strong><xsl:value-of select="foaf:nick" /></strong>
						</p>
					</xsl:if>
					<xsl:if test="foaf:img">
						<p class="no-margin">
							<img src="{foaf:img/@rdf:resource}" />
						</p>
					</xsl:if>
					<xsl:if test="foaf:birthday">
						<h5>Birthday</h5>
						<p><xsl:value-of select="foaf:birthday" /></p>
					</xsl:if>
					<xsl:if test="foaf:mbox/@rdf:resource[starts-with(.,'mailto:')]">
						<h5>eMail</h5>
						<ul>
							<xsl:for-each select="foaf:mbox/@rdf:resource[starts-with(.,'mailto:')]">
								<li>
									<a href="{.}"><xsl:value-of select="substring-after(., 'mailto:')" /></a>
									<xsl:if test="//rdf:Description[@rdf:about=current()/../@rdf:resource]/rdfs:label">
										(<xsl:value-of select="//rdf:Description[@rdf:about=current()/../@rdf:resource]/rdfs:label" />)
									</xsl:if>
								</li>
							</xsl:for-each>
						</ul>
					</xsl:if>
					<xsl:if test="foaf:phone">
						<h5>Phone</h5>
						<ul>
							<xsl:for-each select="foaf:phone">
								<li>
									<a href="{@rdf:resource}"><xsl:value-of select="substring-after(@rdf:resource, 'tel:')" /></a>
									<xsl:if test="//rdf:Description[@rdf:about=current()/@rdf:resource]/rdfs:label">
										(<xsl:value-of select="//rdf:Description[@rdf:about=current()/@rdf:resource]/rdfs:label" />)
									</xsl:if>
								</li>
							</xsl:for-each>
						</ul>
					</xsl:if>
					<xsl:if test="foaf:mbox/@rdf:resource[starts-with(.,'fax:')]">
						<h5>Fax</h5>
						<ul>
							<xsl:for-each select="foaf:mbox/@rdf:resource[starts-with(.,'fax:')]">
								<li>
									<a href="{.}"><xsl:value-of select="substring-after(., 'fax:')" /></a>
									<xsl:if test="//rdf:Description[@rdf:about=current()/../@rdf:resource]/rdfs:label">
										(<xsl:value-of select="//rdf:Description[@rdf:about=current()/../@rdf:resource]/rdfs:label" />)
									</xsl:if>
								</li>
							</xsl:for-each>
						</ul>
					</xsl:if>
					<xsl:if test="foaf:tipjar">
						<h5>Tipjar</h5>
						<ul>
							<xsl:for-each select="foaf:tipjar">
								<li><a href="{@rdf:resource}"><xsl:value-of select="@rdf:resource" /></a></li>
							</xsl:for-each>
						</ul>
					</xsl:if>
					<xsl:if test="foaf:basedNear">
						<h5>Based near</h5>
						<ul>
							<xsl:for-each select="foaf:basedNear">
								<xsl:choose>
									<xsl:when test="(@rdf:resource and //rdf:Description[@rdf:about=current()/@rdf:resource]/rdfs:label)">
										<li><a href="{@rdf:resource}"><xsl:value-of select="//rdf:Description[@rdf:about=current()/@rdf:resource]/rdfs:label" /></a></li>
									</xsl:when>
									<xsl:when test="@rdf:resource">
										<li><a href="{@rdf:resource}"><xsl:value-of select="document(@rdf:resource)//rdf:Description/rdfs:label[@xml:lang='de']" /></a></li>
									</xsl:when>
									<xsl:when test="pos:Point">
										<li>
											<a href="https://maps.google.com/?q={pos:Point/pos:lat},+{pos:Point/pos:lon}">
												<xsl:value-of select="pos:Point/pos:lat" />, <xsl:value-of select="pos:Point/pos:lon" />
											</a>
										</li>
									</xsl:when>
									<xsl:otherwise>
										<li>Unknown type</li>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:for-each>
						</ul>
					</xsl:if>
					<xsl:if test="(foaf:yahooChatID | foaf:icqChatID | foaf:aimChatID | foaf:jabberID | foaf:skypeID | foaf:msnChatID)">
						<h5>Instant Messengers</h5>
						<ul>
							<xsl:for-each select="(foaf:yahooChatID | foaf:icqChatID | foaf:aimChatID | foaf:jabberID | foaf:skypeID | foaf:msnChatID)">
								<li>
									<xsl:choose>
										<xsl:when test="name(.) = 'jabberID'">XMPP: <a href="xmpp:{.}"><xsl:value-of select="."/></a></xsl:when>
										<xsl:when test="name(.) = 'icqChatID'">ICQ: <xsl:value-of select="."/></xsl:when>
										<xsl:when test="name(.) = 'aimChatID'">AOL: <a href="aim:{.}"><xsl:value-of select="."/></a></xsl:when>
										<xsl:when test="name(.) = 'yahooChatID'">Yahoo: <xsl:value-of select="."/></xsl:when>
										<xsl:when test="name(.) = 'skypeID'">Skype: <a href="skype:{.}"><xsl:value-of select="."/></a></xsl:when>
										<xsl:when test="name(.) = 'msnChatID'">MSN: <a href="msnim:{.}"><xsl:value-of select="."/></a></xsl:when>
										<xsl:otherwise><xsl:value-of select="." /></xsl:otherwise>
									</xsl:choose>
								</li>
							</xsl:for-each>
						</ul>
					</xsl:if>
					<xsl:if test="foaf:homepage">
						<h5>Homepage(s)</h5>
						<ul>
							<xsl:for-each select="foaf:homepage">
								<li><a href="{@rdf:resource}"><xsl:value-of select="@rdf:resource"/></a></li>
							</xsl:for-each>
						</ul>
					</xsl:if>
					<xsl:if test="foaf:account">
						<h5>Online profiles</h5>
						<ul>
							<xsl:for-each select="foaf:account/foaf:OnlineAccount">
								<li>
									<xsl:choose>
										<xsl:when test="(rdfs:seeAlso) and (rdfs:label)">
											<a href="{rdfs:seeAlso/@rdf:resource}"><xsl:value-of select="foaf:accountName" /></a>
											on
											<a href="{foaf:accountServiceHomepage/@rdf:resource}"><xsl:value-of select="rdfs:label" /></a>
										</xsl:when>
										<xsl:when test="rdfs:seeAlso">
											<a href="{rdfs:seeAlso/@rdf:resource}"><xsl:value-of select="foaf:accountName" /></a>
											on
											<a href="{foaf:accountServiceHomepage/@rdf:resource}"><xsl:value-of select="foaf:accountServiceHomepage/@rdf:resource" /></a>
										</xsl:when>
										<xsl:when test="rdfs:label">
											<a href="{concat(foaf:accountServiceHomepage/@rdf:resource, foaf:accountName)}"><xsl:value-of select="foaf:accountName" /></a>
											on
											<a href="{foaf:accountServiceHomepage/@rdf:resource}"><xsl:value-of select="rdfs:label" /></a>
										</xsl:when>
										<xsl:otherwise>
											<a href="{concat(foaf:accountServiceHomepage/@rdf:resource, foaf:accountName)}"><xsl:value-of select="foaf:accountName" /></a>
											on
											<a href="{foaf:accountServiceHomepage/@rdf:resource}"><xsl:value-of select="foaf:accountServiceHomepage/@rdf:resource" /></a>
										</xsl:otherwise>
									</xsl:choose>
								</li>
							</xsl:for-each>
						</ul>
					</xsl:if>
					<xsl:if test="foaf:openid">
						<h5>Things this person made</h5>
						<ul>
							<xsl:for-each select="foaf:made">
								<li><a href="{@rdf:resource}"><xsl:value-of select="@rdf:resource"/></a></li>
							</xsl:for-each>
						</ul>
					</xsl:if>
					<xsl:if test="foaf:openid">
						<h5>OpenID</h5>
						<ul>
							<xsl:for-each select="foaf:openid">
								<li><a href="{@rdf:resource}"><xsl:value-of select="@rdf:resource"/></a></li>
							</xsl:for-each>
						</ul>
					</xsl:if>
					<xsl:if test="foaf:knows">
						<h5>Persons this person is interested in</h5>
						<ul>
							<xsl:for-each select="foaf:topic_interest">
								<xsl:choose>
									<xsl:when test="//rdf:Description[@rdf:about=current()/@rdf:resource]/rdfs:label">
										<li><a href="{@rdf:resource}"><xsl:value-of select="//rdf:Description[@rdf:about=current()/@rdf:resource]/rdfs:label"/></a></li>
									</xsl:when>
									<xsl:otherwise>
										<li><a href="{@rdf:resource}"><xsl:value-of select="@rdf:resource"/></a></li>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:for-each>
						</ul>
					</xsl:if>
					<xsl:if test="foaf:knows">
						<h5>Persons this person knows</h5>
						<ul>
							<xsl:for-each select="foaf:knows">
								<xsl:choose>
									<xsl:when test="//rdf:Description[@rdf:about=current()/@rdf:resource]/foaf:name">
										<li><a href="{@rdf:resource}"><xsl:value-of select="//rdf:Description[@rdf:about=current()/@rdf:resource]/foaf:name"/></a></li>
									</xsl:when>
									<xsl:otherwise>
										<li><a href="{@rdf:resource}"><xsl:value-of select="@rdf:resource"/></a></li>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:for-each>
						</ul>
					</xsl:if>
				</div>
			</xsl:for-each>
		</body>
	</html>
</xsl:template>
</xsl:stylesheet>
