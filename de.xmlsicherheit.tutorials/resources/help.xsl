<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:sec="http://www.xml-sicherheit.de">
	<xsl:output method="html"/>
	<xsl:template match="sec:chapter">
		<html>
			<head>
				<xsl:choose>
					<xsl:when test="/sec:chapter/@category='general'">
						<link rel="stylesheet" type="text/css" href="format.css"/>
					</xsl:when>
					<xsl:otherwise>
						<link rel="stylesheet" type="text/css" href="../format.css"/>
					</xsl:otherwise>
				</xsl:choose>
			</head>
			<body>
				<xsl:apply-templates/>
			</body>
		</html>
	</xsl:template>
	<xsl:template match="sec:title">
		<xsl:call-template name="title"/>
	</xsl:template>
	<xsl:template match="sec:text/sec:p">
		<xsl:call-template name="text"/>
	</xsl:template>
	<xsl:template match="sec:text/sec:list">
		<xsl:call-template name="list"/>
	</xsl:template>
	<xsl:template match="sec:code">
		<xsl:call-template name="code"/>
	</xsl:template>
	<xsl:template match="sec:text/sec:acronyms">
		<xsl:call-template name="acronym"/>
	</xsl:template>
	<xsl:template match="sec:text/sec:headline">
		<xsl:call-template name="headline"/>
	</xsl:template>
	<xsl:template match="sec:text/sec:table">
		<xsl:call-template name="table"/>
	</xsl:template>
	<xsl:template match="sec:image">
		<xsl:call-template name="image"/>
	</xsl:template>
	<xsl:template name="title">
		<h1>
			<xsl:value-of select="/sec:chapter/sec:title"/>
		</h1>
	</xsl:template>
	<xsl:template name="headline">
		<h2>
			<xsl:if test="@id">
				<xsl:attribute name="id"><xsl:value-of select="@id"/></xsl:attribute>
			</xsl:if>
			<xsl:apply-templates/>
		</h2>
	</xsl:template>
	<xsl:template name="table">
		<table cellspacing="0">
			<thead>
				<tr>
					<xsl:for-each select="sec:head/sec:data">
						<th><xsl:value-of select="."/></th>
					</xsl:for-each>
				</tr>
			</thead>
			<tbody>
				<xsl:for-each select="sec:row">
					<tr>
						<xsl:choose>
							<xsl:when test="position() mod 2 > 0">
								<xsl:attribute name="class">uneven</xsl:attribute>
							</xsl:when>
							<xsl:otherwise>
								<xsl:attribute name="class">even</xsl:attribute>
							</xsl:otherwise>
						</xsl:choose>
						<xsl:for-each select="sec:data">
							<td><xsl:value-of select="."/></td>
						</xsl:for-each>
					</tr>
				</xsl:for-each>
			</tbody>
		</table>
	</xsl:template>
	<xsl:template name="code">
		<div class="code">
			<pre>
				<xsl:apply-templates/>
			</pre>
		</div>
	</xsl:template>
	<xsl:template name="list">
		<xsl:choose>
			<xsl:when test="@type='unordered'">
				<ul>
					<xsl:apply-templates/>
				</ul>
			</xsl:when>
			<xsl:otherwise>
				<ol>
					<xsl:apply-templates/>
				</ol>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="sec:point">
			<li><xsl:apply-templates/></li>
	</xsl:template>
	<xsl:template name="text">
		<p>
			<xsl:if test="@id">
				<xsl:attribute name="id"><xsl:value-of select="@id"/></xsl:attribute>
			</xsl:if>
			<xsl:apply-templates/>
		</p>
	</xsl:template>
	<xsl:template name="image">
		<div align="center">
			<img>
				<xsl:attribute name="src"><xsl:value-of select="@id"/></xsl:attribute>
				<xsl:attribute name="alt"><xsl:value-of select="@title"/></xsl:attribute>
				<xsl:attribute name="width"><xsl:value-of select="@width"/></xsl:attribute>
				<xsl:attribute name="height"><xsl:value-of select="@height"/></xsl:attribute>
			</img>
			<p><em><xsl:value-of select="@title"/></em></p>
		</div>
	</xsl:template>
	<xsl:template match="sec:strong">
		<strong>
			<xsl:apply-templates/>
		</strong>
	</xsl:template>
	<xsl:template match="sec:link">
		<a>
			<xsl:attribute name="href"><xsl:value-of select="@id"/></xsl:attribute>
			<xsl:apply-templates/>
		</a>
	</xsl:template>
	<xsl:template match="sec:keyword">
		<em>
			<xsl:apply-templates/>
		</em>
	</xsl:template>
	<xsl:template name="acronym">
		<table cellspacing="0">
			<thead>
				<tr>
					<th>Akronym</th>
					<th>Beschreibung</th>
				</tr>
			</thead>
			<tbody>
				<xsl:for-each select="sec:acronym">
					<tr>
						<xsl:choose>
							<xsl:when test="position() mod 2 > 0">
								<xsl:attribute name="class">uneven</xsl:attribute>
							</xsl:when>
							<xsl:otherwise>
								<xsl:attribute name="class">even</xsl:attribute>
							</xsl:otherwise>
						</xsl:choose>
						<td><strong><xsl:value-of select="@abbreviation"/></strong></td>
						<td><em><xsl:value-of select="sec:definition"/></em><br /><xsl:value-of select="sec:description"/></td>
					</tr>
				</xsl:for-each>
			</tbody>
		</table>
	</xsl:template>
</xsl:stylesheet>
