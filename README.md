pagina xLib
====

Die pagina xLib ist eine XSLT Function Library und bündelt einige XSLT-Funktionen aus unserem Entwickler-Alltag. Sie steht unter einer offenen MIT-Lizenz ([_Was ist erlaubt?_](http://choosealicense.com/licenses/mit/)).

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

Funktionen
------

* **pa:read_files_from_source_folder**
 * Liest alle XML-Dokumente des Ordners einer XML-Quelldatei ein und speichert Sie jeweils in einem definierbaren Container Element. Gleichzeitig können noch Abfragen auf die Dokumente ausgeführt werden.
 * Siehe Beispiel `samples/read_files_from_source_folder/`
* **pa:merge_files_from_source_folder**
 * Fügt alle Dokumente aus dem Quellverzeichnis ein. Übergeben wird immer der document-node "/"
 * Siehe Beispiel `samples/merge_files_from_source_folder/`
* **pa:reorder**
 * Ordnet die enhaltenen Elemente des übergebenen Kontext-Elements anhand einer ebenfalls übergabenen Liste nach dem Muster 'element_a element_b #rest element_c ...', wobei #rest für "Alle anderen Elemente außer die in der Liste aufgeführten" steht. Reguläre Ausdrücke bei den Elementnamen werden unterstützt.
* **pa:create_uri** (deprecated)
 * Wandelt einen übergebenen Pfad in eine gültige URI um
* **pa:load_xml**
 * Lädt XML aus einer Datei in eine Variable, aber nur, wenn die Datei auch wirklich vorhanden ist
* **pa:get-current-xpath**
 * Funktion um den Absoluten Pfad des Kontext-Knotens zu ermitteln
 * Äquivalent zur Saxon-Extension `saxon:path()` jedoch in purem XSLT 2 implementiert
* **pa:Character-to-hexCode**
 * Gibt den hexadezimalen Code eines Unicode-codierten Zeichens zurück. Rückgabeformat: mind. 4-stellig mit führenden Nullen und `#x`
* **pa:decimal-to-hex**
 * Wandelt eine Dezimalzahl in hexadezimalformat um
* **pa:is-not-element**
 * Not-Element Prüfung
