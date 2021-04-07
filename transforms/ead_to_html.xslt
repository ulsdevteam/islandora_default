<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
    xmlns:ead="urn:isbn:1-931666-22-9"
    xmlns:ns2="http://www.w3.org/1999/xlink"
    xmlns:php="http://php.net/xsl">
    <!--
        *******************************************************************
        *                                                                 *
        * VERSION:          1.01                                          *
        *                                                                 *
        * AUTHOR:           Winona Salesky                                *
        *                   wsalesky@gmail.com                            *
        *                                                                 *
        *                                                                 *
        * ABOUT:           This file has been created for use with        *
        *                  the Archivists' Toolkit  July 30 2008.         *
        *                  this file calls lookupLists.xsl, which         *
        *                  should be located in the same folder.          *
        *                                                                 *
        * UPDATED          June 3, 2009                                   *
        *                  Added additional table cell to component       *
        *                  display to address bug ART-1833, also addressed* 
        *                  problematic container heading displays         *          
        *                                                                 *
        * UPDATED          September 24, 2009                             *
        *                  Added address to publication statement         *
        *                  March 23, 2009                                 *
        *                  Added revision description and date,           * 
        *                  and publication information                    *
        *                  March 12, 2009                                 *
        *                  Fixed character encoding issues                *
        *                  March 11, 2009                                 *
        *                  Added repository branding device to header     *
        *                  March 1, 2009                                  *
        *                  Changed bulk date display for unitdates        *
        *                  Feb. 6, 2009                                   *
        *                  Added roles to creator display in summary      * 
        *******************************************************************
    -->
