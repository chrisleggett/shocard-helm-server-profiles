async function doPoll(logincode, regcode){
    await sleep(4000);

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
        doPoll(logincode,regcode);
        //setTimeout(doPoll(logincode,regcode),30000);
    });
}


async function doVerifyPoll(){
    await sleep(4000);

    var y = document.getElementById("claimDiv");
    var x = document.getElementById("verifyDiv");

    if(y.style.display == "inline-block"){
        document.forms[0].submit();
    } else {
        $.get('/ext/shocard/verifystatus', function(data) {
            console.log("Current status: " + data.action);
            if(data.action != "poll"){
                x.style.display = "none"
                y.style.display = "inline-block";
                window.setTimeout(document.forms[0].submit.bind(document.forms[0]), 6000);
            }
            doVerifyPoll();
            //setTimeout(doVerifyPoll(),30000);
        });
    }
}

function sleep(ms) {
  return new Promise(resolve => setTimeout(resolve, ms));
}