/*******************************************************************************
 * Copyright (C) 2010 Ping Identity Corporation All rights reserved.
 * 
 * This software is licensed under the Open Software License v2.1 (OSL v2.1).
 * 
 * A copy of this license has been provided with the distribution of this
 * software. Additionally, a copy of this license is available at:
 * http://opensource.org/licenses/osl-2.1.php
 *  
 ******************************************************************************/

//Common javascript routines

function createSSOUrl(url) 
{
    var isPassive = document.getElementById("IsPassive");
    if(isPassive.checked == true) {
        url += "&IsPassive=true";
    }

    var spAdapterId = document.getElementById("SpAdapterId");
    var spAdapterIdValue = spAdapterId.options[spAdapterId.selectedIndex].value;
    if(spAdapterIdValue != "") {
        url += "&SpSessionAuthnAdapterId="+spAdapterIdValue;
    }

    var isForceAuthn = document.getElementById("ForceAuthn");
        if(isForceAuthn.checked == true) {
            url += "&ForceAuthn=true";
        }
    
    return url;
}   

function createSSOLink(errorPageUrl) 
{
    var url = createSSOUrl(document.getElementById('PartnerIdpId').value);
    

    if (document.getElementById('SsoInErrorResource').checked)
    {
        url += "&InErrorResource=" + encodeURIComponent(errorPageUrl + "Error during idp-initiated SSO");
    }

    document.getElementById('ssolink').value = url;
    return url;
}

function createSLOLink(url, errorPageUrl) 
{

    if (document.getElementById('SloInErrorResource').checked)
    {
        url += "&InErrorResource=" + encodeURIComponent(errorPageUrl + "Error during idp-initiated SLO")

    }

    document.getElementById('slolink').value = url;

}

function copySsoUrl()
{
    var url = document.getElementById('ssolink');
    url.select();
    document.execCommand("copy");
}

function copySloUrl()
{
    var url = document.getElementById('slolink');
    url.select();
    document.execCommand("copy");
}