<!--    <xsl:strip-space elements="*"/> -->
 <!--   <xsl:output indent="yes" method="xhtml" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" encoding="utf-8"/> -->
 <!--    <xsl:include href="reports/Resources/eadToPdf/lookupLists.xsl"/> -->
    <!--<xsl:include href="lookupLists.xsl"/>-->
    <!-- Creates the body of the finding aid.-->
    <xsl:template match="/">
  <div class="ead">
      <xsl:call-template name="header"/>
      <div id="title">
      <xsl:apply-templates select="/ead:ead/ead:eadheader"/>
      </div>    
      <div id="contents">
      <xsl:call-template name="toc"/>
      <div id="content-right">
          <!-- Arranges archdesc into predefined sections, to change order 
          or groupings, rearrange templates  -->
          
          <!-- Summary Information, summary information includes citation -->
          <xsl:apply-templates select="/ead:ead/ead:archdesc/ead:did"/>
          <xsl:apply-templates select="/ead:ead/ead:archdesc/ead:bioghist"/>
          <xsl:apply-templates select="/ead:ead/ead:archdesc/ead:scopecontent"/>
          <xsl:apply-templates select="/ead:ead/ead:archdesc/ead:arrangement"/>
          <xsl:apply-templates select="/ead:ead/ead:archdesc/ead:fileplan"/>
          
          <!-- Administrative Information  -->
          <xsl:if test="/ead:ead/ead:archdesc/ead:accessrestrict or
              /ead:ead/ead:archdesc/ead:userestrict or
              /ead:ead/ead:archdesc/ead:custodhist or
              /ead:ead/ead:archdesc/ead:accruals or
              /ead:ead/ead:archdesc/ead:altformavail or
              /ead:ead/ead:archdesc/ead:acqinfo or
              /ead:ead/ead:archdesc/ead:processinfo or
              /ead:ead/ead:archdesc/ead:appraisal or
              /ead:ead/ead:archdesc/ead:originalsloc or /ead:ead/ead:eadheader/ead:filedesc/ead:publicationstmt or /ead:ead/ead:eadheader/ead:revisiondesc">
              <h3 id="adminInfo">Administrative Information</h3>
              <xsl:apply-templates select="/ead:ead/ead:eadheader/ead:filedesc/ead:publicationstmt"/>
              <xsl:apply-templates select="/ead:ead/ead:eadheader/ead:revisiondesc"/>
              <xsl:apply-templates select="/ead:ead/ead:archdesc/ead:accessrestrict"/>
              <xsl:apply-templates select="/ead:ead/ead:archdesc/ead:userestrict"/>
              <xsl:apply-templates select="/ead:ead/ead:archdesc/ead:custodhist"/>
              <xsl:apply-templates select="/ead:ead/ead:archdesc/ead:accruals"/>
              <xsl:apply-templates select="/ead:ead/ead:archdesc/ead:acqinfo"/>
              <xsl:apply-templates select="/ead:ead/ead:archdesc/ead:processinfo"/>
              <xsl:apply-templates select="/ead:ead/ead:archdesc/ead:appraisal"/>
              <xsl:apply-templates select="/ead:ead/ead:archdesc/ead:altformavail"/>
              <xsl:apply-templates select="/ead:ead/ead:archdesc/ead:originalsloc"/>
              <xsl:call-template name="returnTOC"/>
          </xsl:if>
          
          <!-- Related Materials -->
          <xsl:if test="/ead:ead/ead:archdesc/ead:relatedmaterial or /ead:ead/ead:archdesc/ead:separatedmaterial">
              <h3 id="relMat">Related Materials</h3>
              <xsl:apply-templates select="/ead:ead/ead:archdesc/ead:relatedmaterial"/>
              <xsl:apply-templates select="/ead:ead/ead:archdesc/ead:separatedmaterial"/>
              <xsl:call-template name="returnTOC"/>
          </xsl:if>
          <xsl:apply-templates select="/ead:ead/ead:archdesc/ead:daogrp"/>
          <xsl:apply-templates select="/ead:ead/ead:archdesc/ead:dao"/>
          <xsl:apply-templates select="/ead:ead/ead:archdesc/ead:controlaccess"/>
          <xsl:apply-templates select="/ead:ead/ead:archdesc/ead:otherfindaid"/>
          <xsl:apply-templates select="/ead:ead/ead:archdesc/ead:phystech"/>
          <xsl:apply-templates select="/ead:ead/ead:archdesc/ead:odd"/>
          
          <xsl:apply-templates select="/ead:ead/ead:archdesc/ead:bibliography"/>
          <xsl:apply-templates select="/ead:ead/ead:archdesc/ead:index"/>
          <xsl:if test="/ead:ead/ead:archdesc/ead:dsc/child::*">
              <xsl:apply-templates select="/ead:ead/ead:archdesc/ead:dsc"/>    
          </xsl:if>
      </div>
      </div>    
    </div>
    </xsl:template>

    <!-- This template creates a customizable header  -->
    <xsl:template name="header">
        <div id="ead_header">
            <div>
            <h2>
                <xsl:value-of select="/ead:ead/ead:eadheader/ead:filedesc/ead:publicationstmt/ead:publisher"/>
            </h2>
            <!-- Adds repositry branding device, looks best if this is under 100px high. -->
             <xsl:if test="/ead:ead/ead:eadheader/ead:filedesc/ead:publicationstmt/ead:p/ead:extref">
                 <img src="{/ead:ead/ead:eadheader/ead:filedesc/ead:publicationstmt/ead:p/ead:extref/@ns2:href}" />
             </xsl:if>
            </div>
        </div>    
    </xsl:template>

    <!-- Creates an ordered table of contents that matches the order of the archdesc 
        elements. To change the order rearrange the if/for-each statements. -->  
    <xsl:template name="toc">
        <div id="toc">
            <h3>Table of Contents</h3>
            <dl>
                <xsl:if test="/ead:ead/ead:archdesc/ead:did">
                    <dt><a href="#{generate-id(.)}">Summary Information</a></dt>
                </xsl:if>
                <xsl:for-each select="/ead:ead/ead:archdesc/ead:bioghist">
                        <dt>                                
                            <a><xsl:call-template name="tocLinks"/>
                                <xsl:choose>
                                    <xsl:when test="ead:head">
                                        <xsl:value-of select="ead:head"/></xsl:when>
                                    <xsl:otherwise>Biography/History</xsl:otherwise>
                                </xsl:choose>
                            </a>
                        </dt>   
                </xsl:for-each>
                <xsl:for-each select="/ead:ead/ead:archdesc/ead:scopecontent">
                    <dt>                                
                        <a><xsl:call-template name="tocLinks"/>
                            <xsl:choose>
                                <xsl:when test="ead:head">
                                    <xsl:value-of select="ead:head"/></xsl:when>
                                <xsl:otherwise>Scope and Content</xsl:otherwise>
                            </xsl:choose>
                        </a>
                    </dt>   
                </xsl:for-each>
                <xsl:for-each select="/ead:ead/ead:archdesc/ead:arrangement">
                    <dt>                                
                        <a><xsl:call-template name="tocLinks"/>
                            <xsl:choose>
                                <xsl:when test="ead:head">
                                    <xsl:value-of select="ead:head"/></xsl:when>
                                <xsl:otherwise>Arrangement</xsl:otherwise>
                            </xsl:choose>
                        </a>
                    </dt>   
                </xsl:for-each>
                <xsl:for-each select="/ead:ead/ead:archdesc/ead:fileplan">
                    <dt>                                
                        <a><xsl:call-template name="tocLinks"/>
                            <xsl:choose>
                                <xsl:when test="ead:head">
                                    <xsl:value-of select="ead:head"/></xsl:when>
                                <xsl:otherwise>File Plan</xsl:otherwise>
                            </xsl:choose>
                        </a>
                    </dt>   
               </xsl:for-each>
                
                <!-- Administrative Information  -->
                <xsl:if test="/ead:ead/ead:archdesc/ead:accessrestrict or
                    /ead:ead/ead:archdesc/ead:userestrict or
                    /ead:ead/ead:archdesc/ead:custodhist or
                    /ead:ead/ead:archdesc/ead:accruals or
                    /ead:ead/ead:archdesc/ead:altformavail or
                    /ead:ead/ead:archdesc/ead:acqinfo or
                    /ead:ead/ead:archdesc/ead:processinfo or
                    /ead:ead/ead:archdesc/ead:appraisal or
                    /ead:ead/ead:archdesc/ead:originalsloc or /ead:ead/ead:eadheader/ead:filedesc/ead:publicationstmt or /ead:ead/ead:eadheader/ead:revisiondesc">
                    <dt><a href="#adminInfo">Administrative Information</a></dt>
                </xsl:if>
                
                <!-- Related Materials -->
                <xsl:if test="/ead:ead/ead:archdesc/ead:relatedmaterial or /ead:ead/ead:archdesc/ead:separatedmaterial">
                    <dt><a href="#relMat">Related Materials</a></dt>
                </xsl:if>
                <xsl:for-each select="/ead:ead/ead:archdesc/ead:controlaccess">
                    <dt>                                
                        <a><xsl:call-template name="tocLinks"/>
                            <xsl:choose>
                                <xsl:when test="ead:head">
                                    <xsl:value-of select="ead:head"/></xsl:when>
                                <xsl:otherwise>Controlled Access Headings</xsl:otherwise>
                            </xsl:choose>
                        </a>
                    </dt>   
                </xsl:for-each>
                <xsl:for-each select="/ead:ead/ead:archdesc/ead:otherfindaid">
                    <dt>                                
                        <a><xsl:call-template name="tocLinks"/>
                            <xsl:choose>
                                <xsl:when test="ead:head">
                                    <xsl:value-of select="ead:head"/></xsl:when>
                                <xsl:otherwise>Other Finding Aids</xsl:otherwise>
                            </xsl:choose>
                        </a>
                    </dt>   
                </xsl:for-each>
                <xsl:for-each select="/ead:ead/ead:archdesc/ead:phystech">
                    <dt>                                
                        <a><xsl:call-template name="tocLinks"/>
                            <xsl:choose>
                                <xsl:when test="ead:head"><xsl:value-of select="ead:head"/></xsl:when>
                                <xsl:otherwise>Technical Requirements</xsl:otherwise>
                            </xsl:choose>
                        </a>
                    </dt>
                </xsl:for-each>
                <xsl:for-each select="/ead:ead/ead:archdesc/ead:odd">
                    <dt>                                
                        <a><xsl:call-template name="tocLinks"/>
                            <xsl:choose>
                                <xsl:when test="ead:head">
                                    <xsl:value-of select="ead:head"/></xsl:when>
                                <xsl:otherwise>Other Descriptive Data</xsl:otherwise>
                            </xsl:choose>
                        </a>
                    </dt>
                </xsl:for-each>
                <xsl:for-each select="/ead:ead/ead:archdesc/ead:bibliography">
                    <dt>                                
                        <a><xsl:call-template name="tocLinks"/>
                            <xsl:choose>
                                <xsl:when test="ead:head">
                                    <xsl:value-of select="ead:head"/></xsl:when>
                                <xsl:otherwise>Bibliography</xsl:otherwise>
                            </xsl:choose>
                        </a>
                    </dt>
                </xsl:for-each>
                <xsl:for-each select="/ead:ead/ead:archdesc/ead:index">
                    <dt>                                
                        <a><xsl:call-template name="tocLinks"/>
                            <xsl:choose>
                                <xsl:when test="ead:head">
                                    <xsl:value-of select="ead:head"/></xsl:when>
                                <xsl:otherwise>Index</xsl:otherwise>
                            </xsl:choose>
                        </a>
                    </dt>
                </xsl:for-each> 
                <xsl:for-each select="/ead:ead/ead:archdesc/ead:dsc">
                    <xsl:if test="child::*">
                        <dt>                                
                            <a><xsl:call-template name="tocLinks"/>
                                <xsl:choose>
                                    <xsl:when test="ead:head">
                                        <xsl:value-of select="ead:head"/></xsl:when>
                                    <xsl:otherwise>Collection Inventory</xsl:otherwise>
                                </xsl:choose>
                            </a>
                        </dt>                
                    </xsl:if>
                    <!--Creates a submenu for collections, record groups and series and fonds-->
                    <xsl:for-each select="child::*[@level = 'collection'] 
                        | child::*[@level = 'recordgrp'] | child::*[@level = 'series'] | child::*[@level = 'fonds']">
                        <dd><a><xsl:call-template name="tocLinks"/>
                            <xsl:choose>
                                <xsl:when test="ead:head">
                                    <xsl:apply-templates select="child::*/ead:head"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    Series <xsl:value-of select="child::*/ead:unitid"/><xsl:text>&#160;</xsl:text>
                                    <xsl:apply-templates select="child::*/ead:unittitle"/><xsl:text>&#160;</xsl:text>
                                    <xsl:value-of select="child::*/ead:unitdate"/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </a></dd>
                                    <xsl:for-each select="child::*[@level = 'subseries']">
                                      <dd class="extra-indent"><a><xsl:call-template name="tocLinks"/>
                                        <!-- <xsl:value-of select="child::*/ead:unitid"/><xsl:text>&#160;</xsl:text> -->
                                        <xsl:apply-templates select="child::*/ead:unittitle"/><xsl:text>&#160;</xsl:text>
                                        <xsl:value-of select="child::*/ead:unitdate"/>
                                      </a></dd>
                                    </xsl:for-each>


                    </xsl:for-each>
                </xsl:for-each>
            </dl>
        </div>
    </xsl:template>
 
     <!-- Named template for a generic p element with a link back to the table of contents  -->
    <xsl:template name="returnTOC">
        <p class="returnTOC"><a href="#toc">Return to Table of Contents »</a></p>
        <hr/>
    </xsl:template>
    <xsl:template match="ead:eadheader">
        <!-- since the islandora page is going to display the title, skip it here
        <h1 id="{generate-id(ead:filedesc/ead:titlestmt/ead:titleproper)}">
            <xsl:apply-templates select="ead:filedesc/ead:titlestmt/ead:titleproper"/>     
        </h1> -->
        <xsl:if test="ead:filedesc/ead:titlestmt/ead:subtitle">
            <h2>
                <xsl:apply-templates select="ead:filedesc/ead:titlestmt/ead:subtitle"/>
            </h2>                
        </xsl:if>
    </xsl:template>
    <xsl:template match="ead:filedesc/ead:titlestmt/ead:titleproper">
        <xsl:choose>
            <xsl:when test="@type = 'filing'">
                <xsl:choose>
                    <xsl:when test="count(parent::*/ead:titleproper) &gt; 1"/>
                    <xsl:otherwise>
                        <xsl:value-of select="/ead:ead/ead:archdesc/ead:did/ead:unittitle"/>        
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise><xsl:apply-templates/></xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- display the Extent value/s -->
    <xsl:template match="ead:archdesc/ead:did/ead:physdesc">
        <dt>Extent</dt>
        <dd>
        <xsl:for-each select="node()">
            <xsl:value-of select="." />
            <xsl:text> </xsl:text>
            <xsl:value-of select="@unit" />
            <xsl:text> </xsl:text>
        </xsl:for-each>
        </dd>
    </xsl:template>


    <xsl:template match="ead:filedesc/ead:titlestmt/ead:titleproper/ead:num"><br/><xsl:apply-templates/></xsl:template>
    <xsl:template match="ead:archdesc/ead:did">
        <h3>
            <a name="{generate-id(.)}">
                <xsl:choose>
                    <xsl:when test="ead:head">
                        <xsl:value-of select="ead:head"/>
                    </xsl:when>
                    <xsl:otherwise>
                        Summary Information
                    </xsl:otherwise>
                </xsl:choose>
            </a>
        </h3>
        <!-- Determines the order in wich elements from the archdesc did appear, 
            to change the order of appearance for the children of did
            by changing the order of the following statements.-->
        <dl class="summary">
            <xsl:apply-templates select="ead:repository"/>
            <xsl:apply-templates select="ead:unittitle"/>    
            <xsl:apply-templates select="ead:origination"/>
            <xsl:apply-templates select="ead:unitid"/>
            <xsl:apply-templates select="ead:unitdate"/>
            <xsl:apply-templates select="ead:physdesc"/>        
            <xsl:apply-templates select="ead:physloc"/>        
            <xsl:apply-templates select="ead:langmaterial"/>
            <xsl:apply-templates select="ead:materialspec"/>
            <xsl:apply-templates select="ead:container"/>
            <xsl:apply-templates select="ead:abstract"/> 
            <xsl:apply-templates select="ead:note"/>

            <xsl:if test="/ead:ead/ead:eadheader/ead:filedesc/ead:titlestmt/ead:sponsor">
                   <dt>Sponsor Note</dt>
                   <dd><xsl:value-of select="/ead:ead/ead:eadheader/ead:filedesc/ead:titlestmt/ead:sponsor" /></dd>
            </xsl:if>

        </dl>
            <xsl:apply-templates select="../ead:prefercite"/>
        <xsl:call-template name="returnTOC"/>
    </xsl:template>

    <!-- Template calls and formats the children of archdesc/did -->
