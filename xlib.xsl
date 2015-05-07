<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
				xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
				xmlns:xs="http://www.w3.org/2001/XMLSchema" 
				xmlns:pa="http://www.pagina-online.de/xlib"
				exclude-result-prefixes="xs xd"
				version="2.0">
	
	
	<xd:doc scope="stylesheet">
		<xd:desc>
			<xd:p>=======================================================================================</xd:p>
			<xd:p><xd:b>Titel:</xd:b> pagina xLib</xd:p>
			<xd:p><xd:b>Projekt:</xd:b> pagina - Entwicklung - Projektübergreifend</xd:p>
			<xd:p><xd:b>Version:</xd:b> 0.7</xd:p>
			<xd:p><xd:b>Datum:</xd:b> 2015-05-06</xd:p>
			<xd:p><xd:b>Autoren:</xd:b></xd:p>
			<xd:ul>
				<xd:li>Björn Dünckel</xd:li>
				<xd:li>Gregor Fellenz</xd:li>
				<xd:li>Tobias Fischer</xd:li>
				<xd:li>Rupert Jung</xd:li>
			</xd:ul>
			<xd:p><xd:b>Copyright:</xd:b> 2011-2015 pagina GmbH, Tübingen</xd:p>
			<xd:p>=======================================================================================</xd:p>
			<xd:p>Die pagina XLib sammelt XSLT-Funktionen für den Projektübergreifenden Einsatz.</xd:p>
			<xd:p>Andere Quellen für XSLT Funktionen:</xd:p>
			<xd:ul>
				<xd:li>
					<xd:a href="http://www.xsltfunctions.com/">FunctX XSLT Functions</xd:a>
				</xd:li>
				<xd:li>
					<xd:a href="http://www.exslt.org/">EXSLT</xd:a>
				</xd:li>
				<xd:li>
					<xd:a href="http://code.google.com/p/xslt-sb/">XSLT-SB</xd:a>
				</xd:li>
			</xd:ul>
		</xd:desc>
	</xd:doc>
	
	
	<!-- ============================================================================================================================================ -->
	
	
	<xd:doc>
		<xd:desc>
			<xd:p><xd:b>Funktion:</xd:b> Erzeugt ein Container Element ($1). Liest alle XML-Dokumente des Ordners einer Quelldatei ein und speichert Sie in ein weiteres Container Element ($2). Übergeben wird immer der document-node "/" ($3).</xd:p>
		</xd:desc>
		<xd:param>Name des umgebendesn Container-Elements für die Dateien</xd:param>
		<xd:param>Name des umgebendesn Container-Elements für die einzelne Datei</xd:param>
		<xd:param>Document Node "/"</xd:param>
	</xd:doc>
	<xsl:function name="pa:read_files_from_source_folder">
		<xsl:param name="files_container" as="xs:string"/>
		<xsl:param name="file_container" as="xs:string"/>
		<xsl:param name="rootnode" as="node()"/>
		<xsl:element name="{$files_container}">
			<xsl:for-each
				select="collection(concat(substring-before(document-uri($rootnode), tokenize(document-uri($rootnode), '/')[last()]),'?select=*.xml'))">
				<xsl:element name="{$file_container}">
					<xsl:copy-of select="document(document-uri(/))"/>
				</xsl:element>
			</xsl:for-each>
		</xsl:element>
	</xsl:function>
	
	
	<!-- ============================================================================================================================================ -->
	
	
	<xd:doc>
		<xd:desc>
			<xd:p><xd:b>Funktion:</xd:b> Fügt alle Dokumente aus dem Quellverzeichnis ein. Übergeben wird immer der document-node "/" ($3).</xd:p>
		</xd:desc>
		<xd:param>Document Node "/"</xd:param>
	</xd:doc>
	<xsl:function name="pa:merge_files_from_source_folder">
		<xsl:param name="rootnode" as="node()"/>
		<xsl:for-each select="collection(concat(substring-before(document-uri($rootnode), tokenize(document-uri($rootnode), '/')[last()]),'?select=*.xml'))">
				<xsl:copy-of select="document(document-uri(/))"/>
		</xsl:for-each>
	</xsl:function>
	
	
	<!-- ============================================================================================================================================ -->
	
	
	<xd:doc>
		<xd:desc>
			<xd:p>Ordnet die enhaltenen Elemente des übergebenen Kontext-Elements anhand einer ebenfalls übergabenen Liste nach dem Muster 'element_a element_b #rest element_c ...', 
			wobei #rest für "Alle anderen Elemente außer die in der Liste aufgeführten" steht. Reguläre Ausdrücke bei den Elementnamen werden unterstützt.</xd:p>
		</xd:desc>
		<xd:param name="context_item">Das Kontext-Item (geht beim Funktionsaufruf sonst verloren)</xd:param>
		<xd:param name="orderlist">Liste der neu zu ordnenden Elementen in der Reihenfolge des Aufrufs nach der Form 'element_a element_b #rest element_c ...', wobei #rest für "Alle anderen Elemente außer die in der Liste aufgeführten" steht. Reguläre Ausdrücke bei den Elementnamen werden unterstützt.</xd:param>
	</xd:doc>
	<xsl:function name="pa:reorder" xmlns:pag="http://www.pagina-online.de">

		<!--Das Kontext-Item (geht beim Funktionsaufruf sonst verloren)-->
		<xsl:param name="context_item"/>

		<!--Liste der neu zu ordnenden Elementen in der Reihenfolge des Aufrufs nach der Form 'element_a element_b #rest element_c ...', 
			wobei #rest für "Alle anderen Elemente außer die in der Liste aufgeführten" steht. Reguläre Ausdrücke bei den Elementnamen werden unterstützt.-->
		<xsl:param name="orderlist" as="xs:string"/>

		<!--Übergebene Elementliste aufsplitten-->
		<xsl:variable name="elements" select="tokenize($orderlist, '\s+')"/>

		<!--Elementliste durchlaufen-->
		<xsl:for-each select="$elements">

			<!--Aktuelles Element in Variable speichern ('self::' ändert sich später)-->
			<xsl:variable name="element" select="."/>

			<!--Fallunterscheidung für den Namen des Elements-->
			<xsl:choose>

				<!--ggf. alle anderen Elemente abarbeiten-->
				<xsl:when test=".='#rest'">

					<!--Alle Elemente prozessieren, die NICHT zu einem der Ausdrücke (RegExp) in der Elementliste passen-->
					<xsl:apply-templates
						select="$context_item/* except ($context_item/*[some $regex in $elements satisfies (matches(name(), $regex))])"
					/>
				</xsl:when>

				<!--Normaler Elementaufruf-->
				<xsl:otherwise>

					<!--Alle Elemente prozessieren, die zum Ausdruck passen (RegExp)-->
					<xsl:apply-templates select="$context_item/*[matches(name(), $element)]"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>

	</xsl:function>
	
	
	<!-- ============================================================================================================================================ -->
	
	
	<xd:doc>
		<xd:desc>
			<xd:p>(deprecated) Wandelt einen übergebenen Pfad in eine gültige URI um</xd:p>
			<xd:p>Besser ist die direkte Verwendung von <xd:i>resolve-uri($path, base-uri())</xd:i></xd:p>
		</xd:desc>
		<xd:param name="path">Pfad der umzuwandeln ist</xd:param>
	</xd:doc>
	<xsl:function name="pa:create_uri">
		<xsl:param name="path" as="xs:string"/>
		
		<xsl:value-of select="concat('file:///', replace(replace($path, '\\', '/'), ' ', '%20'))"/>
	</xsl:function>
	
	
	<!-- ============================================================================================================================================ -->
	
	
	<xd:doc>
		<xd:desc>
			<xd:p>Lädt XML aus einer Datei in eine Variable, aber nur, wenn die Datei auch wirklich vorhanden ist</xd:p>
		</xd:desc>
		<xd:param name="path_or_uri">Pfad zur XML-Datei</xd:param>
	</xd:doc>
	<xsl:function name="pa:load_xml">
		<xsl:param name="path_or_uri"/>
		
		<xsl:if test="doc-available($path_or_uri)">
			<xsl:copy-of select="document(pa:create_uri($path_or_uri))"/>
		</xsl:if>
	</xsl:function>
	
	
	<!-- ============================================================================================================================================ -->
	
	
	<xd:doc>
		<xd:desc>
			<xd:p><xd:b>Author:</xd:b> Björn Dünckel</xd:p>
			<xd:p>Funktion um den Absoluten Pfad des Kontext-Knotens zu ermitteln (erleichterung des Debuggings)</xd:p>
			<xd:p>Aufruf ist immer "pa:get-current-xpath(.)"</xd:p>
			<xd:p>ACHTUNG EINSCHRÄNKUNG: Der Current-Node muss IMMER ein Element sein!</xd:p>
		</xd:desc>
		<xd:param name="current-node">Der Kontext-Knoten</xd:param>
	</xd:doc>
	<xsl:function name="pa:get-current-xpath">
		
		<!--Übergeben des aktuellen Elements-->
		<xsl:param name="current-node"/>
		
		<!--Merken des aktuellen Knotennamens-->
		<xsl:variable name="currend-node-name" select="$current-node/name()"/>
		
		<!--Iterieren über alle Vorfahren-Elemente-->
		<xsl:for-each select="$current-node/ancestor::*">
			
			<!--Merken des Namens vom aktuellen Vorfahren-Element-->
			<xsl:variable name="currend-ancestor-name" select="name()"/>
			
			<!--Aufbau des Absoluten XPath-Ausdrucks ersten Vorfahren-Element mit Name und Position bis zum Dokument-Knoten-->
			<xsl:value-of select="concat('/',name(),'[',count(preceding-sibling::*[name()=$currend-ancestor-name])+1,']')"/>
		</xsl:for-each>
		
		<!-- Abschluss des absluten XPath-Ausdrucks mit Name und Position des aktuellen Elementes -->
		<xsl:value-of select="concat('/',$currend-node-name,'[',count($current-node/preceding-sibling::*[name()=$currend-node-name])+1,']')"/>
	</xsl:function>
	
	
	<!-- ============================================================================================================================================ -->
	
	
	<xd:doc>
		<xd:desc>
			<xd:p><xd:b>Author:</xd:b> Tobias Fischer</xd:p>
			<xd:p>Gibt den hexadezimalen Code eines Unicode-codierten Zeichens zurück</xd:p>
			<xd:p>Rückgabeformat: <xd:i>mind. 4-stellig mit führenden Nullen und '#x'</xd:i></xd:p>
			<xd:p>Beispiele: <xd:i>#x0001, #x00A0, #x2001, #x1014F</xd:i></xd:p>
		</xd:desc>
		<xd:param name="character">Glyphe/Zeichen deren Hexcode zu bestimmen ist</xd:param>
	</xd:doc>
	<xsl:function name="pa:Character-to-hexCode" as="xs:string">
		<xsl:param name="character"/>
		<xsl:variable name="hexString" select="pa:decimal-to-hex(string-to-codepoints($character))"/>
		<xsl:choose>
			<xsl:when test="string-length($hexString) = 1"><xsl:value-of select="concat('#x000', $hexString)"/></xsl:when>
			<xsl:when test="string-length($hexString) = 2"><xsl:value-of select="concat('#x00', $hexString)"/></xsl:when>
			<xsl:when test="string-length($hexString) = 3"><xsl:value-of select="concat('#x0', $hexString)"/></xsl:when>
			<xsl:otherwise><xsl:value-of select="concat('#x', $hexString)"/></xsl:otherwise>
		</xsl:choose>
	</xsl:function>
	
	
	<!-- ============================================================================================================================================ -->
	
	
	<xd:doc>
		<xd:desc>
			<xd:p><xd:b>Author:</xd:b> Tobias Fischer</xd:p>
			<xd:p>Wandelt eine Dezimalzahl in hexadezimalformat um</xd:p>
			<xd:p>Rückgabedatentyp: <xd:i>xs:string</xd:i></xd:p>
			<xd:p>Rückgabeformat: <xd:i>reines hexadezimalformat OHNE führende Nullen, etc.</xd:i></xd:p>
			<xd:p>Beispiele: <xd:i>1, A0, 2001, 1014F</xd:i></xd:p>
		</xd:desc>
		<xd:param name="decimalNumber">Dezimalzahl</xd:param>
	</xd:doc>
	<xsl:function name="pa:decimal-to-hex" as="xs:string">
		<xsl:param name="decimalNumber"/>
		<xsl:sequence select="string-join(pa:decimal-to-hex-HELPER($decimalNumber),'')"/>
	</xsl:function>
	
	
	<!-- ============================================================================================================================================ -->
	
	
	<xd:doc>
		<xd:desc>
			<xd:p><xd:b>Author:</xd:b> Tobias Fischer</xd:p>
			<xd:p>Interne rekursive Hilfsfunktion um eine Dezimalzahl in hexadezimalformat zu wandeln</xd:p>
			<xd:p>Wird benötigt, weil diese rekursive Funktion als Input / Output eine String-Sequenz verwendet und wir am Ende nicht einfach joinen können. Dazu ist die "echte" <xd:ref name="pa:decimal-to-hex" type="function" xmlns:pa="http://www.pagina-online.de/xlib">decimal-to-hex</xd:ref>-Funktion da</xd:p>
			<xd:p>Rückgabedatentyp: <xd:i>xs:string+</xd:i></xd:p>
		</xd:desc>
		<xd:param name="decimalNumber">Dezimalzahl</xd:param>
	</xd:doc>
	<xsl:function name="pa:decimal-to-hex-HELPER" as="xs:string+">
		<xsl:param name="decimalNumber"/>
		<xsl:variable name="hexDigits" select="'0123456789ABCDEF'"/>
		<xsl:if test="$decimalNumber &gt;= 16">
			<xsl:sequence select="pa:decimal-to-hex-HELPER(floor($decimalNumber div 16))"/>
		</xsl:if>
		<xsl:sequence select="substring($hexDigits, (($decimalNumber mod 16) + 1), 1)"/>
	</xsl:function>
	
	
	<!-- ============================================================================================================================================ -->
	
	
	<xd:doc>
		<xd:desc>
			<xd:p><xd:b>Author:</xd:b> Gregor Fellenz</xd:p>
			<xd:p>Not-Element Prüfung</xd:p>
		</xd:desc>
		<xd:param name="item">Aktueller Node</xd:param>
	</xd:doc>
	<xsl:function name="pa:is-not-element">
		<xsl:param name="item"/>
		<xsl:sequence select="$item[not(self::*)]"/>
	</xsl:function>
	
	
	<!-- ============================================================================================================================================ -->
	
	
	<xd:doc>
		<xd:desc>
			<xd:p><xd:b>Author:</xd:b> Tobias Fischer</xd:p>
			<xd:p>Rekursive Funktion um eine Zahl in eine Alphabet-Sequenz umzuwandeln (a,b,c,...,z,aa,ab,...az,ba,bb,...)</xd:p>
			<xd:p>Wird benötigt um z.B. alphabetische Listenzählungen zu erstellen</xd:p>
			<xd:p>Beispiele: <xd:i>1 -> a</xd:i>, <xd:i>2 -> b</xd:i>, <xd:i>27 -> aa</xd:i>, <xd:i>28 -> ab</xd:i></xd:p>
		</xd:desc>
		<xd:param name="int">Integer-Zahl > 0</xd:param>
	</xd:doc>
	<xsl:function name="pa:int-to-letter">
		<xsl:param name="int" as="xs:integer"/>
		<xsl:choose>
			<xsl:when test="$int lt 27">
				<xsl:value-of select="codepoints-to-string($int+96)"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:choose>
					<xsl:when test="$int mod 26 = 0">
						<xsl:value-of select="pa:int-to-letter(($int div 26)-1)"/>
						<xsl:value-of select="pa:int-to-letter(($int -1) mod 26 + 1)"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="pa:int-to-letter(xs:integer($int div 26))"/>
						<xsl:value-of select="pa:int-to-letter($int mod 26)"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:function>

</xsl:stylesheet>