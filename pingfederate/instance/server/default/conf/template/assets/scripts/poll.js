async function doPoll(logincode, regcode){
    await sleep(2000);

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
        if(data.action == "proceed"){
            if(modal.style.display == "block"){
                document.getElementById("pf.submit").value = "register_proceed";
            } else {
                document.getElementById("pf.submit").value = "login_proceed";
            }
            document.forms[0].submit();
        } else if(data.action == "error"){
            document.getElementById("pf.submit").value = "error";
            document.forms[0].submit();
        }
        setTimeout(doPoll(logincode,regcode),30000);
    });
}

function sleep(ms) {
  return new Promise(resolve => setTimeout(resolve, ms));
}