<!-- removed from logic: "ead:archdesc/ead:did/ead:physdesc | " -->
    <xsl:template match="ead:archdesc/ead:did/ead:repository | ead:archdesc/ead:did/ead:unittitle | ead:archdesc/ead:did/ead:unitid | ead:archdesc/ead:did/ead:origination 
        | ead:archdesc/ead:did/ead:unitdate | ead:archdesc/ead:did/ead:physloc 
        | ead:archdesc/ead:did/ead:abstract | ead:archdesc/ead:did/ead:langmaterial | ead:archdesc/ead:did/ead:materialspec | ead:archdesc/ead:did/ead:container">
        <dt>
            <xsl:choose>
                <xsl:when test="@label">
                    <xsl:value-of select="concat(translate( substring(@label, 1, 1 ),
                        'abcdefghijklmnopqrstuvwxyz', 'ABCDEFGHIJKLMNOPQRSTUVWXYZ' ), 
                        substring(@label, 2, string-length(@label )))" />
                    <xsl:if test="@type"> [<xsl:value-of select="@type"/>]</xsl:if>
                    <xsl:if test="self::ead:origination">
                        <xsl:choose>
                            <xsl:when test="ead:persname[@role != ''] and contains(ead:persname/@role,' (')">
                                - <xsl:value-of select="substring-before(ead:persname/@role,' (')"/>
                            </xsl:when>
                            <xsl:when test="ead:persname[@role != '']">
                                - <xsl:value-of select="ead:persname/@role"/>  
                            </xsl:when>
                            <xsl:otherwise/>
                        </xsl:choose>
                    </xsl:if>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:choose>
                        <xsl:when test="self::ead:repository">Repository</xsl:when>
                        <xsl:when test="self::ead:unittitle">Title</xsl:when>
                        <xsl:when test="self::ead:unitid">Collection Number</xsl:when>
                        <xsl:when test="self::ead:unitdate">Date<xsl:if test="@type"> [<xsl:value-of select="@type"/>]</xsl:if></xsl:when>
                        <xsl:when test="self::ead:origination">
                            <xsl:choose>
                                <xsl:when test="ead:persname[@role != ''] and contains(ead:persname/@role,' (')">
                                    Creator - <xsl:value-of select="substring-before(ead:persname/@role,' (')"/>
                                </xsl:when>
                                <xsl:when test="ead:persname[@role != '']">
                                    Creator - <xsl:value-of select="ead:persname/@role"/>  
                                </xsl:when>
                                <xsl:otherwise>
                                    Creator        
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:when>
<!-- moved this heading output to "ead:archdesc/ead:did/ead:physdesc" template above :    <xsl:when test="self::ead:physdesc">Extent</xsl:when> -->
                        <xsl:when test="self::ead:abstract">Abstract</xsl:when>
                        <xsl:when test="self::ead:physloc">Location</xsl:when>
