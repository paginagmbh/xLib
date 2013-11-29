<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
	xmlns:pa="http://www.pagina-online.de/xlib" exclude-result-prefixes="xs xd pa" version="2.0">

	<xd:doc>
		<xd:desc>
			<xd:p>pagina-Namensraum instanziieren und xlib includieren</xd:p>
		</xd:desc>
	</xd:doc>
	<xsl:include href="../../../xlib.xsl"/>
	<xd:doc>
		<xd:desc>
			<xd:p>Root Template: Aufruf der Funktion merge_files_from_source_folder</xd:p>
			<xd:p>übergeben wird nur der Document Node</xd:p>
			<xd:p>Die Funktion spielt alle Dokumente aus dem Quellverzeichnis direkt zusammen. Sie können über copy-of direkt eingefügt werden, oder in eine Variable abgelegt werden (zum Beispiel um nur auf bestimmte Werte zuzugreifen)</xd:p>
		</xd:desc>
	</xd:doc>
	<xsl:template match="/">
		<root>
			<xsl:copy-of select="pa:merge_files_from_source_folder(/)"/>
		</root>
	</xsl:template>
</xsl:stylesheet>
