<%--
*******************************************************************************
* Copyright (C) 2010 Ping Identity Corporation All rights reserved.
*
* This software is licensed under the Open Software License v2.1 (OSL v2.1).
*
* A copy of this license has been provided with the distribution of this
* software. Additionally, a copy of this license is available at:
* http://opensource.org/licenses/osl-2.1.php
*
******************************************************************************
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@ page import = "java.io.File" %>
<%@ page import = "java.io.IOException" %>
<%@ page import = "java.io.InputStream" %>
<%@ page import = "java.io.FileInputStream" %>
<%@ page import = "java.util.Calendar" %>
<%@ page import = "com.pingidentity.sample.sp.manage.ConfigManager" %>
<%@ page import = "com.pingidentity.sample.sp.manage.SampleAppConfig" %>
<%@ page import = "com.pingidentity.sample.sp.manage.SampleConstants" %>
<%@ page import = "java.util.Properties" %>
<%@ page import = "com.pingidentity.sample.util.URLUtil" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    response.setHeader("Cache-Control","no-cache");
    response.setHeader("Pragma","no-cache");
    response.setHeader("Expires","0");

    ConfigManager configManager = ConfigManager.getInstance();
    Properties idpConfigProperties = null;
    if (configManager != null)
    {
        SampleAppConfig sampleAppConfig = configManager.getConfig();
        if (sampleAppConfig != null)
        {
            idpConfigProperties = sampleAppConfig.getSpConfig();
        }
    }
    
    // Get all of the fields from the config file for display

    String attributeNamesList = idpConfigProperties.getProperty(SampleConstants.SAMPLE_ATTRS_NAMES_LIST);

    
    String useSSL = idpConfigProperties.getProperty(SampleConstants.SAMPLE_USE_SSL);
    
    String pfBaseUrl = "true".equalsIgnoreCase(useSSL) ? "https://" : "http://";
    
    String hostPF = idpConfigProperties.getProperty(SampleConstants.SAMPLE_PF_HOST);
    
    pfBaseUrl += hostPF;
    pfBaseUrl += ":";
    
    String port = idpConfigProperties.getProperty(SampleConstants.SAMPLE_PF_HTTPS_PORT);

    pfBaseUrl += port;

    String pfContextPath = idpConfigProperties.getProperty(SampleConstants.SAMPLE_PF_CONTEXT_PATH);

    pfBaseUrl += pfContextPath;

    String wsUname = idpConfigProperties.getProperty(SampleConstants.SAMPLE_PF_WS_UNAME);
    String wsPwd = idpConfigProperties.getProperty(SampleConstants.SAMPLE_PF_WS_PWD);

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3c.org/TR/1999/REC-html401-19991224/loose.dtd">
<html>
    <head>
        <META http-equiv="Content-Type" content="text/html; charset=utf-8">
        <LINK media="screen" href="<%=request.getContextPath()%>/images/main.css" type=text/css rel=stylesheet>
        <link href="<%=request.getContextPath()%>/images/favicon.ico" rel="shortcut icon" type="image/x-icon"/>
        <title>Java Integration Kit Sample Configuration</title>
        <script type="text/javascript" src="scripts/common.js"></script>
        <script type="text/javascript" src="scripts/jquery-2.2.0.min.js"></script>
        <script type="text/javascript">
            function insertFilename(obj) {
                $('#' + obj.id + '-file-name').html(getFilename(obj));
            }

            function getFilename(obj) {
                var filename = obj.value;
                var lastIndex = filename.lastIndexOf("\\");
                if (lastIndex >= 0) {
                    filename = filename.substring(lastIndex + 1);
                }
                return document.createTextNode(filename);
            }
        </script>
    </head>

    <body>
    <div class="body-container">
        <div id="" class="ping-body-container">
            <div class="header-block">
                <div class="header">SP Application Configuration</div>
            </div> <!-- header-block -->

            <div class="config-container">
                <form name="config" method="POST" enctype="multipart/form-data" action="<%= URLUtil.getConfigOptionsFormPostUrl(request)%>" >

                    <%  
                        if (request.getParameter(SampleConstants.SAMPLE_PF_HOST) != null) {         
                    %>
                            <div class="config-save-success">Configuration successfully saved.</div>
                    <%
                        } else {
                            String errorMessage = request.getParameter(SampleConstants.ATTRIB_NAME_ERROR);
                            if (errorMessage != null) {
                    %>

                            <div class="config-save-failure"><c:out value="<%= errorMessage %>" /></div>

                    <%
                            }
                        }
                    %>
                    <div class="grid-container">
                        <div class="ping-input grid-a">
                            <label class="ping-input-label">PF Base URL
                                <div class="ping-input-container">
                                   <input type="text" name="<%= SampleConstants.SAMPLE_PF_HOST %>" id="<%= SampleConstants.SAMPLE_PF_HOST %>" value="<%= pfBaseUrl %>">
                                </div>
                            </label>
                        </div>

                        <div class="ping-input grid-b">
                            <label class="ping-input-label">PF SSO Directory Service Id
                                <div class="ping-input-container">
                                    <input type="text" name="<%= SampleConstants.SAMPLE_PF_WS_UNAME %>" id="<%= SampleConstants.SAMPLE_PF_WS_UNAME %>" value="<%= wsUname %>"/>
                                </div>
                            </label>
                        </div>

                        <div class="ping-input grid-c">
                            <label class="ping-input-label">PF SSO Directory Service Shared Secret
                                <div class="ping-input-container">
                                    <input type="password" name="<%= SampleConstants.SAMPLE_PF_WS_PWD %>" id="<%= SampleConstants.SAMPLE_PF_WS_PWD %>" value="<%= wsPwd %>">
                                </div>
                            </label>
                        </div>

                        <div class="ping-input grid-d">
                            <label class="ping-input-label">Attribute Names List
                                <div class="ping-input-container attr-tooltip">
                                    <input type="text" name="<%= SampleConstants.SAMPLE_ATTRS_NAMES_LIST %>" id="<%= SampleConstants.SAMPLE_ATTRS_NAMES_LIST %>" value="<%= attributeNamesList %>"/>
                                    <span class="attr-tooltip-text">Attributes are pipe delimited.</span>
                                </div>
                            </label>
                        </div>
        
                        <div class="ping-input grid-e">
                            <label class="ping-input-label" for="mptest">SP OpenToken Config File</label>
                            <div class="ping-file-input-container">
                                <label class="input-file-upload" >
                                    <input name="mptest" onchange="insertFilename(this)" id="mptest" type="file"> <span class="file-upload">Choose File</span>
                                    <span id="mptest-file-name">No change</span>
                                </label>
                            </div>
                        </div>

                    </div> <!-- grid-container -->

                    <div class="ping-input-container">
                        <input id="saveConfig" class="table-button" type="submit" value="Save"/>
                    </div> <!-- ping-input-container -->

                    <div class="ping-input-container">
                        <div class="cancel">
                            <a href="<c:out value="<%= URLUtil.getServiceProviderHomeUrl(request) %>" />">Cancel</a>
                        </div>
                    </div>

                </form>
            </div> <!-- config-container -->

            
        </div> <!-- ping-body-container -->
        <div class="ping-footer-container">
            <div class="ping-footer">
                <div class="ping-credits"></div>
                <div class="ping-copyright">Copyright ?? 2003-2020. Ping Identity Corporation. All rights reserved.</div>
            </div> <!-- ping-footer -->
        </div> <!-- ping-footer-container -->

    </div> <!-- body-container -->
    
        
    </body>
</html>