<!-- TEMPORARILY suppress the display of the Language title - until the matching language node is populated correctly in order to display. 
                        <xsl:when test="self::ead:langmaterial">Language</xsl:when> -->
                        <xsl:when test="self::ead:materialspec">Technical</xsl:when>
                        <xsl:when test="self::ead:container">Container</xsl:when>
                        <xsl:when test="self::ead:note">Note</xsl:when>
                    </xsl:choose>
                </xsl:otherwise>
            </xsl:choose>
        </dt>
        <dd>
            <xsl:apply-templates/>
        </dd>
    </xsl:template>
    <!-- Template calls and formats all other children of archdesc many of 
        these elements are repeatable within the ead:dsc section as well.-->
    <xsl:template match="ead:bibliography | ead:odd | ead:accruals | ead:arrangement  | ead:bioghist 
        | ead:accessrestrict | ead:userestrict  | ead:custodhist | ead:altformavail | ead:originalsloc 
        | ead:fileplan | ead:acqinfo | ead:otherfindaid | ead:phystech | ead:processinfo | ead:relatedmaterial
        | ead:scopecontent  | ead:separatedmaterial | ead:appraisal">        
        <xsl:choose>
            <xsl:when test="ead:head"><xsl:apply-templates/></xsl:when>
            <xsl:otherwise>
                <xsl:choose>
                    <xsl:when test="parent::ead:archdesc">
                            <xsl:choose>
                                <xsl:when test="self::ead:bibliography"><h3><xsl:call-template name="anchor"/>Bibliography</h3></xsl:when>
                                <xsl:when test="self::ead:odd"><h3><xsl:call-template name="anchor"/>Other Descriptive Data</h3></xsl:when>
                                <xsl:when test="self::ead:accruals"><h4><xsl:call-template name="anchor"/>Accruals</h4></xsl:when>
                                <xsl:when test="self::ead:arrangement"><h3><xsl:call-template name="anchor"/>Arrangement</h3></xsl:when>
                                <xsl:when test="self::ead:bioghist"><h3><xsl:call-template name="anchor"/>Biography/History</h3></xsl:when>
                                <xsl:when test="self::ead:accessrestrict"><h4><xsl:call-template name="anchor"/>Restrictions on Access</h4></xsl:when>
                                <xsl:when test="self::ead:userestrict"><h4><xsl:call-template name="anchor"/>Restrictions on Use</h4></xsl:when>
                                <xsl:when test="self::ead:custodhist"><h4><xsl:call-template name="anchor"/>Custodial History</h4></xsl:when>
                                <xsl:when test="self::ead:altformavail"><h4><xsl:call-template name="anchor"/>Alternative Form Available</h4></xsl:when>
                                <xsl:when test="self::ead:originalsloc"><h4><xsl:call-template name="anchor"/>Original Location</h4></xsl:when>
                                <xsl:when test="self::ead:fileplan"><h3><xsl:call-template name="anchor"/>File Plan</h3></xsl:when>
                                <xsl:when test="self::ead:acqinfo"><h4><xsl:call-template name="anchor"/>Acquisition Information</h4></xsl:when>
                                <xsl:when test="self::ead:otherfindaid"><h3><xsl:call-template name="anchor"/>Other Finding Aids</h3></xsl:when>
                                <xsl:when test="self::ead:phystech"><h3><xsl:call-template name="anchor"/>Physical Characteristics and Technical Requirements</h3></xsl:when>
                                <xsl:when test="self::ead:processinfo"><h4><xsl:call-template name="anchor"/>Processing Information</h4></xsl:when>
                                <xsl:when test="self::ead:relatedmaterial"><h4><xsl:call-template name="anchor"/>Related Material</h4></xsl:when>
                                <xsl:when test="self::ead:scopecontent"><h3><xsl:call-template name="anchor"/>Scope and Content</h3></xsl:when>
                                <xsl:when test="self::ead:separatedmaterial"><h4><xsl:call-template name="anchor"/>Separated Material</h4></xsl:when>
                                <xsl:when test="self::ead:appraisal"><h4><xsl:call-template name="anchor"/>Appraisal</h4></xsl:when>                        
                            </xsl:choose>
                    </xsl:when>
                    <xsl:otherwise>
                        <h4><xsl:call-template name="anchor"/>
                            <xsl:choose>
                                <xsl:when test="self::ead:bibliography">Bibliography</xsl:when>
                                <xsl:when test="self::ead:odd">Other Descriptive Data</xsl:when>
                                <xsl:when test="self::ead:accruals">Accruals</xsl:when>
                                <xsl:when test="self::ead:arrangement">Arrangement</xsl:when>
                                <xsl:when test="self::ead:bioghist">Biography/History</xsl:when>
                                <xsl:when test="self::ead:accessrestrict">Restrictions on Access</xsl:when>
                                <xsl:when test="self::ead:userestrict">Restrictions on Use</xsl:when>
                                <xsl:when test="self::ead:custodhist">Custodial History</xsl:when>
                                <xsl:when test="self::ead:altformavail">Alternative Form Available</xsl:when>
                                <xsl:when test="self::ead:originalsloc">Original Location</xsl:when>
                                <xsl:when test="self::ead:fileplan">File Plan</xsl:when>
                                <xsl:when test="self::ead:acqinfo">Acquisition Information</xsl:when>
                                <xsl:when test="self::ead:otherfindaid">Other Finding Aids</xsl:when>
                                <xsl:when test="self::ead:phystech">Physical Characteristics and Technical Requirements</xsl:when>
                                <xsl:when test="self::ead:processinfo">Processing Information</xsl:when>
                                <xsl:when test="self::ead:relatedmaterial">Related Material</xsl:when>
                                <xsl:when test="self::ead:scopecontent">Scope and Content</xsl:when>
                                <xsl:when test="self::ead:separatedmaterial">Separated Material</xsl:when>
                                <xsl:when test="self::ead:appraisal">Appraisal</xsl:when>                       
                            </xsl:choose>
                        </h4>
                    </xsl:otherwise>
                </xsl:choose>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>
        <!-- If the element is a child of arcdesc then a link to the table of contents is included -->
        <xsl:if test="parent::ead:archdesc">
            <xsl:choose>
                <xsl:when test="self::ead:accessrestrict or self::ead:userestrict or
                    self::ead:custodhist or self::ead:accruals or
                    self::ead:altformavail or self::ead:acqinfo or
                    self::ead:processinfo or self::ead:appraisal or
                    self::ead:originalsloc or  
                    self::ead:relatedmaterial or self::ead:separatedmaterial or self::ead:prefercite"/>
                    <xsl:otherwise>
                        <xsl:call-template name="returnTOC"/>
                    </xsl:otherwise>
            </xsl:choose>    
        </xsl:if>
    </xsl:template>

    <!-- Templates for publication information  -->
    <xsl:template match="/ead:ead/ead:eadheader/ead:filedesc/ead:publicationstmt">
        <h4>Publication Information</h4>
        <p><xsl:apply-templates select="ead:publisher"/>
            <xsl:if test="ead:date">,&#160;<xsl:apply-templates select="ead:date"/></xsl:if>
        </p>
        <xsl:if test="ead:address">
            <xsl:apply-templates select="ead:address"/>
        </xsl:if>
    </xsl:template>
    <xsl:template match="ead:address">
        <p>
            <xsl:for-each select="ead:addressline"><xsl:apply-templates select="."/><br/></xsl:for-each>
        </p>
    </xsl:template>
    <!-- Templates for revision description  -->
    <xsl:template match="/ead:ead/ead:eadheader/ead:revisiondesc">
        <h4>Revision Description</h4>
        <p><xsl:if test="ead:change/ead:item"><xsl:apply-templates select="ead:change/ead:item"/></xsl:if><xsl:if test="ead:change/ead:date">&#160;<xsl:apply-templates select="ead:change/ead:date"/></xsl:if></p>
    </xsl:template>
    
    <!-- Formats controlled access terms -->
    <xsl:template match="ead:controlaccess">
        <xsl:choose>
            <xsl:when test="ead:head"><xsl:apply-templates select="ead:head"/></xsl:when>
            <xsl:otherwise>
                <xsl:choose>
                    <xsl:when test="parent::ead:archdesc"><h3><xsl:call-template name="anchor"/>Controlled Access Headings</h3></xsl:when>
                    <xsl:otherwise><h4>Controlled Access Headings</h4></xsl:otherwise>
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:if test="ead:corpname">
            <h4>Corporate Name(s)</h4>
            <ul>
                <xsl:for-each select="ead:corpname">
                    <li><xsl:apply-templates/> </li>
                </xsl:for-each>
            </ul>            
        </xsl:if>
        <xsl:if test="ead:famname">
            <h4>Family Name(s)</h4>
            <ul>
                <xsl:for-each select="ead:famname">
                    <li><xsl:apply-templates/> </li>
                </xsl:for-each>                        
            </ul>
        </xsl:if>
        <xsl:if test="ead:function">
            <h4>Function(s)</h4>
            <ul>
                <xsl:for-each select="ead:function">
                    <li><xsl:apply-templates/> </li>
                </xsl:for-each>                        
            </ul>
        </xsl:if>
        <xsl:if test="ead:genreform">
            <h4>Genre(s)</h4>
            <ul>
                <xsl:for-each select="ead:genreform">
                    <li><xsl:apply-templates/> </li>
                </xsl:for-each>
           </ul>     
        </xsl:if>
        <xsl:if test="ead:geogname">
            <h4>Geographic Name(s)</h4>
            <ul>
                <xsl:for-each select="ead:geogname">
                    <li><xsl:apply-templates/> </li>
                </xsl:for-each>                        
            </ul>
        </xsl:if>
        <xsl:if test="ead:occupation">
            <h4>Occupation(s)</h4>
            <ul>
                <xsl:for-each select="ead:occupation">
                    <li><xsl:apply-templates/> </li>
                </xsl:for-each>                        
            </ul>
        </xsl:if>
        <xsl:if test="ead:persname">
            <h4>Personal Name(s)</h4>
            <ul>
                <xsl:for-each select="ead:persname">
                    <li><xsl:apply-templates/> </li>
                </xsl:for-each>                        
            </ul>
        </xsl:if>
        <xsl:if test="ead:subject">
            <h4>Subject(s)</h4>
            <ul>
                <xsl:for-each select="ead:subject">
                    <li><xsl:apply-templates/> </li>
                </xsl:for-each>                        
            </ul>
        </xsl:if>
        <xsl:if test="parent::ead:archdesc"><xsl:call-template name="returnTOC"/></xsl:if>
    </xsl:template>

    <!-- Formats index and child elements, groups indexentry elements by type (i.e. corpname, subject...)-->
    <xsl:template match="ead:index">
       <xsl:choose>
           <xsl:when test="ead:head"/>
           <xsl:otherwise>
               <xsl:choose>
                   <xsl:when test="parent::ead:archdesc">
                       <h3><xsl:call-template name="anchor"/>Index</h3>
                   </xsl:when>
                   <xsl:otherwise>
                       <h4><xsl:call-template name="anchor"/>Index</h4>
                   </xsl:otherwise>
               </xsl:choose>    
           </xsl:otherwise>
       </xsl:choose>
       <xsl:apply-templates select="child::*[not(self::ead:indexentry)]"/>
                <xsl:if test="ead:indexentry/ead:corpname">
                    <h4>Corporate Name(s)</h4>
                    <ul>
                        <xsl:for-each select="ead:indexentry/ead:corpname">
                            <xsl:sort/>
                            <li><xsl:apply-templates select="."/>: &#160;<xsl:apply-templates select="following-sibling::*"/></li>
                        </xsl:for-each>
                     </ul>   
                </xsl:if>
                <xsl:if test="ead:indexentry/ead:famname">
                    <h4>Family Name(s)</h4>
                    <ul>
                        <xsl:for-each select="ead:indexentry/ead:famname">
                            <xsl:sort/>
                            <li><xsl:apply-templates select="."/>: &#160;<xsl:apply-templates select="following-sibling::*"/></li>
                        </xsl:for-each>
                    </ul>    
                </xsl:if>      
                <xsl:if test="ead:indexentry/ead:function">
                    <h4>Function(s)</h4>
                    <ul>
                        <xsl:for-each select="ead:indexentry/ead:function">
                            <xsl:sort/>
                            <li><xsl:apply-templates select="."/>: &#160;<xsl:apply-templates select="following-sibling::*"/></li>
                        </xsl:for-each>
                    </ul>
                </xsl:if>
                <xsl:if test="ead:indexentry/ead:genreform">
                    <h4>Genre(s)</h4> 
                    <ul>
                        <xsl:for-each select="ead:indexentry/ead:genreform">
                            <xsl:sort/>
                            <li><xsl:apply-templates select="."/>: &#160;<xsl:apply-templates select="following-sibling::*"/></li>
                        </xsl:for-each>           
                    </ul>
                </xsl:if>
                <xsl:if test="ead:indexentry/ead:geogname">
                    <h4>Geographic Name(s)</h4>
                    <ul>
                        <xsl:for-each select="ead:indexentry/ead:geogname">
                            <xsl:sort/>
                            <li><xsl:apply-templates select="."/>: &#160;<xsl:apply-templates select="following-sibling::*"/></li>
                        </xsl:for-each>
                    </ul>                    
                </xsl:if>
                <xsl:if test="ead:indexentry/ead:name">
                    <h4>Name(s)</h4>
                    <ul>
                        <xsl:for-each select="ead:indexentry/ead:name">
                            <xsl:sort/>
                            <li><xsl:apply-templates select="."/>: &#160;<xsl:apply-templates select="following-sibling::*"/></li>
                        </xsl:for-each>
                    </ul>    
                </xsl:if>
                <xsl:if test="ead:indexentry/ead:occupation">
                    <h4>Occupation(s)</h4> 
                    <ul>
                        <xsl:for-each select="ead:indexentry/ead:occupation">
                            <xsl:sort/>
                            <li><xsl:apply-templates select="."/>: &#160;<xsl:apply-templates select="following-sibling::*"/></li>
                        </xsl:for-each>
                    </ul>
                </xsl:if>
                <xsl:if test="ead:indexentry/ead:persname">
                    <h4>Personal Name(s)</h4>
                    <ul>
                        <xsl:for-each select="ead:indexentry/ead:persname">
                            <xsl:sort/>
                            <li><xsl:apply-templates select="."/>: &#160;<xsl:apply-templates select="following-sibling::*"/></li>
                        </xsl:for-each>
                    </ul>
                </xsl:if>
                <xsl:if test="ead:indexentry/ead:subject">
                    <h4>Subject(s)</h4> 
                    <ul>
                        <xsl:for-each select="ead:indexentry/ead:subject">
                            <xsl:sort/>
                            <li><xsl:apply-templates select="."/>: &#160;<xsl:apply-templates select="following-sibling::*"/></li>
                        </xsl:for-each>
                    </ul>
                </xsl:if>
                <xsl:if test="ead:indexentry/ead:title">
                    <h4>Title(s)</h4>
                    <ul>
                        <xsl:for-each select="ead:indexentry/ead:title">
                            <xsl:sort/>
                            <li><xsl:apply-templates select="."/>: &#160;<xsl:apply-templates select="following-sibling::*"/></li>
                        </xsl:for-each>
                    </ul>
                </xsl:if>         
       <xsl:if test="parent::ead:archdesc"><xsl:call-template name="returnTOC"/></xsl:if>
   </xsl:template>
    <xsl:template match="ead:indexentry">
        <dl class="indexEntry">
            <dt><xsl:apply-templates select="child::*[1]"/></dt>
            <dd><xsl:apply-templates select="child::*[2]"/></dd>    
        </dl>
    </xsl:template>
    <xsl:template match="ead:ptrgrp">
        <xsl:apply-templates/>
    </xsl:template>
    
    <!-- Linking elements. -->
    <xsl:template match="ead:ptr">
        <xsl:choose>
            <xsl:when test="@target">
                <a href="#{@target}"><xsl:value-of select="@target"/></a>
                <xsl:if test="following-sibling::ead:ptr">, </xsl:if>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="ead:ref">
        <xsl:choose>
            <xsl:when test="@target">
                <a href="#{@target}">
                    <xsl:apply-templates/>
                </a>
                <xsl:if test="following-sibling::ead:ref">, </xsl:if>
            </xsl:when>
            <xsl:when test="@ns2:href">
                <a href="#{@ns2:href}">
                    <xsl:apply-templates/>
                </a>
                <xsl:if test="following-sibling::ead:ref">, </xsl:if>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>    
    <xsl:template match="ead:extptr">
        <xsl:choose>
            <xsl:when test="@href">
                <a href="{@href}"><xsl:value-of select="@href"/></a>
            </xsl:when>
            <xsl:when test="@ns2:href">
                <a href="{@ns2:href}"><xsl:value-of select="@ns2:title"/></a>
            </xsl:when>
            <xsl:otherwise><xsl:value-of select="@title"/></xsl:otherwise>
        </xsl:choose> 
    </xsl:template>
    <xsl:template match="ead:extref">
        <xsl:choose>
            <xsl:when test="@href">
                <a href="{@href}"><xsl:value-of select="."/></a>
            </xsl:when>
            <xsl:when test="@ns2:href"><a href="{@ns2:href}"><xsl:value-of select="."/></a></xsl:when>
            <xsl:otherwise><xsl:value-of select="."/></xsl:otherwise>
        </xsl:choose> 
    </xsl:template>
    
    <!--Creates a hidden anchor tag that allows navigation within the finding aid. 
    In this stylesheet only children of the archdesc and c0* itmes call this template. 
    It can be applied anywhere in the stylesheet as the id attribute is universal. -->
    <xsl:template match="@id">
        <xsl:attribute name="id"><xsl:value-of select="."/></xsl:attribute>
    </xsl:template>
    <xsl:template name="anchor">
        <xsl:choose>
            <xsl:when test="@id">
                <xsl:attribute name="id"><xsl:value-of select="@id"/></xsl:attribute>
            </xsl:when>
            <xsl:otherwise>
                <xsl:attribute name="id"><xsl:value-of select="generate-id(.)"/></xsl:attribute>
            </xsl:otherwise>
            </xsl:choose>
    </xsl:template>
    <xsl:template name="tocLinks">
        <xsl:choose>
            <xsl:when test="self::*/@id">
                <xsl:attribute name="href">#<xsl:value-of select="@id"/></xsl:attribute>
            </xsl:when>
            <xsl:otherwise>
                <xsl:attribute name="href">#<xsl:value-of select="generate-id(.)"/></xsl:attribute>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
 
    <!--Bibref, choose statement decides if the citation is inline, if there is a parent element
    or if it is its own line, typically when it is a child of the bibliography element.-->
    <xsl:template match="ead:bibref">
        <xsl:choose>
            <xsl:when test="parent::ead:p">
                <xsl:choose>
                    <xsl:when test="@ns2:href">
                        <a href="{@ns2:href}"><xsl:apply-templates/></a>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:apply-templates/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
                <p>
                    <xsl:choose>
                        <xsl:when test="@ns2:href">
                            <a href="{@ns2:href}"><xsl:apply-templates/></a>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:apply-templates/>
                        </xsl:otherwise>
                    </xsl:choose>
                </p>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
   
    <!-- Formats prefered citiation -->
    <xsl:template match="ead:prefercite">
        <div class="citation">
            <xsl:choose>
                <xsl:when test="ead:head"><xsl:apply-templates/></xsl:when>
                <xsl:otherwise><h4>Preferred Citation</h4><xsl:apply-templates/></xsl:otherwise>
            </xsl:choose>
        </div>
    </xsl:template>

    <!-- Applies a span style to address elements, currently addresses are displayed 
        as a block item, display can be changed to inline, by changing the CSS -->
    <xsl:template match="ead:address">
        <span class="address">
            <xsl:for-each select="child::*">
                <xsl:apply-templates/>
                <xsl:choose>
                    <xsl:when test="ead:lb"/>
                    <xsl:otherwise><br/></xsl:otherwise>
                </xsl:choose>
            </xsl:for-each>            
        </span>    
    </xsl:template>
    
    <!-- Formats headings throughout the finding aid -->
    <xsl:template match="ead:head[parent::*/parent::ead:archdesc]">
        <xsl:choose>
            <xsl:when test="parent::ead:accessrestrict or parent::ead:userestrict or
                parent::ead:custodhist or parent::ead:accruals or
                parent::ead:altformavail or parent::ead:acqinfo or
                parent::ead:processinfo or parent::ead:appraisal or
                parent::ead:originalsloc or  
                parent::ead:relatedmaterial or parent::ead:separatedmaterial or parent::ead:prefercite">
                <h4>
                    <xsl:choose>
                        <xsl:when test="parent::*/@id">
                            <xsl:attribute name="id"><xsl:value-of select="parent::*/@id"/></xsl:attribute>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:attribute name="id"><xsl:value-of select="generate-id(parent::*)"/></xsl:attribute>
                        </xsl:otherwise>
                    </xsl:choose>
                    <xsl:apply-templates/>
                </h4>
            </xsl:when>
            <xsl:otherwise>
                <h3>
                    <xsl:choose>
                        <xsl:when test="parent::*/@id">
                            <xsl:attribute name="id"><xsl:value-of select="parent::*/@id"/></xsl:attribute>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:attribute name="id"><xsl:value-of select="generate-id(parent::*)"/></xsl:attribute>
                        </xsl:otherwise>
                    </xsl:choose>
                    <xsl:apply-templates/>
                </h3>                
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="ead:head">
    	<xsl:if test="../../node()[@level] != 'file' and ../../node()[@level] != 'item'">
        	<p><strong><xsl:apply-templates/></strong></p>
	</xsl:if>
    </xsl:template>
    
    <!-- Digital Archival Object -->
    <xsl:template match="ead:daogrp">
        <xsl:choose>
            <xsl:when test="parent::ead:archdesc">
                <h3><xsl:call-template name="anchor"/>
                    <xsl:choose>
                    <xsl:when test="@ns2:title">
                       <xsl:value-of select="@ns2:title"/>
                    </xsl:when>
                    <xsl:otherwise>
                        Digital Archival Object
                    </xsl:otherwise>
                    </xsl:choose>
                </h3>
            </xsl:when>
            <xsl:otherwise>
                <h4><xsl:call-template name="anchor"/>
                    <xsl:choose>
                    <xsl:when test="@ns2:title">
                       <xsl:value-of select="@ns2:title"/>
                    </xsl:when>
                    <xsl:otherwise>
                        Digital Archival Object
                    </xsl:otherwise>
                </xsl:choose>
                </h4>
            </xsl:otherwise>
        </xsl:choose>   
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="ead:dao">
<!--        <xsl:variable name="unittitle"><xsl:value-of select="../ead:did/ead:unittitle"/></xsl:variable> -->
        <xsl:variable name="unittitle">
          <xsl:call-template name="striptags">
            <xsl:with-param name="letters" select="normalize-space(../ead:did/ead:unittitle)" />
          </xsl:call-template>
        </xsl:variable>

        <xsl:choose>
            <xsl:when test="child::*">
                <!-- BAD BAD this call to apply-templates is adding all kinds of extra stuff in the table cell that I don't want 
   xsl:apply-templates/ -->
