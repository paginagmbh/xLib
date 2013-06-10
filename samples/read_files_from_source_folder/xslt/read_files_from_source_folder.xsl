<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
	xmlns:pa="http://www.pagina-online.de/xlib" exclude-result-prefixes="xs xd pa" version="2.0">

	<xd:doc>
		<xd:desc>
			<xd:p>Pagina-Namensraum instanziieren und xlib includieren</xd:p>
		</xd:desc>
	</xd:doc>
	<xsl:include href="file:/H:/9-Skripte/XSLT/pagina.xslt.library/xlib.xsl"/>

	<xd:doc>
		<xd:desc>
			<xd:p>Root Template: Aufruf der Funktion read_files_from_source_folder</xd:p>
		</xd:desc>
	</xd:doc>
	<xsl:template match="/">
		<root>
			<xsl:copy-of select="pa:read_files_from_source_folder('files','file',/)"/>
			<xsl:copy-of select="pa:read_files_from_source_folder('hans','wurst',/)"/>
			
			<xsl:variable name="myFiles" select="pa:read_files_from_source_folder('foo','bar',/)"/>
			<value><xsl:copy-of select="$myFiles/bar/dokument/name/@attribute"/></value>
		</root>
	</xsl:template>
</xsl:stylesheet>
