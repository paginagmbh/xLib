pagina xLib
====

Die pagina xLib ist eine XSLT Function Library und bündelt einige XSLT-Funktionen aus unserem Entwickler-Alltag.

Freilich ist das keine umfassende Sammlung aller von uns eingesetzten Funktionen, aber einige davon möchten wir in der pagina xLib auch der XSLT-Community zugänglich machen.

Die `xd:doc`-Dokumentation als oXygen Web-Output ist um Unterverzeichnis `doc/` zu finden.

Einige Funktionen (vor allem die XML-JOIN-Operationen) sind auch mit Beispieldaten im Unterordner `samples/` versehen.


Einsatz
------

`xlib.xsl` herunterladen und in bestehendes XSLT-Projekt includieren. pagina-Namensraum nicht vergessen!

```xslt
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:pa="http://www.pagina-online.de/xlib"
  exclude-result-prefixes="pa"
  version="2.0">
  
	<xsl:include href="xlib.xsl"/>
	
	...
	
</xsl:stylesheet>
```