<!-- <xsl:apply-templates />  -->
<!-- BGG - call a php function here to test the value in the @ns2:href, if it is a good object, display a link to that object as 
           the rules determined, else display the text "(Online pending)" -->
                <xsl:choose>
                    <xsl:when test="php:function('islandora_upitt_object_uri_if_exists', current()) = 'true'">
                   <a>
                      <xsl:attribute name="href">
<!-- BGG - this test to see if it is a BARCODE needed to be modified so that any object value might be linked.  
     For example, 31735044222671 could link before and become pitt:31735044222671, but values like DARIMG0005
     would not link correctly - those links were actually appending to the current URI for the finding aid itself
     like /islandora/object/pitt:US-PPiU-test001/DARIMG0005 instead of 
     like /islandora/object/pitt:DARIMG0005 -->

<!--                         <xsl:if test="string(number(@ns2:href)) != 'NaN'"> -->
                         <xsl:if test="string(@ns2:href) != 'NaN'">
                             <xsl:text>/islandora/object/pitt:</xsl:text>
                         </xsl:if>
                         <xsl:value-of select="@ns2:href" />
                      </xsl:attribute>
                      <xsl:choose>
                         <xsl:when test="@ns2:title = $unittitle">
                            <xsl:text>Online</xsl:text>
                         </xsl:when>
                         <xsl:otherwise>
                            <xsl:value-of select="@ns2:title"/>
                         </xsl:otherwise>
                      </xsl:choose>
                   </a>
                   <xsl:text> </xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>("</xsl:text><xsl:value-of select="@ns2:title"/><xsl:text>" online pending) </xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
                <a href="{@ns2:href}">
                    <xsl:value-of select="@ns2:href"/>
                </a>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="ead:daoloc">
        <a href="{@ns2:href}">
            <xsl:value-of select="@ns2:title"/>
        </a>
    </xsl:template>
    
    <!--Formats a simple table. The width of each column is defined by the colwidth attribute in a colspec element.-->
    <xsl:template match="ead:table">
        <xsl:for-each select="tgroup">
            <table>
                <tr>
                    <xsl:for-each select="ead:colspec">
                        <td width="{@colwidth}"/>
                    </xsl:for-each>
                </tr>
                <xsl:for-each select="ead:thead">
                    <xsl:for-each select="ead:row">
                        <tr>
                            <xsl:for-each select="ead:entry">
                                <td valign="top">
                                    <strong>
                                        <xsl:value-of select="."/>
                                    </strong>
                                </td>
                            </xsl:for-each>
                        </tr>
                    </xsl:for-each>
                </xsl:for-each>
                <xsl:for-each select="ead:tbody">
                    <xsl:for-each select="ead:row">
                        <tr>
                            <xsl:for-each select="ead:entry">
                                <td valign="top">
                                    <xsl:value-of select="."/>
                                </td>
                            </xsl:for-each>
                        </tr>
                    </xsl:for-each>
                </xsl:for-each>
            </table>
        </xsl:for-each>
    </xsl:template>
    <xsl:template match="ead:unitdate">
        <xsl:if test="preceding-sibling::*">&#160;</xsl:if>
        <xsl:choose>
            <xsl:when test="@type = 'bulk'">
                (<xsl:apply-templates/>)                            
            </xsl:when>
            <xsl:otherwise><xsl:apply-templates/></xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="ead:date">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="ead:unittitle">
        <xsl:choose>
            <xsl:when test="child::ead:unitdate[@type='bulk']">
                <xsl:apply-templates select="node()[not(self::ead:unitdate[@type='bulk'])]"/>
                <xsl:apply-templates select="ead:date[@type='bulk']"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <!-- Following five templates output chronlist and children in a table -->
    <xsl:template match="ead:chronlist">
        <table class="chronlist">
            <xsl:apply-templates/>
        </table>
    </xsl:template>
    <xsl:template match="ead:chronlist/ead:listhead">
        <tr>
            <th>
                <xsl:apply-templates select="ead:head01"/>
            </th>
            <th>
                <xsl:apply-templates select="ead:head02"/>
            </th>
        </tr>
    </xsl:template>
    <xsl:template match="ead:chronlist/ead:head">
        <tr>
            <th colspan="2">
                <xsl:apply-templates/>
            </th>
        </tr>
    </xsl:template>
    <xsl:template match="ead:chronitem">
        <tr>
            <xsl:attribute name="class">
                <xsl:choose>
                    <xsl:when test="(position() mod 2 = 0)">odd</xsl:when>
                    <xsl:otherwise>even</xsl:otherwise>
                </xsl:choose>
            </xsl:attribute>
            <td><xsl:apply-templates select="ead:date"/></td>
            <td><xsl:apply-templates select="descendant::ead:event"/></td>
        </tr>
    </xsl:template>
    <xsl:template match="ead:event">
        <xsl:choose>
            <xsl:when test="following-sibling::*">
                <xsl:apply-templates/><br/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>
        
    </xsl:template>

    <!-- Output for a variety of list types -->
    <xsl:template match="ead:list">
        <xsl:if test="ead:head"><h4><xsl:value-of select="ead:head"/></h4></xsl:if>
        <xsl:choose>
            <xsl:when test="descendant::ead:defitem">
                <dl>
                    <xsl:apply-templates select="ead:defitem"/>
                </dl>
            </xsl:when>
            <xsl:otherwise>
                <xsl:choose>
                    <xsl:when test="@type = 'ordered'">
                        <ol>
                            <xsl:attribute name="class">
                                <xsl:value-of select="@numeration"/>
                            </xsl:attribute>
                            <xsl:apply-templates/>
                        </ol>
                    </xsl:when>
                    <xsl:when test="@numeration">
                        <ol>
                            <xsl:attribute name="class">
                                <xsl:value-of select="@numeration"/>
                            </xsl:attribute>
                            <xsl:apply-templates/>
                        </ol>
                    </xsl:when>
                    <xsl:when test="@type='simple'">
                        <ul>
                            <xsl:attribute name="class">simple</xsl:attribute>
                            <xsl:apply-templates select="child::*[not(ead:head)]"/>
                        </ul>
                    </xsl:when>
                    <xsl:otherwise>
                        <ul>
                            <xsl:apply-templates/>
                        </ul>        
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="ead:list/ead:head"/>
    <xsl:template match="ead:list/ead:item">
        <li><xsl:apply-templates/></li>
    </xsl:template>
    <xsl:template match="ead:defitem">
        <dt><xsl:apply-templates select="ead:label"/></dt>
        <dd><xsl:apply-templates select="ead:item"/></dd>
    </xsl:template>
 
    <!-- Formats list as tabel if list has listhead element  -->         
    <xsl:template match="ead:list[child::ead:listhead]">
        <table>
            <tr>
                <th><xsl:value-of select="ead:listhead/ead:head01"/></th>
                <th><xsl:value-of select="ead:listhead/ead:head02"/></th>
            </tr>
            <xsl:for-each select="ead:defitem">
                <tr>
                    <td><xsl:apply-templates select="ead:label"/></td>
                    <td><xsl:apply-templates select="ead:item"/></td>
                </tr>
            </xsl:for-each>
        </table>
    </xsl:template>

    <!-- Formats notestmt and notes -->
    <xsl:template match="ead:notestmt">
        <h4>Note</h4>
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="ead:note">
         <xsl:choose>
             <xsl:when test="parent::ead:notestmt">
                 <xsl:apply-templates/>
             </xsl:when>
             <xsl:otherwise>
                 <xsl:choose>
                     <xsl:when test="@label"><h4><xsl:value-of select="@label"/></h4><xsl:apply-templates/></xsl:when>
                     <xsl:otherwise><h4>Note</h4><xsl:apply-templates/></xsl:otherwise>
                 </xsl:choose>
             </xsl:otherwise>
         </xsl:choose>
     </xsl:template>
    
    <!-- Child elements that should display as paragraphs-->
    <xsl:template match="ead:legalstatus">
        <p><xsl:apply-templates/></p>
    </xsl:template>
    <!-- Puts a space between sibling elements -->
    <xsl:template match="child::*">
        <xsl:if test="preceding-sibling::*">&#160;</xsl:if>
        <xsl:apply-templates/>
    </xsl:template>
    <!-- Generic text display elements -->
    <xsl:template match="ead:p">
        <p><xsl:apply-templates/></p>
    </xsl:template>
    <xsl:template match="ead:lb"><br/></xsl:template>
    <xsl:template match="ead:blockquote">
        <blockquote><xsl:apply-templates/></blockquote>
    </xsl:template>
    <xsl:template match="ead:emph"><em><xsl:apply-templates/></em></xsl:template>
    
    <!--Render elements -->
    <xsl:template match="*[@render = 'bold'] | *[@altrender = 'bold'] ">
        <xsl:if test="preceding-sibling::*"> &#160;</xsl:if><strong><xsl:apply-templates/></strong>
    </xsl:template>
    <xsl:template match="*[@render = 'bolddoublequote'] | *[@altrender = 'bolddoublequote']">
        <xsl:if test="preceding-sibling::*"> &#160;</xsl:if><strong>"<xsl:apply-templates/>"</strong>
    </xsl:template>
    <xsl:template match="*[@render = 'boldsinglequote'] | *[@altrender = 'boldsinglequote']">
        <xsl:if test="preceding-sibling::*"> &#160;</xsl:if><strong>'<xsl:apply-templates/>'</strong>
    </xsl:template>
    <xsl:template match="*[@render = 'bolditalic'] | *[@altrender = 'bolditalic']">
        <xsl:if test="preceding-sibling::*"> &#160;</xsl:if><strong><em><xsl:apply-templates/></em></strong>
    </xsl:template>
    <xsl:template match="*[@render = 'boldsmcaps'] | *[@altrender = 'boldsmcaps']">
        <xsl:if test="preceding-sibling::*"> &#160;</xsl:if><strong><span class="smcaps"><xsl:apply-templates/></span></strong>
    </xsl:template>
    <xsl:template match="*[@render = 'boldunderline'] | *[@altrender = 'boldunderline']">
        <xsl:if test="preceding-sibling::*"> &#160;</xsl:if><strong><span class="underline"><xsl:apply-templates/></span></strong>
    </xsl:template>
    <xsl:template match="*[@render = 'doublequote'] | *[@altrender = 'doublequote']">
        <xsl:if test="preceding-sibling::*"> &#160;</xsl:if>"<xsl:apply-templates/>"
    </xsl:template>
    <xsl:template match="*[@render = 'italic'] | *[@altrender = 'italic']">
        <xsl:if test="preceding-sibling::*"> &#160;</xsl:if><em><xsl:apply-templates/></em>
    </xsl:template>
    <xsl:template match="*[@render = 'singlequote'] | *[@altrender = 'singlequote']">
        <xsl:if test="preceding-sibling::*"> &#160;</xsl:if>'<xsl:apply-templates/>'
    </xsl:template>
    <xsl:template match="*[@render = 'smcaps'] | *[@altrender = 'smcaps']">
        <xsl:if test="preceding-sibling::*"> &#160;</xsl:if><span class="smcaps"><xsl:apply-templates/></span>
    </xsl:template>
    <xsl:template match="*[@render = 'sub'] | *[@altrender = 'sub']">
        <xsl:if test="preceding-sibling::*"> &#160;</xsl:if><sub><xsl:apply-templates/></sub>
    </xsl:template>
    <xsl:template match="*[@render = 'super'] | *[@altrender = 'super']">
        <xsl:if test="preceding-sibling::*"> &#160;</xsl:if><sup><xsl:apply-templates/></sup>
    </xsl:template>
    <xsl:template match="*[@render = 'underline'] | *[@altrender = 'underline']">
        <xsl:if test="preceding-sibling::*"> &#160;</xsl:if><span class="underline"><xsl:apply-templates/></span>
    </xsl:template>
    <!-- 
        <value>nonproport</value>        
    -->

    <!-- *** Begin templates for Container List *** -->
    <xsl:template match="ead:archdesc/ead:dsc">
        <xsl:choose>
            <xsl:when test="ead:head">
                <!-- nothing matches this test -->
                <xsl:apply-templates select="ead:head"/>
            </xsl:when>
            <xsl:otherwise>
                <h3><xsl:call-template name="anchor"/>Collection Inventory</h3>
            </xsl:otherwise>
        </xsl:choose>
