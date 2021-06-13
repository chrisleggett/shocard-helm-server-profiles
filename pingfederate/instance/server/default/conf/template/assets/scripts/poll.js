function doPoll(logincode, regcode){

    var modal = document.getElementById("registrationModal");
    var code = "";

    if(modal.style.display == "block"){
        code = regcode;
    } else {
        code = logincode;
    }
    console.log("code: " + code );

    $.post('/ext/shocard/messagestatus', 'code=' + code , function(data) {
        console.log("Current status: " + data.action);
        if(data.action != "poll"){
            document.getElementById("pf.submit").value = data.action;
            document.forms[0].submit();
        }
        setTimeout(doPoll(logincode,regcode),30000);
    });
}


function doVerifyPoll(){

    $.get('/ext/shocard/verifystatus', function(data) {
        console.log("Current status: " + data.action);
        if(data.action != "poll"){
            var x = document.getElementById("verifyDiv");
            x.style.display = "none"
            var y = document.getElementById("claimDiv");
            y.style.display = "inline-block";
            window.setTimeout(document.forms[0].submit.bind(document.forms[0]), 3000);
        }
        setTimeout(doVerifyPoll(),30000);
    });
}

function sleep(ms) {
  return new Promise(resolve => setTimeout(resolve, ms));
}