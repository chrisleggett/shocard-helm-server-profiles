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
        console.log("Current status: " + data.messageStatus);
        if(data.messageStatus == "LoginSuccess"){
            document.forms[0].submit();
        }
        if(data.KYCStatus == "RegistrationSuccess"){
            document.forms[0].submit();
        }
        setTimeout(doPoll(logincode,regcode),30000);
    });
}

function sleep(ms) {
  return new Promise(resolve => setTimeout(resolve, ms));