<!-- BGG - THIS DOES NOT MAKE SENSE - all folder 1 content notes are rendered here -->
        <!-- Creates a table for container lists, defaults to 5 cells, for up to 4 container lists.  -->
        <table class="containerList">
            <xsl:apply-templates select="*[not(self::ead:head)]"/>
            <tr>
                <td/>
                <td style="width: 15%;"/>
                <td style="width: 15%;"/>
                <td style="width: 15%;"/>
                <td style="width: 15%;"/>
            </tr>
            
        </table>
    </xsl:template>
    
    <!--This section of the stylesheet creates a div for each c01 or c 
        It then recursively processes each child component of the c01 by 
        calling the clevel template. -->
    <xsl:template match="ead:c">
        <xsl:call-template name="clevel"/>
        <xsl:for-each select="ead:c">
            <xsl:call-template name="clevel"/> 
            <xsl:for-each select="ead:c">
                <xsl:call-template name="clevel"/>    
                <xsl:for-each select="ead:c">
                    <xsl:call-template name="clevel"/>
                    <xsl:for-each select="ead:c">
                        <xsl:call-template name="clevel"/>
                        <xsl:for-each select="ead:c">
                            <xsl:call-template name="clevel"/> 
                            <xsl:for-each select="ead:c">
                                <xsl:call-template name="clevel"/>
                                <xsl:for-each select="ead:c">
                                    <xsl:call-template name="clevel"/>
                                    <xsl:for-each select="ead:c">
                                        <xsl:call-template name="clevel"/>    
                                    </xsl:for-each>
                                </xsl:for-each>
                            </xsl:for-each>
                        </xsl:for-each>
                    </xsl:for-each>
                </xsl:for-each>
            </xsl:for-each>
        </xsl:for-each>
    </xsl:template>
<!-- XXXX set a variable in the c01 block if there are no c02s so that the TOC is suppressed -->
    <xsl:template match="ead:c01">
        <xsl:call-template name="clevel"/>
        <xsl:for-each select="ead:c02">
            <xsl:call-template name="clevel"/>
            <xsl:for-each select="ead:c03">
                <xsl:call-template name="clevel"/>
                <xsl:for-each select="ead:c04">
                    <xsl:call-template name="clevel"/>
                    <xsl:for-each select="ead:c05">
                        <xsl:call-template name="clevel"/>
                        <xsl:for-each select="ead:c06">
                            <xsl:call-template name="clevel"/>
                            <xsl:for-each select="ead:c07">
                                <xsl:call-template name="clevel"/>
                                <xsl:for-each select="ead:c08">
                                    <xsl:call-template name="clevel"/>
                                    <xsl:for-each select="ead:c09">
                                        <xsl:call-template name="clevel"/>
                                        <xsl:for-each select="ead:c10">
                                            <xsl:call-template name="clevel"/>
                                            <xsl:for-each select="ead:c11">
                                                <xsl:call-template name="clevel"/>
                                                <xsl:for-each select="ead:c12">
                                                    <xsl:call-template name="clevel"/>
                                                </xsl:for-each>
                                            </xsl:for-each>
                                        </xsl:for-each>
                                    </xsl:for-each>
                                </xsl:for-each>
                            </xsl:for-each>
                        </xsl:for-each>
                    </xsl:for-each>
                </xsl:for-each>
            </xsl:for-each>
        </xsl:for-each>
        <tr>
            <td colspan="5">
