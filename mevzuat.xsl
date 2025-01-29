<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="/Kanun">
  <html lang="tr">
    <head>
      <meta charset="utf-8" />
      <meta name="viewport" content="width=device-width, initial-scale=1" />
      <title><xsl:value-of select="./No" /> - <xsl:value-of select="./Başlık" /></title>
      <link rel="stylesheet" href="./mevzuat.css" />
    </head>
    <body>
      <h4 class="ortala">
        <xsl:value-of select="./Başlık" />
      </h4>
      <table class="künye">
        <tr class="kalın">
          <td>Kanun Numarası</td>
          <td>: <xsl:value-of select="./No" /></td>
        </tr>
        <tr class="kalın">
          <td>Kabul Tarihi</td>
          <td>: <xsl:value-of select="./Tarih/@gün"/>/<xsl:value-of select="./Tarih/@ay"/>/<xsl:value-of select="./Tarih/@yıl"/></td>
        </tr>
        <tr class="kalın">
          <td>Yayımlandığı Resmi Gazete</td>
          <td>: Tarih: <xsl:value-of select="./ResmiGazete/Tarih/@gün"/>/<xsl:value-of select="./ResmiGazete/Tarih/@ay"/>/<xsl:value-of select="./ResmiGazete/Tarih/@yıl"/>&#160;&#160;&#160;&#160;</td>
          <td>Sayı: <xsl:value-of select="./ResmiGazete/Sayı"/></td>
        </tr>
        <tr class="kalın">
          <td>Yayımlandığı Düstur</td>
          <td>: Tertip: <xsl:value-of select="./ResmiGazete/Düstur/@tertip"/></td>
          <td>Cilt: <xsl:value-of select="./ResmiGazete/Düstur/@cilt"/></td>
        </tr>
      </table>

      <xsl:for-each select="./Kısım">
        <h4 class="ortala"><xsl:value-of select="substring-after(./@no,'-')" /> KISIM</h4>
        <p class="başlık"><xsl:value-of select="./@başlık" /></p>
        <xsl:for-each select="./Bölüm">
          <h4 class="ortala"><xsl:value-of select="substring-after(./@no,'-')" /> BÖLÜM</h4>
          <p class="başlık"><xsl:value-of select="./@başlık" /></p>
          <xsl:for-each select="./Madde">
            <p class="kalın"><xsl-value-of select="./@başlık" /></p>
            <p><span class="kalın">MADDE <xsl:value-of select="./@no" />- </span>

            </p>
          </xsl:for-each>
        </xsl:for-each>
      </xsl:for-each>

    </body>
  </html>
</xsl:template>

</xsl:stylesheet>