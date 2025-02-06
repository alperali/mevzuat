<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- Mevzuat için klasik temaya denk XSL dönüşüm
     A. Alper Atıcı, https://github.com/alperali/mevzuat  -->

<xsl:output method="html" encoding="utf-8" />

<xsl:template match="Kanun">
  <xsl:text disable-output-escaping='yes'>&lt;!doctype html&gt;</xsl:text>
  <html lang="tr">
    <head>
      <meta charset="utf-8" />
      <meta name="viewport" content="width=device-width, initial-scale=1" />
      <title><xsl:value-of select="No" /> - <xsl:value-of select="Başlık" /></title>
      <link rel="stylesheet" href="./css/mevzuat.css" />
    </head>
    <body>
      <h4 class="ortala">
        <xsl:value-of select="Başlık" />
      </h4>
      <table class="künye kaydır">
        <tr class="kalın">
          <td>Kanun Numarası</td>
          <td>: <xsl:value-of select="No" /></td>
        </tr>
        <tr class="kalın">
          <td>Kabul Tarihi</td>
          <td>: <xsl:value-of select="Tarih/@gün"/>/<xsl:value-of select="Tarih/@ay"/>/<xsl:value-of select="Tarih/@yıl"/></td>
        </tr>
        <tr class="kalın">
          <td>Yayımlandığı Resmi Gazete</td>
          <td>: Tarih: <xsl:value-of select="ResmiGazete/Tarih/@gün"/>/<xsl:value-of select="ResmiGazete/Tarih/@ay"/>/<xsl:value-of select="ResmiGazete/Tarih/@yıl"/>&#160;&#160;&#160;&#160;</td>
          <td>Sayı: <xsl:value-of select="ResmiGazete/Sayı"/></td>
        </tr>
        <tr class="kalın">
          <td>Yayımlandığı Düstur</td>
          <td>: Tertip: <xsl:value-of select="ResmiGazete/Düstur/@tertip"/></td>
          <td>Cilt: <xsl:value-of select="ResmiGazete/Düstur/@cilt"/></td>
        </tr>
      </table>
      <xsl:apply-templates select="Kısım" />
    </body>
  </html>
</xsl:template>

<xsl:template match="Kısım">
      <h4 class="ortala"><xsl:value-of select="substring-after(@no,'-')" /> KISIM</h4>
      <p class="başlık"><xsl:value-of select="@başlık" /></p>
      <xsl:apply-templates select="Bölüm" />
</xsl:template>

<xsl:template match="Bölüm">
          <h4 class="ortala"><xsl:value-of select="substring-after(@no,'-')" /> BÖLÜM</h4>
          <p class="başlık"><xsl:value-of select="@başlık" />&#160;&#160;<xsl:apply-templates select="Atıf" /></p>
          <xsl:apply-templates select="Madde" />
</xsl:template>

<xsl:template match="Madde">
            <p class="mdbaşlık kaydır"><xsl:value-of select="@başlık" />&#160;&#160;<xsl:apply-templates select="Atıf[@tür='Değişik başlık']" />
            </p>
            
            <xsl:choose>
              <xsl:when test="Atıf[@tür='Mülga']">
                <p class="asılı">
                  <span class="kalın"><xsl:if test="@tür"><xsl:value-of select="concat(@tür,' ')" /></xsl:if>MADDE <xsl:value-of select="@no" />- </span><xsl:apply-templates select="Atıf[@tür='Mülga']" />
                </p>
              </xsl:when>

              <xsl:when test="Atıf[@tür='Ek']">
                <p class="asılı">
                  <span class="kalın"><xsl:if test="@tür"><xsl:value-of select="concat(@tür,' ')" /></xsl:if>MADDE <xsl:value-of select="@no" />- </span><xsl:apply-templates select="Atıf[@tür='Ek']" />
                </p>
                <xsl:apply-templates select="Fıkra[@no=1]" />
              </xsl:when>
              
              <!-- İlk Fıkra öncesi bir Atıf yoksa ilk Fıkranın yazılışı -->
              <xsl:otherwise>
                <p class="asılı">
                  <span class="kalın"><xsl:if test="@tür"><xsl:value-of select="concat(@tür,' ')" /></xsl:if>MADDE <xsl:value-of select="@no" />- </span>
                  (1) <xsl:apply-templates select="Fıkra[@no=1]/Atıf | Fıkra[@no=1]/text()[count(preceding-sibling::Bent)=0]" />
                  <xsl:apply-templates select="Fıkra[@no=1]/Bent" />
                  <xsl:apply-templates select="Fıkra[@no=1]/text()[count(preceding-sibling::Bent)>0]" />
                </p>
              </xsl:otherwise>
            </xsl:choose>

            <xsl:apply-templates select="Fıkra[@no>1]" />

</xsl:template>

<xsl:template match="Atıf">
  <span class="kalın">(<xsl:value-of select="@tür" />: <xsl:value-of select="@tarih" />-<xsl:value-of select="@kanun" />/<xsl:value-of select="@madde" /> md.) </span>
</xsl:template>

<xsl:template match="text()[count(preceding-sibling::Bent)>0]">
  <p class="asılı"><xsl:value-of select="." /></p>
</xsl:template>

<xsl:template match="Fıkra">
  <p class="asılı">(<xsl:value-of select="@no" />) <xsl:apply-templates select="Atıf|text()[count(preceding-sibling::Bent)=0]" />
  </p>
  <xsl:apply-templates select="Bent" />
  <xsl:apply-templates select="text()[count(preceding-sibling::Bent)>0]" />
</xsl:template>

<xsl:template match="Bent">
  <p class="asılı"><xsl:value-of select="@no" />) <xsl:apply-templates select="Atıf|text()" />
  </p>
</xsl:template>

</xsl:stylesheet>