<!-- XXXX -->
<!-- check that variable here       <xsl:if test="parent::ead:c02"> -->
                <xsl:call-template name="returnTOC"/>
<!--       </xsl:if> -->

            </td>
        </tr>
    </xsl:template>
    <!--This is a named template that processes all c0* elements  -->
    <xsl:template name="clevel">
    <!-- Establishes which level is being processed in order to provided indented displays. 
        Indents handled by CSS margins-->
        <xsl:variable name="clevelMargin">
            <xsl:choose>
                <xsl:when test="../ead:c">c</xsl:when>
                <xsl:when test="../ead:c01">c01</xsl:when>
                <xsl:when test="../ead:c02">c02</xsl:when>
                <xsl:when test="../ead:c03">c03</xsl:when>
                <xsl:when test="../ead:c04">c04</xsl:when>
                <xsl:when test="../ead:c05">c05</xsl:when>
                <xsl:when test="../ead:c06">c06</xsl:when>
                <xsl:when test="../ead:c07">c07</xsl:when>
                <xsl:when test="../ead:c08">c08</xsl:when>
                <xsl:when test="../ead:c08">c09</xsl:when>
                <xsl:when test="../ead:c08">c10</xsl:when>
                <xsl:when test="../ead:c08">c11</xsl:when>
                <xsl:when test="../ead:c08">c12</xsl:when>
            </xsl:choose>
        </xsl:variable>
    <!-- Establishes a class for even and odd rows in the table for color coding. 
        Colors are Declared in the CSS. -->
        <xsl:variable name="colorClass">
            <xsl:choose>
                <xsl:when test="ancestor-or-self::*[@level='file' or @level='item']">
                    <xsl:choose>
                        <xsl:when test="(position() mod 2 = 0)">odd</xsl:when>
                        <xsl:otherwise>even</xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
            </xsl:choose>
        </xsl:variable>
        <!-- Processes the all child elements of the c or c0* level -->
        <xsl:for-each select=".">
            <xsl:choose>
                <!--Formats Series and Groups  -->
                <xsl:when test="@level='subcollection' or @level='subgrp' or @level='series' 
                    or @level='subseries' or @level='collection'or @level='fonds' or 
                    @level='recordgrp' or @level='subfonds' or @level='class' or (@level='otherlevel' and not(child::ead:did/ead:container))">
                    <tr> 
                        <xsl:attribute name="class">
                            <xsl:choose>
                                <xsl:when test="@level='subcollection' or @level='subgrp' or @level='subseries' or @level='subfonds'">subseries</xsl:when>
                                <xsl:otherwise>series</xsl:otherwise>
                            </xsl:choose>    
                        </xsl:attribute>
                        <xsl:choose>
                            <xsl:when test="ead:did/ead:container">
                            <td class="{$clevelMargin}">
                            <xsl:choose>                                
                                <xsl:when test="count(ead:did/ead:container) &lt; 1">
                                    <xsl:attribute name="colspan">
                                        <xsl:text>5</xsl:text>
                                    </xsl:attribute>
                                </xsl:when>
                                <xsl:when test="count(ead:did/ead:container) =1">
                                    <xsl:attribute name="colspan">
                                        <xsl:text>4</xsl:text>
                                    </xsl:attribute>
                                </xsl:when>
                                <xsl:when test="count(ead:did/ead:container) = 2">
                                    <xsl:attribute name="colspan">
                                        <xsl:text>3</xsl:text>
                                    </xsl:attribute>
                                </xsl:when>
                                <xsl:when test="count(ead:did/ead:container) = 3">
                                    <xsl:attribute name="colspan">
                                        <xsl:text>2</xsl:text>
                                    </xsl:attribute>
                                </xsl:when>
                                <xsl:otherwise/>
                            </xsl:choose>    
                                <xsl:call-template name="anchor"/>
                                <xsl:apply-templates select="ead:did" mode="dsc"/>
                                <xsl:apply-templates select="child::*[not(ead:did) and not(self::ead:did)]"/>
                            </td>
                            <xsl:for-each select="descendant::ead:did[ead:container][1]/ead:container">    
                                <td class="containerHeader">    
                                    <xsl:value-of select="@type"/><br/><xsl:value-of select="."/>       
                                </td>    
                            </xsl:for-each>
                            </xsl:when>
                            <xsl:otherwise>
                                <td colspan="5" class="{$clevelMargin}">
                                    <xsl:call-template name="anchor"/>
                                    <xsl:apply-templates select="ead:did" mode="dsc"/>
                                    <xsl:apply-templates select="child::*[not(ead:did) and not(self::ead:did)]"/>
                                </td>
                            </xsl:otherwise>
                        </xsl:choose>
                    </tr>
                </xsl:when>
                
                <!--Items/Files with multiple formats linked using parent and id attributes -->
<!-- BGG - no longer require that the first container child has a parent attribute -->
                <!-- <xsl:when test="child::*/ead:container/@parent"> -->
                <xsl:when test="child::*/ead:container/@type and child::*/ead:container/@id">
                    <tr class="{$colorClass}">
                        <td colspan="5">
<!--                            <xsl:apply-templates select="ead:did" mode="dsc"/>  -->
<!-- BGG adding table back -->
                          <!--  <br class="clear"/> -->
<xsl:if test="count(child::*/ead:container[@label]) &gt; 0">
                            <table class="parentContainers">
                                <xsl:for-each select="child::*/ead:container[@label]">
                                    <xsl:variable name="id" select="@id"/>
                                    <xsl:variable name="container" select="count(../ead:container[@parent = $id] | ../ead:container[@id = $id])"/>
                                    <tr class="containerTypes odd">
<!--                                        <td>&#160;</td> -->

                                        <td class="major_column">
                                            <xsl:choose>
                                                <xsl:when test="$container = ''"><xsl:attribute name="colspan">4</xsl:attribute></xsl:when>
                                                <xsl:when test="$container = 1"><xsl:attribute name="colspan">4</xsl:attribute></xsl:when>
                                                <xsl:when test="$container = 2"><xsl:attribute name="colspan">3</xsl:attribute></xsl:when>
                                                <xsl:when test="$container = 3"><xsl:attribute name="colspan">2</xsl:attribute></xsl:when>
                                                <xsl:when test="$container = 4"/>
                                                <xsl:otherwise/>
                                            </xsl:choose>
                                            &#160;
                                        </td>
                                        <xsl:for-each select="../ead:container[@parent = $id] | ../ead:container[@id = $id]">
                                            <td class="td_wide"><strong><xsl:value-of select="@type"/></strong></td>
                                        </xsl:for-each>
                                    </tr>
                                    <tr class="odd">
                                        <td>
                                            <xsl:choose>
                                                <xsl:when test="$container = ''"><xsl:attribute name="colspan">4</xsl:attribute></xsl:when>
                                                <xsl:when test="$container = 1"><xsl:attribute name="colspan">4</xsl:attribute></xsl:when>
                                                <xsl:when test="$container = 2"><xsl:attribute name="colspan">3</xsl:attribute></xsl:when>
                                                <xsl:when test="$container = 3"><xsl:attribute name="colspan">2</xsl:attribute></xsl:when>
                                                <xsl:when test="$container = 4"/>
                                                <xsl:otherwise/>
                                            </xsl:choose>

                                            <!-- This will run the templates to apply styles on the parent element "..", which is the ead:did -->
                                            <xsl:apply-templates select=".." mode="dsc"/>
                                        </td>
<!-- was "Mixed materials"              <td>
                                            <xsl:value-of select="@label"/>
                                        </td>
-->
<!--                                        <td>
                                            <xsl:choose>
                                                <xsl:when test="$container = ''"><xsl:attribute name="colspan">3</xsl:attribute></xsl:when>
                                                <xsl:when test="$container = 1"><xsl:attribute name="colspan">3</xsl:attribute></xsl:when>
                                                <xsl:when test="$container = 2"><xsl:attribute name="colspan">2</xsl:attribute></xsl:when>
                                                <xsl:when test="$container = 3"><xsl:attribute name="colspan">1</xsl:attribute></xsl:when>
                                                <xsl:when test="$container = 4"/>
                                                <xsl:otherwise/>
                                            </xsl:choose>
                                            &#160;
                                        </td> -->
                                        <xsl:for-each select="../ead:container[@parent = $id] | ../ead:container[@id = $id]">
                                            <td class="td_wide">
                                               <xsl:apply-templates/>
                                            </td>
                                        </xsl:for-each>
                                    </tr>
                                </xsl:for-each>
<!--                                <xsl:if test="descendant-or-self::ead:dao">
                                    <tr>
                                        <td colspan="6">
                                    <xsl:for-each select="descendant-or-self::ead:dao">

                                               <a>
                                                    <xsl:attribute name="href">
                                                        <xsl:if test="string(number(@ns2:href)) != 'NaN'">
                                                            <xsl:text>/islandora/object/pitt:</xsl:text>
                                                        </xsl:if>
                                                        <xsl:value-of select="@ns2:href" />
                                                    </xsl:attribute>
                                                    <xsl:value-of select="ead:daodesc"/>
                                                </a> | <xsl:call-template name="containers-attributes"/>
                                    </xsl:for-each>
                                        </td>
                                    </tr> 
                                </xsl:if> -->
                            </table>

</xsl:if>
<!--                            <br class="clearfloat" /> -->

