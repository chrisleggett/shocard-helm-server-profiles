
async function doPoll(code){
    await sleep(2000);
    $.post('/ext/shocard/messagestatus', 'code=' + code , function(data) {
        console.log("Current status: " + data.messageStatus);
        if(data.messageStatus == "LoginSuccess"){
            document.forms[0].submit();
        }
        if(data.KYCStatus == "RegistrationSuccess"){
            document.forms[0].submit();
        }
        setTimeout(doPoll(code),30000);
    });
}

function sleep(ms) {
  return new Promise(resolve => setTimeout(resolve, ms));
}