<!-- BGG - removed the logic to apply a template if not the first folder.  previous code is below.
                            <xsl:apply-templates select="*[not(self::ead:did) and not(descendant-or-self::ead:dao) and -->
                            <xsl:apply-templates select="*[not(self::ead:did) and
                                not(self::ead:c) and not(self::ead:c02) and not(self::ead:c03) and
                                not(self::ead:c04) and not(self::ead:c05) and not(self::ead:c06) and not(self::ead:c07)
                                and not(self::ead:c08) and not(self::ead:c09) and not(self::ead:c10) and not(self::ead:c11) and not(self::ead:c12)]"/>
                        </td>
                    </tr>
                </xsl:when>
                    
                <!-- Items/Files--> 
                <xsl:when test="@level='file' or @level='item' or (@level='otherlevel'and child::ead:did/ead:container)">
                  <!-- Variables to  for Conainer headings, used only if headings are different from preceding heading -->
                    <xsl:variable name="container" select="string(ead:did/ead:container[1]/@type)"/>
                    <xsl:variable name="container2" select="string(ead:did/ead:container[2]/@type)"/>
                    <xsl:variable name="container3" select="string(ead:did/ead:container[3]/@type)"/>
                    <xsl:variable name="container4" select="string(ead:did/ead:container[4]/@type)"/>
                    <!-- Counts contianers for current and preceding instances and if different inserts a heading -->
                    <xsl:variable name="containerCount" select="count(ead:did/ead:container)"/>
                    <xsl:variable name="sibContainerCount" select="count(preceding-sibling::*[1]/ead:did/ead:container)"/>
                    <!-- Variable estabilishes previouse container types for comparisson to current container. -->
                    <xsl:variable name="sibContainer" select="string(preceding-sibling::*[1]/ead:did/ead:container[1]/@type)"/>
                    <xsl:variable name="sibContainer2" select="string(preceding-sibling::*[1]/ead:did/ead:container[2]/@type)"/>
                    <xsl:variable name="sibContainer3" select="string(preceding-sibling::*[1]/ead:did/ead:container[3]/@type)"/>
                    <xsl:variable name="sibContainer4" select="string(preceding-sibling::*[1]/ead:did/ead:container[4]/@type)"/>
                    <!-- Tests to see if current container type is different from previous container type, if it is a new row with container type headings is outout -->
<!--                    <xsl:if test="$container != $sibContainer or $container2 != $sibContainer2 or $container3 != $sibContainer3 or $container4 != $sibContainer4 or$containerCount != $sibContainerCount">
                        <xsl:if test="ead:did/ead:container">
                            <tr>
                                <td class="title">
                                    <xsl:choose>                                
                                        <xsl:when test="count(ead:did[ead:container][1]/ead:container) &lt; 1">
                                            <xsl:attribute name="colspan">
                                                <xsl:text>5</xsl:text>
                                            </xsl:attribute>
                                        </xsl:when>
                                        <xsl:when test="count(ead:did[ead:container][1]/ead:container) = 1">
                                            <xsl:attribute name="colspan">
                                                <xsl:text>4</xsl:text>
                                            </xsl:attribute>
                                        </xsl:when>
                                        <xsl:when test="count(ead:did[ead:container][1]/ead:container) = 2">
                                            <xsl:attribute name="colspan">
                                                <xsl:text>3</xsl:text>
                                            </xsl:attribute>
                                        </xsl:when>
                                        <xsl:when test="count(ead:did[ead:container][1]/ead:container) = 3">
                                            <xsl:attribute name="colspan">
                                                <xsl:text>2</xsl:text>
                                            </xsl:attribute>
                                        </xsl:when>
                                        <xsl:otherwise/>
                                    </xsl:choose>    
                                    <xsl:text/>
                                </td>
                                <xsl:for-each select="ead:did/ead:container">    
                                    <td class="containerHeader">    
                                        <xsl:value-of select="@type"/>
                                    </td>    
                                </xsl:for-each>
                            </tr>
                        </xsl:if>
                  </xsl:if> -->
                    <!-- if the clevelMargin == "c03", apply a class that will indent the row -->
                    <tr class="{$colorClass}"> 
                        <td class="{$clevelMargin}">
                            <xsl:choose>
                                <xsl:when test="count(ead:did/ead:container) &lt; 1">
                                    <xsl:attribute name="colspan">
                                        <xsl:text>5</xsl:text>
                                    </xsl:attribute>
                                </xsl:when>
                                <xsl:when test="count(ead:did/ead:container) = 1">
                                    <xsl:attribute name="colspan">
                                        <xsl:text>4</xsl:text>
                                    </xsl:attribute>
                                </xsl:when>
                                <xsl:when test="count(ead:did/ead:container) = 2">
                                    <xsl:attribute name="colspan">
                                        <xsl:text>3</xsl:text>
                                    </xsl:attribute>
                                </xsl:when>
                                <xsl:when test="count(ead:did/ead:container) = 3">
                                    <xsl:attribute name="colspan">
                                        <xsl:text>2</xsl:text>
                                    </xsl:attribute>
                                </xsl:when>
                                <xsl:otherwise/>
                            </xsl:choose>
                            <xsl:apply-templates select="ead:did" mode="dsc"/>
                            <xsl:apply-templates select="*[not(self::ead:did) and 
                                not(self::ead:c) and not(self::ead:c02) and not(self::ead:c03) and
                                not(self::ead:c04) and not(self::ead:c05) and not(self::ead:c06) and not(self::ead:c07)
                                and not(self::ead:c08) and not(self::ead:c09) and not(self::ead:c10) and not(self::ead:c11) and not(self::ead:c12)]"/>
                        </td>
                        <!-- Containers -->
                        <xsl:for-each select="ead:did/ead:container">
                            <td class="container">
                                <xsl:value-of select="."/>
                            </td>    
                        </xsl:for-each>
                    </tr>
                </xsl:when>
                <xsl:otherwise>
                    <tr class="{$colorClass}"> 
                        <td class="{$clevelMargin}" colspan="5">
                            <xsl:apply-templates select="ead:did" mode="dsc"/>
                            <xsl:apply-templates select="*[not(self::ead:did) and 
                                not(self::ead:c) and not(self::ead:c02) and not(self::ead:c03) and
                                not(self::ead:c04) and not(self::ead:c05) and not(self::ead:c06) and not(self::ead:c07)
                                and not(self::ead:c08) and not(self::ead:c09) and not(self::ead:c10) and not(self::ead:c11) and not(self::ead:c12)]"/>  
                        </td>
                    </tr>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="ead:did" mode="dsc">
        <xsl:choose>
            <xsl:when test="../@level='subcollection' or ../@level='subgrp' or ../@level='series' 
                or ../@level='subseries' or ../@level='collection' or ../@level='fonds' or 
                ../@level='recordgrp' or ../@level='subfonds' or ../@level='otherlevel'">    
                <h4>
                    <xsl:call-template name="component-did-core"/>
                </h4>
            </xsl:when>
            <!--Otherwise render the text in its normal font.-->
            <xsl:otherwise>
                <xsl:call-template name="component-did-core"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="striptags">
        <xsl:param name="letters"/>
            <xsl:choose>
                <xsl:when test="contains($letters, '&lt;')">
                    <xsl:value-of select="substring-before($letters, '&lt;')"/>
                    <xsl:call-template name="striptags">
                        <xsl:with-param name="letters" select="substring-after($letters, '&gt;')"/>
                    </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$letters"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="component-did-core">
        <xsl:variable name="vLower" select="'abcdefghijklmnopqrstuvwxyz'"/>
        <xsl:variable name="vUpper" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'"/>
        <!--Inserts the parent container level attribute, like "series", "subseries", etc -->
<!--        <xsl:if test="../@level != 'file' and ../@level != 'otherlevel' and ../@level != 'item'"> -->
        <xsl:if test="../@level != 'file' and ../@level != 'item'">
            <xsl:choose>
                <xsl:when test="../@level='otherlevel'">
                     <xsl:text>Section: </xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:variable name="level" select="../@level"/>
                    <xsl:value-of select="concat(translate(substring($level,1,1), $vLower, $vUpper), substring($level, 2))"/>
                </xsl:otherwise>          
            </xsl:choose>
        </xsl:if>

        <xsl:text> </xsl:text>
        <!--Inserts unitid and a space if it exists in the markup.-->
        <!-- <xsl:if test="ead:unitid">
            <xsl:apply-templates select="ead:unitid"/>
            <xsl:text>&#160;</xsl:text>
        </xsl:if> -->
        <!--Inserts origination and a space if it exists in the markup.-->
        <xsl:if test="ead:origination">
            <xsl:apply-templates select="ead:origination"/>
            <xsl:text>&#160;</xsl:text>
        </xsl:if>
        <!--This choose statement selects between cases where unitdate is a child of unittitle and where it is a separate child of did.-->
        <xsl:choose>
            <!--This code processes the elements when unitdate is a child of unittitle.-->
            <xsl:when test="ead:unittitle/ead:unitdate">
                <xsl:apply-templates select="ead:unittitle"/>
            </xsl:when>
            <!--This code process the elements when unitdate is not a child of untititle-->
            <xsl:otherwise> 
                <xsl:apply-templates select="ead:unittitle"/>
                 <xsl:text>&#160;</xsl:text>
                 <xsl:for-each select="ead:unitdate[not(self::ead:unitdate[@type='bulk'])]">
                     <xsl:apply-templates/>
                     <xsl:text>&#160;</xsl:text>
                 </xsl:for-each>
                 <xsl:for-each select="ead:unitdate[@type = 'bulk']">
                     (<xsl:apply-templates/>)
                 </xsl:for-each>
<!--                <xsl:if test="../@level != 'file'"> 
                     <xsl:apply-templates select="ead:unittitle"/>
                     <xsl:text>&#160;</xsl:text>
                     <xsl:for-each select="ead:unitdate[not(self::ead:unitdate[@type='bulk'])]">
                         <xsl:apply-templates/>
                         <xsl:text>&#160;</xsl:text>
                     </xsl:for-each>
                     <xsl:for-each select="ead:unitdate[@type = 'bulk']">
                         (<xsl:apply-templates/>)
                    </xsl:for-each>
                </xsl:if> -->
            </xsl:otherwise>
        </xsl:choose>
        <xsl:if test="ead:physdesc">
            <xsl:text>&#160;</xsl:text>
            <xsl:apply-templates select="ead:physdesc"/>
        </xsl:if>
    </xsl:template>
    <xsl:template name="containers-attributes">
        <xsl:for-each select="../ead:container">
            <xsl:value-of select="@type"/>:
            <xsl:value-of select="."/>
            <xsl:text> </xsl:text>
        </xsl:for-each>
    </xsl:template>


</xsl:stylesheet>
